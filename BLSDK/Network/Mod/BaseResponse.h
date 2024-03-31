//
//  BaseResponse.h
//  LXBSDK
//
//  Created by pub on 2024/1/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseResponse : NSObject
/// 状态码
/// 等于0表示成功
@property (nonatomic, assign) int code;
/// 出错的提示信息
/// 发生了错误不一定有
@property (nonatomic, strong) NSString *message;
@end

NS_ASSUME_NONNULL_END
