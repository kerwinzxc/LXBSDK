//
//  LXBHelper.m
//  LXBSDK
//
//  Created by pub on 2024/2/6.
//

#import "LXBHelper.h"
#import <UIKit/UIKit.h>
@implementation LXBHelper

+ (UIImage *)imageWithName:(NSString *)name {
    NSString *imaPath = [NSString stringWithFormat:@"LxbBundle.bundle/%@", name];
    UIImage *image = [UIImage imageNamed:imaPath];
    return image;
}

+ (UIColor *)mainColor{
    return [UIColor colorWithRed:0.97 green:0.87 blue:0.33 alpha:1];;
}

+ (UIColor *)btnBGColor{
    return [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.1];;
}

@end
