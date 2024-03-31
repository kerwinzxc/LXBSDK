//
//  NSObject+BLLog.m
//  LXBSDK
//
//  Created by pub on 2024/2/3.
//

#import "NSObject+BLLog.h"

@implementation NSObject (BLLog)
- (void)BLLoger:(NSString *)arg{
//    NSArray *array = [NSThread callStackSymbols];
//    NSLog(@"xxx %@", array);
//    NSLog(@"Class Name %@", NSStringFromClass([self class]));
//    NSLog(@"Fun Name   %s", __func__);
//    NSLog(@"Fun Arg    %s",__PRETTY_FUNCTION__);
//    NSLog(@"Hang hao %d", __LINE__);
//    NSLog(@"FilePath %s", __FILE__);
}

+ (void)BLLogerPlus:(NSString *)arg{
    NSArray *array = [NSThread callStackSymbols];
    NSLog(@"xxx %@", array);
//    //NSLog(@"Class Name %@", NSStringFromClass([self class]));
//    NSLog(@"Fun Name   %s", __func__);
//    NSLog(@"Fun Arg    %s",__PRETTY_FUNCTION__);
//    NSLog(@"Hang hao %d", __LINE__);
//    NSLog(@"FilePath %s", __FILE__);
}
@end
