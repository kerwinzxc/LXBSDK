//
//  LoginController.h
//  LXBSDK
//
//  Created by pub on 2024/3/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginController : NSObject
+ (LoginController *)getInstance;
- (void)loginWithDeviceId;

@end

NS_ASSUME_NONNULL_END
