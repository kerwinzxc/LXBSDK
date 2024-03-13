//
//  SDKMoel.h
//  LXBSDK
//
//  Created by pub on 2024/3/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SDKModel : NSObject

@property(nonatomic, assign)ThirdPartyLoginType loginType;
@property(nonatomic, weak)UIViewController *rootController;

+(SDKModel *)getInstance;

@end

NS_ASSUME_NONNULL_END
