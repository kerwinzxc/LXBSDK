//
//  NetworkConfig.h
//  LXBSDK
//
//  Created by pub on 2024/1/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark -总接口
static NSString *const kServerVersion = @"v3";

#pragma mark - debug 功能
static BOOL const OPENNETWORKLOG = YES;
static float const NETWORKTIMEOUT = 15.0f;

#pragma mark - 请求头的Key
static NSString *const HeadXGameId = @"X-GameId";
static NSString *const HeadXChannelId = @"X-ChannelId";
static NSString *const HeadXPackageId = @"X-PackageId";
static NSString *const HeadXDeviceType = @"X-DeviceType";
static NSString *const HeadXLanguage = @"X-Language";
static NSString *const HeadXVersion = @"X-Version";
static NSString *const HeadContentType = @"Content-Type";
static NSString *const HeadAppVersion = @"X-AppVersion";

@interface NetworkConfig : NSObject

@end

NS_ASSUME_NONNULL_END
