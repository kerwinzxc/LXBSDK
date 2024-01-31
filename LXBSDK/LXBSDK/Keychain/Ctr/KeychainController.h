//
//  KeychainController.h
//  LXBSDK
//
//  Created by pub on 2024/1/30.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>
#import "KeychainConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface KeychainController : NSObject
+ (void)savePasswordWithService:(NSString *)service account:(NSString *)account data:(NSString *)data;
+ (NSString *)loadPasswordWithService:(NSString *)service account:(NSString *)account;
@end

NS_ASSUME_NONNULL_END
