//
//  SDKController.h
//  LXBSDK
//
//  Created by pub on 2024/1/30.
//

#import <Foundation/Foundation.h>
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
- (void)buyProduct;
- (void)buyProduct2;
- (void)launchAppleLogin;
- (void)launchAppleBind;
- (void)autoLogin;
- (void)showCenter;
- (void)initBaseView;
@end


NS_ASSUME_NONNULL_END
