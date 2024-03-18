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
    
    
    //static NSString *const U8_GAME_ID = @"1";
    //static NSString *const U8_PACKAGE_ID = @"7047";
    //static NSString *const U8_CHANNEL = @"1111111235";
    //static NSString *const U8_PRIVATE_KEY = @"c6075961d425973f031b75c9f4e09ce9";
    NSDictionary *dic = @{
        @"U8_GAME_ID": @"4",
        @"U8_PACKAGE_ID": @"7051",
        @"U8_CHANNEL": @"4",
        @"U8_PRIVATE_KEY":@"916a817cb27573c0915ef0fe7ade1d32",
        @"kApiPrefix":@"https://gmshwtest.boomgames.top/",
    };
    
    //@"https://gmstest.boomgames.top/";
    //@"https://gms.boomgames.top/"
    [[SDKController getInstance] application:application didFinishLaunchingWithOptions:launchOptions sdk:dic];
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
