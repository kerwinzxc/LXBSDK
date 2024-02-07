//
//  U8Language.h
//  U8SDKCore
//
//  Created by 厉飞雨 on 2022/8/25.
//  Copyright © 2022 u8sdk. All rights reserved.
//

#import <Foundation/Foundation.h>



NS_ASSUME_NONNULL_BEGIN

@interface U8Language : NSObject
///首选默认语言
@property (nonatomic,copy)NSString *defaultLag;
///强制语言
@property (nonatomic,copy)NSString *enforceLag;

@property (nonatomic,copy,readonly)NSString *currentLag;

@property (nonatomic,assign,readonly)BOOL isRTL;

@property (nonatomic,assign,readonly)BOOL isShortLag;

+(U8Language *)sharedInstance;

-(NSString *)localizedForKey:(NSString *)keyStr;

@end

static inline NSString* getLocalString (NSString *x){
    return [[U8Language sharedInstance] localizedForKey:x];
}

NS_ASSUME_NONNULL_END
