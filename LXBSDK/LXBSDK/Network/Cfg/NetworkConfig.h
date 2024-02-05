//
//  NetworkConfig.h
//  LXBSDK
//
//  Created by pub on 2024/1/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark -总接口
static NSString *const kApiPrefix = @"https://gmshwtest.boomgames.top/";
//@"https://gmstest.boomgames.top/";
//@"https://gms.boomgames.top/"
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


static NSString *const U8_GAME_ID = @"1";
static NSString *const U8_PACKAGE_ID = @"7047";
static NSString *const U8_CHANNEL = @"1111111235";
static NSString *const U8_PRIVATE_KEY = @"c6075961d425973f031b75c9f4e09ce9";

@interface NetworkConfig : NSObject

@end

NS_ASSUME_NONNULL_END
