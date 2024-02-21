//
//  LXBHelper.h
//  LXBSDK
//
//  Created by pub on 2024/2/6.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

static NSString *const LXBResourcesBundleName = @"LxbBundle";

@interface LXBHelper : NSObject
+ (UIImage *)imageWithName:(NSString *)name;

+ (UIColor *)mainColor;

+ (UIColor *)btnBGColor;
@end

NS_ASSUME_NONNULL_END
