//
//  UserCenterView.h
//  LXBSDK
//
//  Created by pub on 2024/2/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserCenterView : UIView

@property (nonatomic, strong) MyBaseLayout *rootContainer;



@property(nonatomic, strong)UIImageView *bgView;

@property(nonatomic, strong)MyBaseLayout *contentView;

@end

NS_ASSUME_NONNULL_END
