//
//  FirebaseController.m
//  LXBSDK
//
//  Created by publish on 2024/3/19.
//

#import "FirebaseController.h"
#import <FirebaseAnalytics/FirebaseAnalytics.h>
#import <FirebaseCore/FirebaseCore.h>
static FirebaseController *instance;

@implementation FirebaseController

+ (FirebaseController *)getInstance{
    if(instance == nil){
        instance = [[FirebaseController alloc] init];
        [instance innerInit];
    }
    return instance;
}

- (void)innerInit{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishRewarded:) name:AdRewardedNotiName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSucc:) name:LoginSuccNotiName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySucc:) name:PaySuccNotiName object:nil];
}

- (void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    [FIRApp configure];
    [FIRApp.defaultApp setDataCollectionDefaultEnabled:YES];
    [FIRAnalytics setAnalyticsCollectionEnabled:YES];
}

// 注册
- (void)createAccount{
    NSDictionary *dic = @{
        kFIRParameterMethod:@"U8",
    };
    [self setEvent:kFIREventSignUp param:dic];
}

- (void)createRole{
    NSDictionary *dic = @{
        kFIRParameterLevel:@(1),
    };
    [self setEvent:@"create_role" param:dic];
}

- (void)loginSucc:(NSNotification *)noti{
    NSDictionary *dic = @{
        kFIRParameterMethod:@"visitor",
    };
    
    NSString *acc = [NSString stringWithFormat:@"%ld", [DataHub getInstance].userModel.account_id];
    [FIRAnalytics setUserID:acc];
    [self setEvent:kFIREventLogin param:dic];
}

- (void)enterGame{
    [self setEvent:@"enter_game" param:@{}];
}

- (void)paySucc:(NSNotification *)noti{
    NSString *str = noti.object;
    NSDictionary *dic = [str mj_JSONObject];
    
    int price = [[dic objectForKey:@"amount"] intValue];
    int price2 = price / 100;
    NSDictionary *targetDir = @{
        @"buyType":@"Apple",
        @"targetName":dic[@"body"],
        @"targetID":dic[@"product_id"],
        @"targetNum":@(1),
        @"productType":dic[@"detail"],
        kFIRParameterCurrency:@"USD",
        kFIRParameterPrice:@(price2),
    };
    [self setEvent:kFIREventPurchase param:targetDir];
}

- (void)finishRewarded:(NSNotification *)noti{
    NSDictionary *str = noti.object;
    NSDictionary *dic = [str mj_JSONObject];
    if(dic[@"reward"]){
        NSDictionary *eventValue = [NSMutableDictionary dictionaryWithCapacity:10];
        [eventValue setValue:dic[@"adID"] forKey:kFIRParameterAdUnitName];
        [eventValue setValue:@"reward" forKey:kFIRParameterAdFormat];
        [eventValue setValue:@"admob" forKey:kFIRParameterAdPlatform];
        [eventValue setValue:@"admob" forKey:kFIRParameterAdSource];
        [eventValue setValue:dic[@"amount"] forKey:kFIRParameterValue];
        [eventValue setValue:@"USD" forKey:kFIRParameterCurrency];
        [self setEvent:kFIREventAdImpression param:eventValue];
    }
}

- (void)levelUp:(NSString *)level{
    NSDictionary *dic = @{
        kFIRParameterLevel:level,
    };
    [self setEvent:kFIREventLevelUp param:dic];
}

- (void)taskFinish{
    
}

#pragma mark



-(void)setEvent:(NSString *)eventName param:(nullable NSDictionary *)custom_params{
    DDLog(@"firebase %@", [custom_params mj_JSONString]);
    [FIRAnalytics logEventWithName:eventName parameters:custom_params];
}

@end
