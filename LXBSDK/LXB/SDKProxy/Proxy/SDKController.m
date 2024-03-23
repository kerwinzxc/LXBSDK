//
//  SDKController.m
//  LXBSDK
//
//  Created by pub on 2024/1/30.
//

#import "SDKController.h"
#import "NetworkController.h"
#import "PayController.h"
#import "GoogleAdWarper.h"
#import "LoginController.h"
#import <GoogleSignIn/GoogleSignIn.h>
#import "AdjustController.h"
#import <ThinkingSDK/ThinkingSDK.h>
#import "FirebaseController.h"
#import "FacebookLoginController.h"
static SDKController* instance;


@interface SDKController ()


@end

@implementation SDKController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self innerInit];
    }
    return self;
}

+ (SDKController *)getInstance{
    if(instance == nil){
        instance = [[SDKController alloc] init];
    }
    return instance;
}

- (void)innerInit{
   
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)openCenterView{
    [ViewHub openCenterView];
}

- (void)openWebView:(NSString *)urlString{
    [ViewHub openWebView:urlString title:@"xxxx"];
}

- (void)AdInitAfterControllerDidInit:(UIViewController *)vController{
    [GoogleAdWarper.sharedInstance googleAdInitAfterControllerDidInit:vController adID:[SDKModel getInstance].sdkArg.googleAdUnitId];
    [SDKModel getInstance].rootController = vController;
}

- (void)showRewardedAd{
    [GoogleAdWarper.sharedInstance showRewardedAd];
}

- (void)openTestView{
    [ViewHub openTestView];
}

- (void)sdkLogin{
    [[LoginController getInstance] login];
}

- (void)sdkLogout{
    if([DataHub getInstance].userModel == nil){
        [LXBHelper showToast:@""];
        return;
    }
    else{
        [[NSNotificationCenter defaultCenter] postNotificationName:LogoutNotiName object:nil];
    }
    
}

- (void)lxbPay:(NSDictionary *)dic{
    [[PayController getInstance] lxbPay:dic];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    [NetworkController networkServiceInit];
    [self shushuInit];
    [PayController getInstance];
    [LoginController getInstance];
    [[FirebaseController getInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    [[FacebookLoginController getInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    [[AdjustController getInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    BOOL handled;
    handled = [GIDSignIn.sharedInstance handleURL:url];
    if(handled){
        return YES;
    }
    
    handled = [[FacebookLoginController getInstance] application:app openURL:url options:options];
    if(handled){
        return YES;
    }
    return NO;
}

- (void)showToast:(NSString *)content{
    [LXBHelper showToast:content];
}

- (void)sdkArgInit:(NSDictionary *)arg{
    SDKArg *sdkArg = [SDKArg new];
    sdkArg.U8_GAME_ID = arg[@"U8_GAME_ID"];
    sdkArg.U8_PACKAGE_ID = arg[@"U8_PACKAGE_ID"];
    sdkArg.U8_CHANNEL = arg[@"U8_CHANNEL"];
    sdkArg.U8_PRIVATE_KEY = arg[@"U8_PRIVATE_KEY"];
    sdkArg.kApiPrefix = arg[@"kApiPrefix"];
    sdkArg.googleAdUnitId = arg[@"googleAdUnitId"];
    sdkArg.adJustAppToken = arg[@"adJustAppToken"];
    sdkArg.adJustEnvironment = arg[@"adJustEnvironment"];
    sdkArg.shushuAppid = arg[@"shushuAppid"];
    sdkArg.shushuUrl = arg[@"shushuUrl"];
    sdkArg.shushuEnvironment = arg[@"shushuEnvironment"];
    [SDKModel getInstance].sdkArg = sdkArg;
}

- (void)shushuInit{
    NSString *appid = [SDKModel getInstance].sdkArg.shushuAppid;
    NSString *url = [SDKModel getInstance].sdkArg.shushuUrl;
    
    TDConfig *config = [[TDConfig alloc] init];
    config.appid = appid;
    config.serverUrl = url;
    if([[SDKModel getInstance].sdkArg.shushuEnvironment isEqual:@"1"]){
        config.mode = TDModeDebug;
    }
    [TDAnalytics startAnalyticsWithConfig:config];
    
    [TDAnalytics setDistinctId:[TDAnalytics getDeviceId]];
    
    NSLog(@"shushuid %@", [TDAnalytics getDeviceId]);
}

#pragma mark - firebase 上报

- (void)firebaseCreateAccount{
    [[FirebaseController getInstance] createAccount];
}
- (void)firebaseCreateRole{
    [[FirebaseController getInstance] createRole];
}
- (void)firebaseEnterGame{
    [[FirebaseController getInstance] enterGame];
}
- (void)firebaseLevelUp:(NSString *)level{
    [[FirebaseController getInstance] levelUp:level];
}


#pragma mark -  adjust  上报

- (void)adjustTrackEventWithToken:(NSString *)token{
    [[AdjustController getInstance] trackEventWithToken:token];
}

- (void)trackPurchase:(NSString *)token amount:(int)amount currency:(NSString *)currency{
    [[AdjustController getInstance] purchaseWithToken:token amount:amount currency:currency];
}

@end
