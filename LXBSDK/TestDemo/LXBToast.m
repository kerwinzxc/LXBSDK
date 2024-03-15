//
//  LXBToast.m
//  TestDemo
//
//  Created by pub on 2024/3/15.
//
#import <UIKit/UIKit.h>
#import "LXBToast.h"

@implementation LXBToast

+ (void)showToastWithMessage:(NSString *)message {
    // 创建一个 UILabel 来显示消息
    UILabel *toastLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, [UIScreen mainScreen].bounds.size.height - 100, [UIScreen mainScreen].bounds.size.width - 100, 35)];
    toastLabel.backgroundColor = [UIColor blackColor];
    toastLabel.font = [UIFont systemFontOfSize:14];
    toastLabel.textColor = [UIColor whiteColor];
    toastLabel.textAlignment = NSTextAlignmentCenter;
    toastLabel.text = message;
    toastLabel.alpha = 0.0;
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds = YES;
    
    // 将 UILabel 添加到主窗口中
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:toastLabel];
    
    // 动画显示 Toast
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        toastLabel.alpha = 0.8;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 delay:2.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            toastLabel.alpha = 0.0;
        } completion:^(BOOL finished) {
            [toastLabel removeFromSuperview];
        }];
    }];
}


@end
