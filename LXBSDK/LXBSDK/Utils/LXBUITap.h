//
//  LXBUITap.h
//  LXBSDK
//
//  Created by pub on 2024/2/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXBUITap : UITapGestureRecognizer

@property(nonatomic, assign)NSTimeInterval lastTapTime;


@end

NS_ASSUME_NONNULL_END
