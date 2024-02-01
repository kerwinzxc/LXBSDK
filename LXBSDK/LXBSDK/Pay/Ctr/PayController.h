//
//  PayController.h
//  LXBSDK
//
//  Created by pub on 2024/2/1.
//

#import <Foundation/Foundation.h>
#import "ReqPayCreate.h"
#import "ResPayCreate.h"
NS_ASSUME_NONNULL_BEGIN

@interface PayController : NSObject
+ (void)ceratePayOrder:(ReqPayCreate *)model success:(MSHttpSuccess)success failure:(MSHttpFail)failure;
@end

NS_ASSUME_NONNULL_END
