//
//  LXBBaseView.h
//  LXBSDK
//
//  Created by pub on 2024/2/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXBBaseView : UIView
- (void)destroy;
- (void)onDestroy;
- (UIWindow *)getRootWindow;
- (UIViewController *)getRootController;
@end

NS_ASSUME_NONNULL_END
