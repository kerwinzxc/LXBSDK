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
- (void)createAccount:(NSString *)token;
- (void)createRole:(NSString *)token;
- (void)purchase:(NSString *)token amount:(NSString *)amount currency:(NSString *)currency;
@end

NS_ASSUME_NONNULL_END
