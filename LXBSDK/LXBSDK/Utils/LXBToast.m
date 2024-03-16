//
//  LXBToast.m
//  TestDemo
//
//  Created by pub on 2024/3/15.
//
#import <UIKit/UIKit.h>
#import "LXBToast.h"
#import <MyLayout/MyLayout.h>
@implementation LXBToast

+ (void)showToastWithMessage1:(NSString *)message {
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

+ (void)showToastWithMessage:(NSString *)message1{
    UIView *view = [UIView new];
    
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    view.frame = CGRectMake(0, h - 200, w, 100);
    
    view.backgroundColor = [UIColor clearColor];
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:view];
    
    MyLinearLayout *toastRoot = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    toastRoot.myHeight = toastRoot.myWidth = MyLayoutSize.fill;
    toastRoot.backgroundColor = [UIColor clearColor];
    toastRoot.gravity = MyGravity_Center;
    toastRoot.padding = UIEdgeInsetsMake(5, 20, 5, 20);
    [view addSubview:toastRoot];
    
    
    UILabel *msgLabel = [UILabel new];
    msgLabel.font = [UIFont systemFontOfSize:16];
    msgLabel.text = message1;
    msgLabel.textAlignment = NSTextAlignmentCenter;
    [msgLabel sizeToFit];
    NSLog(@"%f",msgLabel.frame.size.width);
    
    
    MyLinearLayout *labelParent = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    labelParent.backgroundColor = [[UIColor alloc] initWithRed:(251.0f / 255) green:(232.0f / 255) blue:(184.0f / 255) alpha:1.0f];
    labelParent.layer.cornerRadius = 6;
    labelParent.layer.borderWidth = 0.5f;
    labelParent.layer.borderColor = [[UIColor alloc] initWithRed:(98.0f / 255) green:(90.0f /255) blue:(74.0f / 255) alpha:1.0f].CGColor;
    labelParent.padding = UIEdgeInsetsMake(10, 20, 10, 20);
    
    
    UILabel *msgLabel2 = [UILabel new];
    msgLabel2.font = [UIFont systemFontOfSize:16];
    msgLabel2.textColor = [[UIColor alloc] initWithRed:(98.0f / 255) green:(90.0f /255) blue:(74.0f / 255) alpha:1.0f];
    msgLabel2.text = message1;
  
    msgLabel2.textAlignment = NSTextAlignmentCenter;
    
    if(msgLabel.frame.size.width > w){
        labelParent.myWidth = MyLayoutSize.fill;
        labelParent.myHeight = MyLayoutSize.wrap;
        [toastRoot addSubview:labelParent];
        
        msgLabel2.myWidth = MyLayoutSize.fill;
        msgLabel2.myHeight = MyLayoutSize.wrap;
        [labelParent addSubview:msgLabel2];
    }
    
    else{
       
        labelParent.myWidth = MyLayoutSize.wrap;
        labelParent.myHeight = MyLayoutSize.wrap;
        [toastRoot addSubview:labelParent];
        [msgLabel2 sizeToFit];
        msgLabel2.textAlignment = NSTextAlignmentCenter;
        [labelParent addSubview:msgLabel2];
    }
    
    [UIView animateWithDuration:0.5 delay:2.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        labelParent.alpha = 0.0;
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
    }];
   
}

@end
