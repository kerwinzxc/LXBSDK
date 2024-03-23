//
//  AppleLoginController.h
//  LXBSDK
//
//  Created by pub on 2024/2/5.
//

#import <Foundation/Foundation.h>
#import <AuthenticationServices/AuthenticationServices.h>
#import "BindExtend.h"
NS_ASSUME_NONNULL_BEGIN

@interface AppleLoginController : NSObject<ASAuthorizationControllerPresentationContextProviding, ASAuthorizationControllerDelegate>
- (void)launchLogin;

+ (AppleLoginController *)getInstance;
@end

NS_ASSUME_NONNULL_END
