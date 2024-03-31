//
//  NSString+Handle.h
//  U8SDKCore
//
//  Created by 厉飞雨 on 2022/8/25.
//  Copyright © 2022 u8sdk. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Handle)

-(NSString *)removeTrailingSpaces;

- (BOOL)u8IsPureInt;

+(NSString *)localizedForKey:(NSString *)keyStr;

+(NSString *)u8NullHandle:(id)obj;

+(void)u8Log:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);

-(NSDictionary *)u8GetUrlParameters;
-(NSString *)u8UrlUpdateParameters:(NSDictionary *)parameters;
-(NSString *)u8UrlChangeSchemes:(NSString *)schemesStr;
-(NSString *)u8UrlDecodedString;
-(NSString *)u8UrlEncodedString;

@end

NS_ASSUME_NONNULL_END
