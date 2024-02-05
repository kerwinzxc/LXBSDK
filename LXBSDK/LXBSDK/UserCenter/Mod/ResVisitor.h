//
//  LXBUserModel.h
//  LXBSDK
//
//  Created by pub on 2024/2/1.
//

#import <Foundation/Foundation.h>
#import "ThirdUserInfo.h"
NS_ASSUME_NONNULL_BEGIN

@interface ResVisitor : NSObject

@property(nonatomic, strong)NSString *channel_id;
@property(nonatomic, strong)NSString *mcs_unique_id;
@property(nonatomic, assign)long current_time;
@property(nonatomic, assign)long game_id;
@property(nonatomic, strong)NSString *nickname;
@property(nonatomic, assign)long register_time;
@property(nonatomic, strong)NSString *device_id;
@property(nonatomic, assign)int is_reward;
@property(nonatomic, assign)int visitor;
@property(nonatomic, strong)NSString *uuid;
@property(nonatomic, strong)NSString *platform_type;
@property(nonatomic, assign)int is_first_pay;
@property(nonatomic, assign)int mcs_report_type;
@property(nonatomic, strong)NSString *gl_id;
@property(nonatomic, strong)NSString *platform;
@property(nonatomic, strong)NSString *token;
@property(nonatomic, strong)NSString *avatar;
@property(nonatomic, assign)long account_id;
@property(nonatomic, strong)NSMutableArray *platforms;

@property(nonatomic, assign)int age;
@property(nonatomic, strong)NSString *extension;
@property(nonatomic, assign)int is_realname;

@property(nonatomic, strong)NSString *access_token;
+(NSDictionary *)mj_objectClassInArray;

@end

NS_ASSUME_NONNULL_END
