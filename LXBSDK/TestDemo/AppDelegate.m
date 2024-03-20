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
    
    NSDictionary *dic = @{
        @"U8_GAME_ID": @"4",
        @"U8_PACKAGE_ID": @"7051",
        @"U8_CHANNEL": @"4",
        @"U8_PRIVATE_KEY":@"916a817cb27573c0915ef0fe7ade1d32",
        @"kApiPrefix":@"https://gmshwtest.boomgames.top/",
        @"googleAdUnitId":@"ca-app-pub-3940256099942544/1712485313",
        
        @"adJustAppToken":@"lmnre3uzx5a8",
        //1 是测试环境 其他真是环境
        @"adJustEnvironment":@"1",
        
        //  //d973b221c3104f1c917a796b013dd090
        @"shushuAppid":@"cbf0e9d25f0a4e5db63ee20e3b574037",
        
        //shushu.boomgames.top:5000
        @"shushuUrl":@"https://ss-gat.hnminigames.fun:5000",
        //1 是测试环境 其他真是环境
        @"shushuEnvironment":@"2",
        @"adjustPayToken":@"576c1d",
        @"adjustPayToken":@"",
        @"adjustPayToken":@"",
    };
    [[SDKController getInstance] sdkArgInit:dic];
    
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.rootViewController = [[ViewController alloc] init];
    [_window makeKeyAndVisible];
    
    //static NSString *const U8_GAME_ID = @"1";
    //static NSString *const U8_PACKAGE_ID = @"7047";
    //static NSString *const U8_CHANNEL = @"1111111235";
    //static NSString *const U8_PRIVATE_KEY = @"c6075961d425973f031b75c9f4e09ce9";
    //@"https://gmstest.boomgames.top/";
    //@"https://gms.boomgames.top/"
   
    
    NSLog(@"didFinishLaunchingWithOptionsdidFinishLaunchingWithOptionsdidFinishLaunchingWithOptions");
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
