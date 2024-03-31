//
//  GoogleLoginController.h
//  LXBSDK
//
//  Created by pub on 2024/3/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoogleLoginController : NSObject
+ (GoogleLoginController *)getInstance;

- (void)googleLogin;
@end

NS_ASSUME_NONNULL_END
