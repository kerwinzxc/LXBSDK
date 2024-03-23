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
#import "GoogleLoginController.h"
#import "FacebookLoginController.h"

@interface  LoginController()


// 0 使用token 登录
// 1 游客用设备号登录
// 2 使用界面用户自己选择
@property(nonatomic, assign)int loginInterface;
@end

@implementation LoginController

static LoginController* instance;
+ (LoginController *)getInstance{
    if(instance == nil){
        instance = [[LoginController alloc] init];
        [instance innerInit];
    }
    return instance;
}

- (instancetype)init{
    self = [super init];
    self.loginInterface = 0;
    return self;
}

- (void)login{
    if(self.loginInterface == 2){
        NSLog(@"jie mian denglu ");
        [ViewHub openLoginView];
    }
    else
    {
        NSString *token = [KeychainController loadAccessToken];
        if(token == nil || [token isEqual:@""]){
            self.loginInterface = 1;
            [self loginWithDeviceId];
        }
        else{
            [self loginWithTokenFun];
        }
    }
}

- (void)loginWithDeviceId{
    ReqVisitor *req = [[ReqVisitor alloc] init];
//    req.device_id = @"bowen1236";
//    req.uuid = @"bowen1236";
    req.device_id = [KeychainController loadLXBLoginDevicesId];
    req.uuid = req.device_id;
    
    NSInteger cId = [[SDKModel getInstance].sdkArg.U8_CHANNEL intValue];
    req.channel_id = cId;
    __weak __typeof(self)weakSelf = self;
    [UserCenterController visitorReq:req success:^(id  _Nonnull responseObject) {
        [weakSelf handlerLoginSucc:responseObject];
    } failure:^(NSError * _Nonnull error) {
    }];
}


- (void)loginWithTokenFun{
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
        self.loginInterface = 0;
        return;
    }
    
    [LXBHelper showLoading:getLocalString(@"login_logining")];
    
    __weak __typeof(self)weakSelf = self;
    [UserCenterController autoLoginReq:req success:^(id  _Nonnull responseObject) {
        [weakSelf handlerLoginSucc:responseObject];
        [LXBHelper hideLoading];
        } failure:^(NSError * _Nonnull error) {
            //DDLog(@"xxx");
            // 登录失败走游客登录
            [LXBHelper hideLoading];
            [self loginWithDeviceId];
        }];
}

- (void)handleBindSucc:(ResVisitor *)useData{
    ResVisitor *res = useData;
    //save use model
    [DataHub getInstance].userModel = res;
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
    [[NSNotificationCenter defaultCenter] postNotificationName:BindAccountNotiName object:[DataHub getInstance].userModel];
}

- (void)handlerLoginSucc:(ResVisitor *)info{
    self.loginInterface = 0;
    ResVisitor *res = info;
    //save use model
    [DataHub getInstance].userModel = res;
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
    [[NSNotificationCenter defaultCenter] postNotificationName:LoginSuccNotiName object:[DataHub getInstance].userModel];
}

- (void)handlerLogout:(NSNotification *)noti{
    self.loginInterface = 2;
}

- (void)handlerAppleLogin:(NSNotification *)noti{
    BindExtend *bind = (BindExtend *)noti.object;
    [self thirdLoginHub:bind thirdType:0];
}


- (void)handlerGoogleLogin:(NSNotification *)noti{
    BindExtend *bind = (BindExtend *)noti.object;
    [self thirdLoginHub:bind thirdType:1];
}

- (void)handlerFacebookLogin:(NSNotification *)noti{
    BindExtend *bind = (BindExtend *)noti.object;
    [self thirdLoginHub:bind thirdType:2];
}

