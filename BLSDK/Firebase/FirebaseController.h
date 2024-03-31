//
//  FirebaseController.h
//  LXBSDK
//
//  Created by publish on 2024/3/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface FirebaseController : NSObject
+ (FirebaseController *)getInstance;

- (void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;


#pragma 普通事件
- (void)createAccount;
- (void)createRole;
- (void)enterGame;
- (void)levelUp:(NSString *)level;
@end

NS_ASSUME_NONNULL_END
