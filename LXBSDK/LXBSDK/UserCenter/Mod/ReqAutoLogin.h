//
//  ReqAutoLogin.h
//  LXBSDK
//
//  Created by pub on 2024/2/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReqAutoLogin : NSObject
@property(nonatomic, strong)NSString *device_id;
@property(nonatomic, strong)NSString *uuid;
@property(nonatomic, assign)long account_id;
@property(nonatomic, strong)NSString *access_token;
@end

NS_ASSUME_NONNULL_END