- (void)thirdLoginHub:(BindExtend *)bind thirdType:(NSInteger)tType{
    
    __weak __typeof(self) weakSelf = self;
    if([SDKModel getInstance].loginType == ThirdPartyLoginBind){
        ReqOverseaBind *reqBind = [[ReqOverseaBind alloc] init];
        if(tType == 0){
            //苹果
            reqBind.platform_type = ApplePlaformName;
            reqBind.account_id = [DataHub getInstance].userModel.account_id;
            NSString *ms = [bind mj_JSONString];
            reqBind.extend = ms;
        }
        else if (tType == 1){
            //google
            reqBind.platform_type = GooglePlaformName;
            reqBind.account_id = [DataHub getInstance].userModel.account_id;
            NSString *ms = [bind mj_JSONString];
            reqBind.extend = ms;
        }
        else if (tType == 2){
            //Fb
            reqBind.platform_type = FbPlaformName;
            reqBind.account_id = [DataHub getInstance].userModel.account_id;
            NSString *ms = [bind mj_JSONString];
            reqBind.extend = ms;
        }
        [UserCenterController overseaBind:reqBind sucess:^(id  _Nonnull responseObject) {
            [weakSelf handleBindSucc: responseObject];
            } failure:^(NSError * _Nonnull error) {
                [self postLoginFail:[error description]];
            }];
    }
    else if ([SDKModel getInstance].loginType == ThirdPartyLogin){
        ReqThirdPartyLogin *req = [[ReqThirdPartyLogin alloc] init];
        req.device_id = [KeychainController loadLXBLoginDevicesId];
        //req.device_id = //@"bowen_fb";//[KeychainController loadLXBLoginDevicesId];
        req.channel_id = [[SDKModel getInstance].sdkArg.U8_CHANNEL longLongValue];
        if(tType == 0){
            //苹果
            bind.verify_type = 0;
            NSString *ms = [bind mj_JSONString];
            req.extend = ms;
            req.platform_type = ApplePlaformName;
        }
        else if (tType == 1){
            // google
            bind.verify_type = 0;
            NSString *ms = [bind mj_JSONString];
            req.extend = ms;
           
            req.platform_type = GooglePlaformName;
        }
        else if (tType == 2){
            bind.verify_type = 0;
            NSString *ms = [bind mj_JSONString];
            req.extend = ms;
            req.platform_type = FbPlaformName;
        }
       
        [UserCenterController thirdPartyLogin:req sucess:^(id  _Nonnull responseObject) {
                [weakSelf handlerLoginSucc:responseObject];
                } failure:^(NSError * _Nonnull error) {
                    [self postLoginFail:[error description]];
                }];
    }
}




- (void)innerInit{
    [SDKModel getInstance].loginType = ThirdPartyLoginNone;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlerAppleLogin:) name:AppleLoginNotiName object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlerGoogleLogin:) name:GoogleLoginNotiName object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlerFacebookLogin:) name:FacebookLoginNotiName object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlerLogout:) name:LogoutNotiName object:nil];
}


- (void)launchApple:(NSInteger) mtype{
    if(mtype == 0){
        [SDKModel getInstance].loginType = ThirdPartyLogin;
    }
    else{
        [SDKModel getInstance].loginType = ThirdPartyLoginBind;
    }
    
    [[AppleLoginController getInstance] launchLogin];
}



- (void)launchGoogle:(NSInteger) mtype{
    if(mtype == 0){
        [SDKModel getInstance].loginType = ThirdPartyLogin;
    }
    else{
        [SDKModel getInstance].loginType = ThirdPartyLoginBind;
    }
    [[GoogleLoginController getInstance] googleLogin];
}

- (void)launchFb:(NSInteger) mtype{
    if(mtype == 0){
        [SDKModel getInstance].loginType = ThirdPartyLogin;
    }
    else{
        [SDKModel getInstance].loginType = ThirdPartyLoginBind;
    }
    [[FacebookLoginController getInstance] facebookLogin];
}

- (void)youkeLogin{
    [self loginWithDeviceId];
}

- (void)postLoginFail:(NSString *)info{
    NSLog(@"---%@", info);
    if(self.loginInterface == 1){
        [KeychainController delecteAccessToken];
        self.loginInterface = 0;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:LoginFailNotiName object:info];
}

@end
