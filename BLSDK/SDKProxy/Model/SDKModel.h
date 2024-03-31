//
//  SDKMoel.h
//  LXBSDK
//
//  Created by pub on 2024/3/13.
//

#import <Foundation/Foundation.h>
#import "SDKArg.h"
NS_ASSUME_NONNULL_BEGIN

@interface SDKModel : NSObject

@property(nonatomic, assign)ThirdPartyLoginType loginType;
@property(nonatomic, weak)UIViewController *rootController;
@property(nonatomic, strong)SDKArg *sdkArg;
+(SDKModel *)getInstance;

@end

NS_ASSUME_NONNULL_END
