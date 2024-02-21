//
//  LXBConfig.h
//  LXBSDK
//
//  Created by pub on 2024/2/19.
//

#import <Foundation/Foundation.h>

static NSString * _Nullable const LoginNotiName = @"LoginNotiName";

static NSString * _Nullable const AppleLoginNotiName = @"AppleLoginNotiName";

static NSString * _Nullable const CloseAllViewNotiName = @"CloseAllViewNotiName";

NS_ASSUME_NONNULL_BEGIN

@interface LXBConfig : NSObject

@property(nonatomic, strong)NSArray *bindViewCfg;
@property(nonatomic, strong)NSArray *menuViewCfg;
@property(nonatomic, strong)NSArray *changeAccViewCfg;

@property(nonatomic, strong)NSArray *changeAccWarperCfg;
+ (LXBConfig *)getInstance;
@end

NS_ASSUME_NONNULL_END
