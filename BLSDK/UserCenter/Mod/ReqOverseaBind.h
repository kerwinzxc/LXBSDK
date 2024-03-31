//
//  ReqOverseaBind.h
//  LXBSDK
//
//  Created by pub on 2024/2/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReqOverseaBind : NSObject

@property(nonatomic, assign)long account_id;
@property(nonatomic, strong)NSString *platform_type;
@property(nonatomic, strong)NSString *extend;
@end

NS_ASSUME_NONNULL_END
