//
//  NetworkController.h
//  LXBSDK
//
//  Created by pub on 2024/1/30.
//

#import <Foundation/Foundation.h>
#import <MSNetwork/MSNetwork.h>
#import "NetworkConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface NetworkController : NSObject

+ (void)networkServiceInit;

+ (void)GET:(NSString *)moduleName url:(NSString *)URL parameters:(NSDictionary *)parameters success:(MSHttpSuccess)success  failure:(MSHttpFail)failure;
/** Post*/
+ (void)POST:(NSString *)moduleName url:(NSString *)URL parameters:(NSDictionary *)parameters success:(MSHttpSuccess)success failure:(MSHttpFail)failure;

@end

NS_ASSUME_NONNULL_END
