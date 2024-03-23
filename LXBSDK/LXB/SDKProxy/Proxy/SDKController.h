//
//  SDKController.h
//  LXBSDK
//
//  Created by pub on 2024/1/30.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface SDKController : NSObject
+ (SDKController *)getInstance;
- (void)openCenterView;
- (void)openWebView:(NSString *)urlString;
- (void)AdInitAfterControllerDidInit:(UIViewController *)vController;
- (void)showRewardedAd;
- (void)openTestView;
- (void)sdkLogin;
- (void)sdkLogout;
- (void)lxbPay:(NSDictionary *)dic;



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options;
- (void)showToast:(NSString *)content;
- (void)sdkArgInit:(NSDictionary *)arg;


#pragma firebase 上报
- (void)firebaseCreateAccount;
- (void)firebaseCreateRole;
- (void)firebaseEnterGame;
- (void)firebaseLevelUp:(NSString *)level;

#pragma adjust 上报
- (void)adjustTrackEventWithToken:(NSString *)token;
- (void)trackPurchase:(NSString *)token amount:(int)amount currency:(NSString *)currency;
@end


NS_ASSUME_NONNULL_END
