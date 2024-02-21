//
//  SDKController.m
//  LXBSDK
//
//  Created by pub on 2024/1/30.
//

#import "SDKController.h"
#import "NetworkController.h"
#import "UserCenterController.h"
#import "PayController.h"
#import "PostArgUtils.h"
#import "RealNameController.h"
#import "AppleLoginController.h"
#import "AFNet.h"
#import "BindExtend.h"
#import "ReqOverseaBind.h"
#import "UserCenterView.h"
static SDKController* instance;

@interface SDKController ()

@property(nonatomic,assign)ThirdPartyLoginType loginType;

@end

@implementation SDKController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self myInit];
    }
    return self;
}

+ (SDKController *)getInstance{
    if(instance == nil){
        instance = [[SDKController alloc] init];
    }
    return instance;
}

- (void)myInit{
    self.loginType = ThirdPartyLoginNone;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handerAppleLogin:) name:AppleLoginNotiName object:nil];
}

- (void)sdkInit{
    [NetworkController networkServiceInit];
    [PayController getInstance];
}

- (void)login{
    
    ReqVisitor *req = [[ReqVisitor alloc] init];
//    req.device_id = @"123456";
//    req.uuid = @"123465";
    req.device_id = @"bowen1234";
    req.uuid = @"bowen1234";
    
    NSInteger cId = [U8_CHANNEL intValue];//;
    req.channel_id = cId;
    
    __weak typeof(self)weakSelf = self;
    [UserCenterController visitorReq:req success:^(id  _Nonnull responseObject) {
        [weakSelf handlerLoginSucc:responseObject];
    } failure:^(NSError * _Nonnull error) {
        
    }];

    
}

- (void)createOrder{
    ReqPayCreate *req = [[ReqPayCreate alloc] init];
    req.account_id = [DataHub getInstance].useModel.account_id;
    req.amount = 100;
    req.currency = @"CNY";
    req.cash_fee = 100;
    req.cash_currency = @"CNY";
    req.body = @"body";
    req.detail = @"detaildetaildetaildetail";
    req.platform = @"apple";
    req.trade_type = @"APP";
    req.game_id = [U8_GAME_ID longLongValue];
    //游戏服id
    req.server_id = 1;
    //必须穿
    req.notify_url = @"";
    //必须穿
    req.extension = @"ext";
    //必须穿
    req.device_id = @"";
    req.product_id = @"12yuan";
    
    
    DDLog(@"%@",req.mj_keyValues);
    [PayController ceratePayOrder:req success:^(id  _Nonnull responseObject) {
        DDLog(@"");
        } failure:^(NSError * _Nonnull error) {
            DDLog(@"");
        }];
}


- (void)test{
    ReqVisitor *req = [[ReqVisitor alloc] init];
    req.device_id = @"123456";
    req.uuid = @"123465";
    NSInteger cId = [U8_CHANNEL intValue];
    NSDictionary *dic = req.mj_keyValues;
}

- (void)realName{
    ReqRealName *req = [[ReqRealName alloc] init];
    req.app_id = [U8_GAME_ID longLongValue];
    req.channel_id = [U8_CHANNEL longLongValue];
    req.account_id = [DataHub getInstance].useModel.account_id;
    req.realname = @"张胜";
    req.id_card = @"422128197201131431";
    
    [RealNameController realName:req success:^(id  _Nonnull responseObject) {
        DDLog(@"xx");
        } failure:^(NSError * _Nonnull error) {
            DDLog(@"xxxx");
        }];
}

- (void)payItem{
    [[PayController getInstance] QueryInfo:@"12yuan"];
}

- (void)finishLostOrder{
    [[PayController getInstance] finishLostOrder];
}

- (void)buyProduct{
    [[PayController getInstance] buyProduct:@"12yuan"];
}

- (void)buyProduct2{

}

- (void)launchAppleLogin{
    self.loginType = ThirdPartyLogin;
    [[AppleLoginController getInstance] launchLogin];
}

- (void)launchAppleBind{
    self.loginType = ThirdPartyLoginBind;
    [[AppleLoginController getInstance] launchLogin];
}

- (void)autoLogin{
    ReqAutoLogin *req = [[ReqAutoLogin alloc] init];
    req.device_id = [KeychainController loadLXBLoginDevicesId];
    req.uuid = [KeychainController loadLXBLoginUUID];
    req.access_token = [KeychainController loadAccessToken];
    
    NSString *accStr = [KeychainController loadAccount];
    if(accStr != nil){
        req.account_id =  [accStr longLongValue];
    }
    else{
        DDLog(@"get local accountid error auto login not yet");
        return;
    }
    
    __weak typeof(self)weakSelf = self;
    [UserCenterController autoLoginReq:req success:^(id  _Nonnull responseObject) {
        [weakSelf handlerLoginSucc:responseObject];
        } failure:^(NSError * _Nonnull error) {
            DDLog(@"xxx");
        }];
}

- (void)handlerLoginSucc:(ReqVisitor *)info{
    ResVisitor *res = (ResVisitor *)info;
    //save use model
    [DataHub getInstance].useModel = res;
    //save token
    [KeychainController saveAccessToken:res.access_token];
    long acc = res.account_id;
    //save accountid
    NSNumber *longNumber = [NSNumber numberWithLong:acc];
    [KeychainController saveAccount:[longNumber stringValue]];
    // save deviceid
    [KeychainController saveDevices:res.device_id];
    //save uuid
    [KeychainController saveUuid:res.uuid];
    //fire login event
    [[NSNotificationCenter defaultCenter] postNotificationName:LoginNotiName object:[DataHub getInstance].useModel];
}

- (void)handerAppleLogin:(NSNotification *)noti{
    BindExtend *bind = (BindExtend *)noti.object;
    NSString *ms = [bind mj_JSONString];
    __weak typeof(self) weakSelf = self;
    if(self.loginType == ThirdPartyLoginBind){
        ReqOverseaBind *reqBind = [[ReqOverseaBind alloc] init];
        reqBind.account_id = [DataHub getInstance].useModel.account_id;
        reqBind.platform_type = ApplePlaformName;
        reqBind.extend = ms;
        [UserCenterController overseaBind:reqBind sucess:^(id  _Nonnull responseObject) {
            [weakSelf handleBindSucc: responseObject];
            } failure:^(NSError * _Nonnull error) {
                DDLog(@"xxx");
            }];
    }
    else if (self.loginType == ThirdPartyLogin){
        ReqThirdPartyLogin *req = [[ReqThirdPartyLogin alloc] init];
        req.device_id = [KeychainController loadLXBLoginDevicesId];
        req.channel_id = [U8_CHANNEL longLongValue];
        req.platform_type = ApplePlaformName;
        req.extend = ms;
        [UserCenterController thirdPartyLogin:req sucess:^(id  _Nonnull responseObject) {
                [weakSelf handleBindSucc: responseObject];
                } failure:^(NSError * _Nonnull error) {
                    DDLog(@"xxx");
                }];
    }
    else{
        
    }
}




- (void)handleBindSucc:(ResVisitor *)useData{
    [DataHub getInstance].useModel = useData;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)showCenter{
    NSString *title = getLocalString(@"user_account_ui_usercenter");
    UserCenterView *view = [[UserCenterView alloc] initTitle:title isRightCloseBtn:RightClose];
    UIWindow *window = [UIApplication sharedApplication].windows[0];
    [window addSubview:view];
//    UIColor *color = [UIColor blackColor];
//    view.backgroundColor = [color colorWithAlphaComponent:0.5];
}

- (void)initBaseView{

}

@end
