//
//  FacebookLoginController.h
//  LXBSDK
//
//  Created by pub on 2024/3/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FacebookLoginController : NSObject
+ (FacebookLoginController *)getInstance;

- (void)facebookLogin;
@end

NS_ASSUME_NONNULL_END
