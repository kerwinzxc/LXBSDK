//
//  SDKArg.h
//  LXBSDK
//
//  Created by pub on 2024/3/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SDKArg : NSObject

@property(nonatomic, strong)NSString *U8_GAME_ID;
@property(nonatomic, strong)NSString *U8_PACKAGE_ID;
@property(nonatomic, strong)NSString *U8_CHANNEL;
@property(nonatomic, strong)NSString *U8_PRIVATE_KEY;
@property(nonatomic, strong)NSString *kApiPrefix;
@property(nonatomic, strong)NSString *googleAdUnitId;

@property(nonatomic, strong)NSString *adJustAppToken;
@property(nonatomic, strong)NSString *adJustEnvironment;

@end

NS_ASSUME_NONNULL_END
