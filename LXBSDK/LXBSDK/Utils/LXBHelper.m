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

@end
