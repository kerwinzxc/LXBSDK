//
//  StringUtils.m
//  LXBSDK
//
//  Created by pub on 2024/1/31.
//

#import "PostArgUtils.h"
#import <CommonCrypto/CommonHMAC.h>
#import "NetworkConfig.h"
@implementation PostArgUtils

+ (NSString *)getNonceStr{
//    NSString *uuid = [[NSUUID UUID] UUIDString];
//    uuid = [uuid stringByReplacingOccurrencesOfString:@"-" withString:@""];
//    if([uuid length] < 32){
//        int lastWords = arc4random() % 9;
//        return [NSString stringWithFormat:@"%@%d", @"qazwsxedcrfvtgbyhnujmikolp12345",lastWords];
//    }
//    else{
//        return [uuid substringToIndex:32];
//    }
    return @"123465";
}

+ (NSNumber *)getMillisec{
    NSTimeInterval milliseconds = [[NSDate date] timeIntervalSince1970] * 1000;
    long long millisecondsInt = (long long)milliseconds;
    //NSString *re = [NSString stringWithFormat:@"%lld", millisecondsInt];
    return @(millisecondsInt);
    
}

+ (NSDictionary *)hmacSHA256WithDict:(NSDictionary *)dict{
    NSString *secret = U8_PRIVATE_KEY;
    NSMutableDictionary *value = [[NSMutableDictionary alloc] initWithDictionary:dict];
    NSNumber *timestamp = [self getMillisec];
    NSString *nonce = [self getNonceStr];
    //secret 秘钥
    //密钥转换成 const char
    const char *cKey  = [secret cStringUsingEncoding:NSASCIIStringEncoding];
      // 加密的内容有可能有中文 所以用NSUTF8StringEncoding
    NSString *string = [self sortKeyArr:value timestamp:timestamp nonce:nonce];
    const char *cData = [string cStringUsingEncoding:NSUTF8StringEncoding];
    DDLog(@"boomgamecenter: paramsString %@", string);

    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    //SHA256加密
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSMutableString *hexString = [NSMutableString string];
    //转换成字符串
    for (int i=0; i<sizeof(cHMAC); i++)
    {
        [hexString appendFormat:@"%02x", cHMAC[i]];
    }
    value[@"timestamp"] = timestamp;
    value[@"nonce"] = nonce;
    value[@"sign"] = hexString;
    return value;
}

/**
*  字典根据key值排序，并且key和value中间加入=号拼接，末尾加入#号。
*/
+ (NSString *)sortKeyArr:(NSDictionary *)dict timestamp:(NSNumber *)timestamp nonce:(NSString *)nonce{
    
    NSString *result = @"";
    NSArray *keyArr = [dict allKeys];
    //对字典里面的key值排序
    NSLocale *currentLocale = [NSLocale currentLocale];
    NSComparator finderSortBlock = ^(id string1,id string2) {
        NSRange string1Range =NSMakeRange(0, [string1 length]);
        return [string1 compare:string2 options:NSCaseInsensitiveSearch range:string1Range locale:currentLocale];
    };
    //排序处理
    NSArray *arr2 = [keyArr sortedArrayUsingComparator:finderSortBlock];
    //循环遍历排序
    for (int i = 0; i<arr2.count; i++) {
        result = [result stringByAppendingFormat:@"%@=%@&",arr2[i], dict[arr2[i]]];
    }
    result = [result stringByAppendingFormat:@"timestamp=%@&",timestamp];
    result = [result stringByAppendingFormat:@"nonce=%@",nonce];
    return result;
}

@end
