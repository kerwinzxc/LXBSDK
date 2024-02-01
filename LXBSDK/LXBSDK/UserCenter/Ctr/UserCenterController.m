//
//  UserCenterController.m
//  LXBSDK
//
//  Created by pub on 2024/1/30.
//

#import "UserCenterController.h"
#import "ResVisitor.h"



@implementation UserCenterController

/*
游客登陆
 */
+ (void)visitorReq:(ReqVisitor *)model success:(MSHttpSuccess)success failure:(MSHttpFail)failure{
    [NetworkController POST:UserCenterModuleName classMeta:[ResVisitor class] url:visitorUrl parameters:[model mj_keyValues] success:success failure:failure];
}
@end
