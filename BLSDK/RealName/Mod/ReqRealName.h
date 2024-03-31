//
//  ReqRealName.h
//  LXBSDK
//
//  Created by pub on 2024/2/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReqRealName : NSObject
@property(nonatomic, assign)long app_id;
@property(nonatomic, assign)long channel_id;
@property(nonatomic, assign)long account_id;
@property(nonatomic, strong)NSString *realname;
@property(nonatomic, strong)NSString *id_card;
@end

NS_ASSUME_NONNULL_END
