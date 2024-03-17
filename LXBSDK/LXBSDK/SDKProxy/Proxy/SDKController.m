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
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <GoogleSignIn/GoogleSignIn.h>
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

- (void)AdInitAfterControllerDidInit:(UIViewController *)vController adID:(NSString *)adId{
    [GoogleAdWarper.sharedInstance googleAdInitAfterControllerDidInit:vController adID:adId];
    [SDKModel getInstance].rootController = vController;
}

- (void)showRewardedAd{
    [GoogleAdWarper.sharedInstance showRewardedAd];
}

- (void)openTestView{
    [ViewHub openTestView];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions sdk:(NSDictionary *)arg{
    
    SDKArg *sdkArg = [SDKArg new];
    sdkArg.U8_GAME_ID = arg[@"U8_GAME_ID"];
    sdkArg.U8_PACKAGE_ID = arg[@"U8_PACKAGE_ID"];
    sdkArg.U8_CHANNEL = arg[@"U8_CHANNEL"];
    sdkArg.U8_PRIVATE_KEY = arg[@"U8_PRIVATE_KEY"];
    sdkArg.kApiPrefix = arg[@"kApiPrefix"];
    
    
    [SDKModel getInstance].sdkArg = sdkArg;
    [NetworkController networkServiceInit];
    [PayController getInstance];
    [LoginController getInstance];
    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    BOOL handled;
    handled = [GIDSignIn.sharedInstance handleURL:url];
    if(handled){
        return YES;
    }
    
    handled = [FBSDKApplicationDelegate.sharedInstance application:app openURL:url sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey] annotation:options[UIApplicationLaunchOptionsAnnotationKey]];
    if(handled){
        return YES;
    }
    return NO;
}

- (void)showToast:(NSString *)content{
    [LXBHelper showToast:content];
}

@end
