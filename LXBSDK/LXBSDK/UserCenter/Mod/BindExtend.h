//
//  BindExtend.h
//  LXBSDK
//
//  Created by pub on 2024/2/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BindExtend : NSObject
@property(nonatomic, strong)NSString *platform_id;
@property(nonatomic, assign)int verify_type;
@property(nonatomic, strong)NSString *access_token;
@property(nonatomic, strong)NSString *code;
@property(nonatomic, strong)NSString *nickname;
@property(nonatomic, strong)NSString *avatar;
@end

NS_ASSUME_NONNULL_END

