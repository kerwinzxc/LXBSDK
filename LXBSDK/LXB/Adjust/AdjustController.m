//
//  AdjustController.m
//  LXBSDK
//
//  Created by pub on 2024/3/18.
//

#import "AdjustController.h"
#import <Adjust/Adjust.h>
#import <ThinkingSDK/ThinkingSDK.h>
static AdjustController *instance;

@interface AdjustController()<AdjustDelegate>

@end

@implementation AdjustController

+ (AdjustController *)getInstance{
    if(instance == nil){
        instance = [[AdjustController alloc] init];
        [instance innerInit];
    }
    return instance;
}

- (void)innerInit{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSecc:) name:LoginSuccNotiName object:nil];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    NSString *appToken = [SDKModel getInstance].sdkArg.adJustAppToken;
    NSString *e_bool = [SDKModel getInstance].sdkArg.adJustEnvironment;
    NSString *deviceId = [TDAnalytics getDeviceId];
    [Adjust addSessionCallbackParameter:@"ta_distinct_id" value:deviceId];
    NSString  *environment = ADJEnvironmentProduction;
    if([e_bool isEqual:@"1"]){
        environment = ADJEnvironmentSandbox;
        [TDAnalytics enableLog:YES];
    }
    ADJConfig *adjustConfig = [ADJConfig configWithAppToken:appToken environment:environment];
    
    [adjustConfig setDelegate:self];
    [adjustConfig setLogLevel:ADJLogLevelVerbose];
    
    [Adjust appDidLaunch:adjustConfig];
    return YES;
}

- (void)trackEventWithToken:(NSString *)token{
    ADJEvent *event = [ADJEvent eventWithEventToken:token];
    [Adjust trackEvent:event];
}

- (void)purchaseWithToken:(NSString *)token amount:(int)amount currency:(NSString *)currency{
    ADJEvent *event = [ADJEvent eventWithEventToken:token];
    [event setRevenue:amount currency:currency];
    [Adjust trackEvent:event];
    
    NSLog(@"adjust purchase%@   %i   %@", token, amount, currency);
}

- (void)adjustAddTaAccountId:(NSString *)accountId{
    [Adjust addSessionCallbackParameter:@"ta_account_id" value:accountId];
}


- (void)loginSecc:(NSNotification *)noti{
    NSString *acc = [NSString stringWithFormat:@"%ld", [DataHub getInstance].userModel.account_id];
    [self adjustAddTaAccountId:acc];
}


#pragma adjust deleget
- (void)adjustEventTrackingFailed:(nullable ADJEventFailure *)eventFailureResponseData{
    NSString *errorInfo = [eventFailureResponseData mj_JSONString];
    
    [TDAnalytics track:@"adjust_event_failed" properties:@{
            @"fail_reason":errorInfo
    }];
}

- (void)adjustSessionTrackingFailed:(nullable ADJSessionFailure *)sessionFailureResponseData{
    NSString *errorInfo = [sessionFailureResponseData mj_JSONString];
    [TDAnalytics track:@"adjust_session_failed" properties:@{
            @"fail_reason":errorInfo
    }];
}

- (void)adjustEventTrackingSucceeded:(nullable ADJEventSuccess *)eventSuccessResponseData{
    NSString *succJson = [eventSuccessResponseData mj_JSONString];
    NSLog(@"----%@", succJson);
}



@end
