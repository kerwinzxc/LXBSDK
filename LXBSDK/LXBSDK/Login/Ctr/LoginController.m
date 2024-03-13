//
//  LoginController.m
//  LXBSDK
//
//  Created by pub on 2024/3/13.
//

#import "LoginController.h"
#import "ReqAutoLogin.h"
#import "UserCenterController.h"
#import "BindExtend.h"
#import "AppleLoginController.h"
@implementation LoginController

static LoginController* instance;
+ (LoginController *)getInstance{
    if(instance == nil){
        instance = [[LoginController alloc] init];
    }
    return instance;
}

- (void)login{
    NSString *token = [KeychainController loadAccessToken];
    if(token == nil || [token isEqual:@""]){
        [self loginWithToken];
    }
    else{
        [self loginWithDeviceId];
    }
}

- (void)loginWithDeviceId{
    ReqVisitor *req = [[ReqVisitor alloc] init];
//    req.device_id = @"123456";
//    req.uuid = @"123465";
    req.device_id = @"bowen1234";
    req.uuid = @"bowen1234";
    
    NSInteger cId = [U8_CHANNEL intValue];
    req.channel_id = cId;
    __weak typeof(self)weakSelf = self;
    [UserCenterController visitorReq:req success:^(id  _Nonnull responseObject) {
        [weakSelf handlerLoginSucc:responseObject];
    } failure:^(NSError * _Nonnull error) {
    }];
}


- (void)loginWithToken{
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
            //DDLog(@"xxx");
            // 登录失败走游客登录
            [self loginWithDeviceId];
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
    if([SDKModel getInstance].loginType == ThirdPartyLoginBind){
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
    else if ([SDKModel getInstance].loginType == ThirdPartyLogin){
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

- (void)innerInit{
    [SDKModel getInstance].loginType = ThirdPartyLoginNone;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handerAppleLogin:) name:AppleLoginNotiName object:nil];
}


- (void)launchAppleLogin{
    [SDKModel getInstance].loginType = ThirdPartyLogin;
    [[AppleLoginController getInstance] launchLogin];
}

- (void)launchAppleBind{
    [SDKModel getInstance].loginType = ThirdPartyLoginBind;
    [[AppleLoginController getInstance] launchLogin];
}

@end
