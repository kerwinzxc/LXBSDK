//
//  AppDelegate.m
//  TestDemo
//
//  Created by pub on 2024/1/30.
//

#import "AppDelegate.h"
#import <LXBSDK/LXBSDK.h>
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.rootViewController = [[ViewController alloc] init];
    [_window makeKeyAndVisible];
    [[SDKController getInstance] sdkInit];
    return YES;
}


#pragma mark - UISceneSession lifecycle




@end
