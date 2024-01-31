//
//  StringUtils.h
//  LXBSDK
//
//  Created by pub on 2024/1/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PostArgUtils : NSObject
+ (NSString *)getNonceStr;

+ (NSNumber *)getMillisec;

+ (NSDictionary *)hmacSHA256WithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
