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
    [[SDKController getInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    return YES;
}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    BOOL handled = [[SDKController getInstance] application:app openURL:url options:options];
    
    if(handled){
        return YES;
    }
    return NO;
}




@end
