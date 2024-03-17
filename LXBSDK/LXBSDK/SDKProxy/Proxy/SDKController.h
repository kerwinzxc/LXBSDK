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
- (void)AdInitAfterControllerDidInit:(UIViewController *)vController adID:(NSString *)adId;
- (void)showRewardedAd;
- (void)openTestView;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions sdk:(NSDictionary *)arg;

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options;
- (void)showToast:(NSString *)content;
@end


NS_ASSUME_NONNULL_END
