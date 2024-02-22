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

+ (UIColor *)titleBgView{
    return [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.05];;
}

+ (void)showToast:(NSString *)info supView:(UIView *)view{
    [QMUITips showWithText:info inView:view hideAfterDelay:1.6];
}

+ (void)showNormalDialogViewController {
    QMUIDialogViewController *dialogViewController = [[QMUIDialogViewController alloc] init];
    dialogViewController.title = @"标题";
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
    contentView.backgroundColor = UIColorWhite;
    UILabel *label = [[UILabel alloc] qmui_initWithFont:UIFontMake(14) textColor:UIColorBlack];
    label.text = @"自定义contentView";
    [label sizeToFit];
    label.center = CGPointMake(CGRectGetWidth(contentView.bounds) / 2.0, CGRectGetHeight(contentView.bounds) / 2.0);
    [contentView addSubview:label];
    dialogViewController.contentView = contentView;
    [dialogViewController addCancelButtonWithText:@"取消" block:nil];
    [dialogViewController addSubmitButtonWithText:@"确定" block:^(QMUIDialogViewController *aDialogViewController) {
        [aDialogViewController hide];
    }];
    [dialogViewController show];
}

@end
