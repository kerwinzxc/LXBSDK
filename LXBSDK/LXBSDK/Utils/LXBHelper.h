//
//  LXBHelper.h
//  LXBSDK
//
//  Created by pub on 2024/2/6.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ZHToastView.h>
NS_ASSUME_NONNULL_BEGIN

static NSString *const LXBResourcesBundleName = @"LxbBundle";

@interface LXBHelper : NSObject
+ (UIImage *)imageWithName:(NSString *)name;

+ (UIColor *)mainColor;

+ (UIColor *)btnBGColor;

+ (UIColor *)titleBgView;

+ (UIColor *)bgViewColor;

+ (UIColor *)normalTextColor;

+ (void)showToast:(NSString *)info supView:(UIView *)view;

+ (ZHToastView *)openLoading:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
