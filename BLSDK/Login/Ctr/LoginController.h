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
- (void)login;
- (void)loginWithDeviceId;
- (void)youkeLogin;

- (void)launchApple:(NSInteger) mtype;
- (void)launchGoogle:(NSInteger) mtype;
- (void)launchFb:(NSInteger) mtype;

- (void)postLoginFail:(NSString *)info;
@end

NS_ASSUME_NONNULL_END
