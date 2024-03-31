//
//  AdjustController.h
//  LXBSDK
//
//  Created by pub on 2024/3/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AdjustController : NSObject
+ (AdjustController *)getInstance;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;


- (void)trackEventWithToken:(NSString *)token;
- (void)purchaseWithToken:(NSString *)token amount:(int)amount currency:(NSString *)currency;

- (void)adjustAddTaAccountId:(NSString *)accountId;
@end

NS_ASSUME_NONNULL_END
