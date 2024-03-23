//
//  LXBScreen.h
//  LXBSDK
//
//  Created by pub on 2024/2/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
#define UI(x) UIAdapter(x)

static inline NSInteger UIAdapter (float x){
    CGFloat scale = 414 / [[UIScreen mainScreen ] bounds].size.width;
    return (NSInteger)x /scale;
}

@interface LXBScreen : NSObject

@end

NS_ASSUME_NONNULL_END
