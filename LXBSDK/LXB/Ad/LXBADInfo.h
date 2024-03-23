//
//  LXBADInfo.h
//  LXBSDK
//
//  Created by pub on 2024/3/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXBADInfo : NSObject

@property(nonatomic, assign)BOOL reward;
@property(nonatomic, strong)NSString *adType;
@property(nonatomic, strong)NSString *adID;
@property(nonatomic, assign)NSDecimalNumber *amount;
@property(nonatomic, strong)NSString *errerInfo;

@end

NS_ASSUME_NONNULL_END
