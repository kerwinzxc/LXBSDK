//
//  ReamNameController.h
//  LXBSDK
//
//  Created by pub on 2024/2/1.
//

#import <Foundation/Foundation.h>
#import "RealNameConfig.h"
#import "ReqRealName.h"
#import "ResRealName.h"
NS_ASSUME_NONNULL_BEGIN

@interface RealNameController : NSObject
+ (void)realName:(ReqRealName *)model success:(MSHttpSuccess)success failure:(MSHttpFail)failure;
@end

NS_ASSUME_NONNULL_END
