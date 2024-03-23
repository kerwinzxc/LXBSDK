//
//  DeleteAccConfirmView.h
//  LXBSDK
//
//  Created by pub on 2024/2/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeleteAccConfirmView : LXBBaseView<UIScrollViewDelegate>

@property(nonatomic, strong)MyLinearLayout *contentView;

@property(nonatomic, strong)UIScrollView *scorllView;

@property(nonatomic, strong)UILabel *deleteUILabel;
@end

NS_ASSUME_NONNULL_END
