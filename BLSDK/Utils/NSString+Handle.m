//
//  NSString+Handle.m
//  U8SDKCore
//
//  Created by 厉飞雨 on 2022/8/25.
//  Copyright © 2022 u8sdk. All rights reserved.
//

#import "NSString+Handle.h"
#import "U8Language.h"
@implementation NSString (Handle)




+ (NSString *)u8NullHandle:(id)obj{
    
    if ([obj isKindOfClass:[NSString class]]){
        return obj;
    }else if ((obj == nil) || [obj isEqual:[NSNull null]] || [obj isKindOfClass:[NSNull class]]) {
        return @"";
    }else{
        return [NSString stringWithFormat:@"%@",obj];
    }
}

+ (void)u8Log:(NSString *)format, ...{
}








@end
