//
//  NSObject+BLLog.h
//  LXBSDK
//
//  Created by pub on 2024/2/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (BLLog)

- (void)BLLoger:(NSString *)arg;

+ (void)BLLogerPlus:(NSString *)arg;

@end

NS_ASSUME_NONNULL_END
