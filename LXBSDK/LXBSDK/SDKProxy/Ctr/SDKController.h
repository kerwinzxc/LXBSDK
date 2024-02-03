//
//  SDKController.h
//  LXBSDK
//
//  Created by pub on 2024/1/30.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface SDKController : NSObject

+ (void)sdkInit;
+ (void)login;
+ (void)test;
+ (void)createOrder;
+ (void)realName;
+ (void)payItem;
+ (void)queryLostOrder;
@end


NS_ASSUME_NONNULL_END
