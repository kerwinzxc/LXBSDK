//
//  KeychainController.m
//  LXBSDK
//
//  Created by pub on 2024/1/30.
//

#import "KeychainController.h"

@implementation KeychainController

+ (void)savePasswordWithService:(NSString *)service account:(NSString *)account data:(NSString *)data {
    NSData *dataToSave = [data dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *query = @{
        (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
        (__bridge id)kSecAttrService: service,
        (__bridge id)kSecAttrAccount: account,
        (__bridge id)kSecValueData: dataToSave
    };
    
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)query, NULL);
    if (status != errSecSuccess) {
        NSLog(@"保存到 Keychain 时出错");
    }
}

+ (NSString *)loadPasswordWithService:(NSString *)service account:(NSString *)account {
    NSDictionary *query = @{
        (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
        (__bridge id)kSecAttrService: service,
        (__bridge id)kSecAttrAccount: account,
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
        NSLog(@"从 Keychain 中加载数据时出错");
    }

    return nil;
}

+ (void)deletePasswordWithService:(NSString *)service account:(NSString *)account {
    NSDictionary *query = @{
        (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
        (__bridge id)kSecAttrService: service,
        (__bridge id)kSecAttrAccount: account
    };

    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)query);

    if (status != errSecSuccess) {
        NSLog(@"Error deleting from Keychain");
    }
}


+ (NSString *)loadLXBLoginDevicesId{
    NSString *re = [self loadPasswordWithService:LXBDevicesIDService account:LXBLoginDevicesId];
    if(re == nil){
        re = [[NSUUID UUID] UUIDString];
        [self savePasswordWithService:LXBDevicesIDService account:LXBLoginDevicesId data:re];
    }
    return re;
}

+ (NSString *)loadLXBLoginUUID{
    NSString *re = [self loadPasswordWithService:LXBDevicesIDService account:LXBLoginUUID];
    if(re == nil){
        re = [[NSUUID UUID] UUIDString];
        [self savePasswordWithService:LXBDevicesIDService account:LXBLoginUUID data:re];
    }
    return re;
}

+ (void)delecteAllKeychain{
    [self deletePasswordWithService:LXBDevicesIDService account:LXBLoginDevicesId];
    [self deletePasswordWithService:LXBDevicesIDService account:LXBLoginUUID];
}

@end
