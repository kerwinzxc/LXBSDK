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
- (void)openCenterView;
- (void)openWebView:(NSString *)urlString;
- (void)AdInitAfterControllerDidInit:(UIViewController *)vController adID:(NSString *)adId;
- (void)showRewardedAd;
- (void)openTestView;
@end


NS_ASSUME_NONNULL_END
