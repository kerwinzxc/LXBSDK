//
//  BaseConfig.h
//  LXBSDK
//
//  Created by pub on 2024/2/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *const ApplePlaformName = @"ap";

typedef NS_ENUM(NSInteger, ThirdPartyLoginType) {
    ThirdPartyLoginNone = 0,
    ThirdPartyLoginBind,
    ThirdPartyLogin,
};

typedef NS_ENUM(NSInteger, BaseViewCloseType) {
    RightClose = 0,
    LeftClose,
    NOClose,
};

@interface BaseConfig : NSObject

@end

NS_ASSUME_NONNULL_END
