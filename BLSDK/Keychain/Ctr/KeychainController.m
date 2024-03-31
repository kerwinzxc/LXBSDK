//
//  KeychainController.m
//  LXBSDK
//
//  Created by pub on 2024/1/30.
//

#import "KeychainController.h"

@implementation KeychainController

+ (void)saveKeyValueWithTableName:(NSString *)service keyStr:(NSString *)keyStr valueStr:(NSString *)data {
    NSData *dataToSave = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *query = @{
        (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
        (__bridge id)kSecAttrService: service,
        (__bridge id)kSecAttrAccount: keyStr,
        (__bridge id)kSecValueData: dataToSave
    };
    
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)query, NULL);
    if (status != errSecSuccess) {
        DDLog(@"保存到 Keychain 时出错");
    }
}

+ (void)saveKeyValueWithTableWraper:(NSString *)service keyStr:(NSString *)keyStr valueStr:(NSString *)data{
    NSString *lostValue = [self loadValueWithTableName:service withKey:keyStr];
    if(lostValue == nil){
        //baocun
        [self saveKeyValueWithTableName:service keyStr:keyStr valueStr:data];
    }
    else{
        // genxin
        [self updateValueWithTableName:service keyStr:keyStr newValueStr:data];
    }
}

+ (NSString *)loadValueWithTableName:(NSString *)service withKey:(NSString *)keyStr {
    NSDictionary *query = @{
        (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
        (__bridge id)kSecAttrService: service,
        (__bridge id)kSecAttrAccount: keyStr,
        (__bridge id)kSecReturnData: (__bridge id)kCFBooleanTrue,
        (__bridge id)kSecMatchLimit: (__bridge id)kSecMatchLimitOne
    };
    
    CFTypeRef retrievedData = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, &retrievedData);
    
    if (status == errSecSuccess) {
        NSData *data = (__bridge_transfer NSData *)retrievedData;
        NSString *password = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return password;
    } else {
        DDLog(@"从 Keychain 加载不到数据");
    }

    return nil;
}

+ (void)deleteValueWithTableName:(NSString *)service keyStr:(NSString *)keyStr {
    NSDictionary *query = @{
        (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
        (__bridge id)kSecAttrService: service,
        (__bridge id)kSecAttrAccount: keyStr
    };

    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)query);

    if (status != errSecSuccess) {
        DDLog(@"Error deleting from Keychain");
    }
}

+ (void)updateValueWithTableName:(NSString *)service keyStr:(NSString *)proid newValueStr:(NSString *)valueStr {
    NSDictionary *query = @{
        (__bridge id)kSecClass:(__bridge id)kSecClassGenericPassword,
        (__bridge id)kSecAttrAccount:proid,
        (__bridge id)kSecAttrService :service,
                          };
    
    
    NSDictionary *update = @{
        (__bridge id)kSecValueData:[valueStr dataUsingEncoding:NSUTF8StringEncoding],
                           };

    OSStatus status = SecItemUpdate((__bridge CFDictionaryRef)query, (__bridge CFDictionaryRef)update);
    if(status == errSecSuccess){
       
    }
    else{
        DDLog(@"update failure");
    }
}


+ (NSString *)loadLXBLoginDevicesId{
    NSString *re = [self loadValueWithTableName:LXBDevicesIDService withKey:LXBLoginDevicesId];
    if(re == nil){
        re = [[NSUUID UUID] UUIDString];
        [self saveKeyValueWithTableWraper:LXBDevicesIDService keyStr:LXBLoginDevicesId valueStr:re];
    }
    return re;
}

+ (NSString *)loadLXBLoginUUID{
    NSString *re = [self loadValueWithTableName:LXBDevicesIDService withKey:LXBLoginUUID];
    if(re == nil){
        re = [[NSUUID UUID] UUIDString];
        [self saveKeyValueWithTableWraper:LXBDevicesIDService keyStr:LXBLoginUUID valueStr:re];
    }
    return re;
}

+ (void)delecteDevicesIdAndUUID{
    [self deleteValueWithTableName:LXBDevicesIDService keyStr:LXBLoginDevicesId];
    [self deleteValueWithTableName:LXBDevicesIDService keyStr:LXBLoginUUID];
}

+ (void)saveOrderId:(NSString *)orderId proId:(NSString *)proId{
    [self saveKeyValueWithTableWraper:LXBPayOrderService keyStr:proId valueStr:orderId];
}

+ (NSString *)loadOrderIdByProid:(NSString*)proId{
    return [self loadValueWithTableName:LXBPayOrderService withKey:proId];
}

+ (void)delectOrderidByProid:(NSString *)proId{
    [self deleteValueWithTableName:LXBPayOrderService keyStr:proId];
}

+ (NSString *)loadAccessToken{
    return [self loadValueWithTableName:LXBDevicesIDService withKey:LXBAccessToken];
}

+ (void)saveAccessToken:(NSString *)serverToken{
    [self saveKeyValueWithTableWraper:LXBDevicesIDService keyStr:LXBAccessToken valueStr:serverToken];
}

+ (void)delecteAccessToken{
    [self deleteValueWithTableName:LXBDevicesIDService keyStr:LXBAccessToken];
}

+ (NSString *)loadAccount{
    return [self loadValueWithTableName:LXBDevicesIDService withKey:LXBAccount];
}

+ (void)saveAccount:(NSString *)account{
    [self saveKeyValueWithTableWraper:LXBDevicesIDService keyStr:LXBAccount valueStr:account];
}



+ (void)saveDevices:(NSString *)devicesId{
    [self saveKeyValueWithTableWraper:LXBDevicesIDService keyStr:LXBLoginDevicesId valueStr:devicesId];
}

+ (void)saveUuid:(NSString *)uuid{
    [self saveKeyValueWithTableWraper:LXBDevicesIDService keyStr:LXBLoginUUID valueStr:uuid];
}

@end
