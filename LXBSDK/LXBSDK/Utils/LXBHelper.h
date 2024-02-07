//
//  LXBHelper.h
//  LXBSDK
//
//  Created by pub on 2024/2/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *const LXBResourcesBundleName = @"LxbBundle";

@interface LXBHelper : NSObject
+ (UIImage *)imageWithName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
