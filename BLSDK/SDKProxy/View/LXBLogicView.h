//
//  BaseView.h
//  LXBSDK
//
//  Created by xiaolong on 2024/2/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXBLogicView : LXBBaseView

@property(nonatomic, strong)MyBaseLayout *rootContainer;

@property(nonatomic, strong)UIImageView *bgView;

@property(nonatomic, strong)MyBaseLayout *contentView;

@property(nonatomic, strong)MyFrameLayout *titleView;

/// 找控件
- (void)initViews;

/// 设置数据
- (void)initDatum;

/// 设置监听器
- (void)initListeners;

- (instancetype)initTitle:(NSString *)title isRightCloseBtn:(int)closeType;

@end

NS_ASSUME_NONNULL_END
