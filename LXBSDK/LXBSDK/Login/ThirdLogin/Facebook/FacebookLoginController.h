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

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options;


@end

NS_ASSUME_NONNULL_END
