//
//  KeychainController.h
//  LXBSDK
//
//  Created by pub on 2024/1/30.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>
#import "KeychainConfig.h"
NS_ASSUME_NONNULL_BEGIN

#pragma mark - Service
static NSString *const LXBDevicesIDService = @"LXBDevicesIDService";
static NSString *const LXBPayOrderService = @"LXBPayOrderService";

#pragma mark - Key
static NSString *const LXBLoginDevicesId = @"LXBLoginDevicesId";
static NSString *const LXBLoginUUID = @"LXBLoginUUID";

static NSString *const LXBAccessToken = @"LXBAccessToken";
static NSString *const LXBAccount = @"LXBAccount";
@interface KeychainController : NSObject


+ (NSString *)loadLXBLoginDevicesId;
+ (NSString *)loadLXBLoginUUID;
+ (void)delecteDevicesIdAndUUID;

+ (void)saveOrderId:(NSString *)orderId proId:(NSString *)proId;
+ (NSString *)loadOrderIdByProid:(NSString*)proId;
+ (void)delectOrderidByProid:(NSString *)proId;

+ (NSString *)loadAccessToken;
+ (void)saveAccessToken:(NSString *)serverToken;
+ (void)delecteAccessToken;

+ (NSString *)loadAccount;
+ (void)saveAccount:(NSString *)account;
+ (void)saveDevices:(NSString *)devicesId;
+ (void)saveUuid:(NSString *)uuid;
@end

NS_ASSUME_NONNULL_END
