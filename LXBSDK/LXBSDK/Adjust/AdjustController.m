//
//  AdjustController.m
//  LXBSDK
//
//  Created by pub on 2024/3/18.
//

#import "AdjustController.h"
#import <Adjust/Adjust.h>
static AdjustController *instance;

@implementation AdjustController

+ (AdjustController *)getInstance{
    if(instance == nil){
        instance = [[AdjustController alloc] init];
        
    }
    
    return instance;
}

- (void)innerInit{
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    NSString *appToken = [SDKModel getInstance].sdkArg.adJustAppToken;
    NSString *e_bool = [SDKModel getInstance].sdkArg.adJustEnvironment;
    
    NSString  *environment = ADJEnvironmentProduction;
    if([e_bool isEqual:@"1"]){
        environment = ADJEnvironmentSandbox;
    }
    ADJConfig *adjustConfig = [ADJConfig configWithAppToken:appToken environment:environment];
    [adjustConfig setLogLevel:ADJLogLevelVerbose];
    [Adjust appDidLaunch:adjustConfig];
    return YES;
}

- (void)createAccount:(NSString *)token{
    ADJEvent *event = [ADJEvent eventWithEventToken:token];
    [Adjust trackEvent:event];
}

- (void)createRole:(NSString *)token{
    ADJEvent *event = [ADJEvent eventWithEventToken:token];
    [Adjust trackEvent:event];
}

- (void)purchase:(NSString *)token amount:(NSString *)amount currency:(NSString *)currency{
    ADJEvent *event = [ADJEvent eventWithEventToken:token];
    NSInteger qian = [amount intValue] /100;
    [event setRevenue:qian currency:currency];
    [Adjust trackEvent:event];
    
    NSLog(@"%@   %@   %@", token, amount, currency);
}

@end
