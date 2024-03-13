//
//  LXBHelper.m
//  LXBSDK
//
//  Created by pub on 2024/2/6.
//

#import "LXBHelper.h"
#import <UIKit/UIKit.h>
#import <ZHToast/ZHToastView.h>
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

+ (UIColor *)bgViewColor{
    return [UIColor colorWithRed:243.0f/255.0f green:246.0f/255.0f blue:244/250.0f alpha:1.0f];;
}

+ (UIColor *)normalTextColor{
    return [UIColor colorWithRed:75.0f/255.0f green:83.0f/255.0f blue:96.0f/255.0f alpha:1.0f];;
}

+ (void)showToast:(NSString *)info supView:(UIView *)view{

}

+ (void)showNormalDialogViewController {
    ZHToastView *toast = [[ZHToastView alloc] initWithStyle:ZHToastStyleHUD];
    
    UIWindow *w = [UIApplication sharedApplication].windows[0];
    
    toast.parentView = w;
    toast.labelText = @"支付中";
    toast.automaticallyHide = NO;
    toast.labelFont = [UIFont boldSystemFontOfSize:16];
    toast.bkgColor = [UIColor grayColor];
    [toast show];
    
    NSLog(@"xxxx");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [toast hide];
    });
}

@end
