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
- (void)sdkInit;
- (void)login;
- (void)test;
- (void)createOrder;
- (void)realName;
- (void)payItem;
- (void)finishLostOrder;
- (void)appleBuy;
- (void)launchAppleLogin;
- (void)launchAppleBind;
- (void)autoLogin;
- (void)showCenter;
- (void)initBaseView;
- (void)openWebView:(NSString *)urlString;
- (void)openLoginView;
- (void)openKeFuView;
- (void)AdInitAfterControllerDidInit:(UIViewController *)vController adID:(NSString *)adId;
- (void)showRewardedAd;
@end


NS_ASSUME_NONNULL_END
