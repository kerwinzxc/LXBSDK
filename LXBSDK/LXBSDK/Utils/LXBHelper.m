//
//  LXBHelper.m
//  LXBSDK
//
//  Created by pub on 2024/2/6.
//

#import "LXBHelper.h"
#import <UIKit/UIKit.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "LXBToast.h"
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

+ (void)showLoading:(NSString *)content{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setCornerRadius:4];
    [SVProgressHUD setBackgroundColor:[[UIColor alloc] initWithRed:(251.0f / 255) green:(232.0f / 255) blue:(184.0f / 255) alpha:1.0f]];
    
    [SVProgressHUD setForegroundColor:[[UIColor alloc] initWithRed:(98.0f / 255) green:(90.0f /255) blue:(74.0f / 255) alpha:1.0f]];
    [SVProgressHUD showWithStatus:content];
    //[SVProgressHUD dismissWithDelay:9.0f];
}

+ (void)hideLoading{
    [SVProgressHUD dismiss];
}

+ (void)showToast:(NSString *)toast{
    [LXBToast showToastWithMessage:toast];
}


@end
