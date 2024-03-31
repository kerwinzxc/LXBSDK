//
//  CustomResponseSerializer.m
//  LXBSDK
//
//  Created by pub on 2024/2/1.
//

#import "CustomResponseSerializer.h"

@implementation CustomResponseSerializer

- (BOOL)validateResponse:(NSHTTPURLResponse *)response
                    data:(NSData *)data
                   error:(NSError *__autoreleasing *)error
{
    return YES;
}

@end
