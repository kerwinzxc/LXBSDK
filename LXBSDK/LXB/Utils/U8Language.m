//
//  U8Language.m
//  U8SDKCore
//
//  Created by 厉飞雨 on 2022/8/25.
//  Copyright © 2022 u8sdk. All rights reserved.
//

#import "U8Language.h"
#import "NSString+Handle.h"

static U8Language* _single = nil;

static NSString *const DefaultLanguageKey = @"u8_sdk_default_language";
static NSString *const EnforceLanguageKey = @"u8_sdk_enforce_language";

@interface U8Language ()

@property(nonatomic,strong)NSBundle *defaultU8Bundle;
@property(nonatomic,strong)NSArray *lagArray;
@property(nonatomic,copy)NSString *privateCurrentLag;

@end

@implementation U8Language


-(void)setDefaultLag:(NSString *)defaultLag{
    
    NSString *defLag = [NSString u8NullHandle:defaultLag];
    BOOL isChange = NO;
    if (_defaultLag) {
        if (![_defaultLag isEqualToString:defLag]) {
            isChange = YES;
        }
    }else{
        isChange = defLag.length;
    }
    if (isChange) {
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        if (defLag.length) {
            _defaultLag = defLag;
            [userDefaults setValue:defLag forKey:DefaultLanguageKey];
        }else{
            _defaultLag = nil;
            [userDefaults removeObjectForKey:DefaultLanguageKey];
        }
        
        [userDefaults synchronize];
        
        self.defaultU8Bundle = nil;
        
    }
}

-(void)setEnforceLag:(NSString *)enforceLag{
    
    NSString *enLag = [NSString u8NullHandle:enforceLag];
    BOOL isChange = NO;
    if (_enforceLag) {
        if (![_enforceLag isEqualToString:enLag]) {
            isChange = YES;
        }
    }else{
        isChange = enLag.length;
    }
    if (isChange) {
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        if (enLag.length) {
            _enforceLag = enLag;
            [userDefaults setValue:enLag forKey:EnforceLanguageKey];
        }else{
            _enforceLag = nil;
            [userDefaults removeObjectForKey:EnforceLanguageKey];
        }
        [userDefaults synchronize];
        self.defaultU8Bundle = nil;
        
    }
}

-(void)setDefaultU8Bundle:(NSBundle *)defaultU8Bundle{
    _defaultU8Bundle = defaultU8Bundle;
    if (defaultU8Bundle) {
        
        NSString *path = defaultU8Bundle.bundlePath;
        NSArray<NSString *> *array = [path componentsSeparatedByString:@"/"];
        NSString *fileName = array.lastObject;
        if ([fileName hasSuffix:@".lproj"]) {
            self.privateCurrentLag = [fileName componentsSeparatedByString:@"."].firstObject;
        }else{
            self.privateCurrentLag = nil;
        }
        
    }else{
        self.privateCurrentLag = nil;
        
    }
}

-(NSString *)currentLag{
    
    //
    NSString *languageStr  = @"";
    if (self.privateCurrentLag) {
        languageStr = self.privateCurrentLag;
    }else{
        ///其实是调用一下
        NSString *lagType = [self localizedForKey:@"u8sdk_current_language_type"];
        if (self.privateCurrentLag) {
            languageStr = self.privateCurrentLag;;
        }else{
            languageStr = lagType;
        }
    }
    
    if ([languageStr isEqualToString:@"zh-Hans"]) {
        languageStr = @"zh-CN";
    }else if ([languageStr isEqualToString:@"zh-Hant"]) {
        languageStr = @"zh-TW";
    }
    return languageStr;
}


+(U8Language *)sharedInstance
{
      static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _single = [[self alloc]init];
        });
        return _single;
}

-(instancetype)init{
    
    self = [super init];
    if (self) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        _defaultLag = [userDefaults objectForKey:DefaultLanguageKey];
        _enforceLag = [userDefaults objectForKey:EnforceLanguageKey];
        self.defaultU8Bundle = nil;
    }
    
    return self;
}

-(NSBundle *)lagMainBundle{
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *url = [bundle URLForResource:@"U8SDK_Language" withExtension:@"bundle"];
    if (url) {
        bundle = [NSBundle bundleWithURL:url];
    }
    if (!bundle) {
        NSString * bundlePath = [[NSBundle mainBundle] pathForResource:@"U8SDK_Language" ofType:@"bundle"];
        if (bundlePath) {
            bundle = [NSBundle bundleWithPath:bundlePath];
        }
    }
    return bundle;

}

-(NSArray *)lagArray{
    if (!_lagArray) {
        _lagArray = @[];
    }
    return _lagArray;
}

-(BOOL)isRTL{
    
    if ([self.privateCurrentLag hasPrefix:@"ar"]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)isShortLag{
    
    
    return YES;
}

-(NSString *)localizedForKey:(NSString *)keyStr{
    
    
    return [self localizedStringForKey:keyStr value:@""];
}


- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value
{
    //NSString *table = MJRefreshConfig.defaultConfig.i18nFilename;
    
    // 如果没有缓存, 则走初始化逻辑
    if (self.defaultU8Bundle == nil) {
        
        NSString *enforceLag = self.enforceLag;
        if (!enforceLag) {
            enforceLag = [NSLocale preferredLanguages].firstObject;
        }
        NSBundle *bundle = [self lagMainBundle];
        // 首先优先使用公共配置中的 i18nBundle, 如果为空则使用 mainBundle
        bundle = bundle ? bundle : NSBundle.mainBundle;
        
        NSString *enforceLag1 = [self bundleWithLanguage:enforceLag];
        enforceLag1 = enforceLag1 ? enforceLag1:enforceLag;
        // 按语言选取语言包
        NSString *i18nFolderPath = [bundle pathForResource:enforceLag1 ofType:@"lproj"];
        self.defaultU8Bundle = [NSBundle bundleWithPath:i18nFolderPath];
        // 检查语言包, 如果没有查找到, 则默认使用 mainBundle
        if (!self.defaultU8Bundle) {
            if (self.defaultLag) {
                NSString *folderPath = [bundle pathForResource:self.defaultLag ofType:@"lproj"];
                self.defaultU8Bundle = [NSBundle bundleWithPath:folderPath];
            }
            if (!self.defaultU8Bundle) {
                NSString *folderPath = [bundle pathForResource:@"en" ofType:@"lproj"];
                self.defaultU8Bundle = [NSBundle bundleWithPath:folderPath];
            }
        }
    }
    
    if (!self.defaultU8Bundle) {
        return key;
    }

    NSString *valueStr = [self.defaultU8Bundle localizedStringForKey:key value:value table:nil];
    return valueStr ? valueStr:key;
}
/*
 zh-CN
 繁体中文-台湾    zh-TW
 繁体中文-香港    zh-HK
 英语    en
 日语    ja
 韩语    ko
 葡语    pt
 西语    es
 德语    de
 法语    fr
 意大利语    it
 阿拉伯语    ar-SA
 土耳其语    tr
  
 */
- (NSString *)bundleWithLanguage:(NSString *)language {
    
    NSString *searchLanguage = nil;
    
    if ([language hasPrefix:@"en"]) {
        searchLanguage = @"en";
    } else if ([language hasPrefix:@"zh"]) {
        if ([language rangeOfString:@"Hans"].location != NSNotFound) {
            searchLanguage = @"zh-Hans"; // 简体中文
        }else if ([[language lowercaseString]isEqualToString:@"zh-cn"]) {
            searchLanguage = @"zh-Hans"; // 简体中文
        } else { // zh-Hant\zh-HK\zh-TW
            searchLanguage = @"zh-Hant"; // 繁體中文
        }
    } else if ([language hasPrefix:@"ja"]) {
        searchLanguage = @"ja";
    }  else if ([language hasPrefix:@"ko"]) {
        searchLanguage = @"ko";
    } else if ([language hasPrefix:@"pt"]) {
        searchLanguage = @"pt";
    } else if ([language hasPrefix:@"es"]) {
        searchLanguage = @"es";
    } else if ([language hasPrefix:@"de"]) {
        searchLanguage = @"de";
    } else if ([language hasPrefix:@"fr"]) {
        searchLanguage = @"fr";
    } else if ([language hasPrefix:@"it"]) {
        searchLanguage = @"it";
    } else if ([language hasPrefix:@"ar"]) {
        searchLanguage = @"ar";
    } else if ([language hasPrefix:@"tr"]) {
        searchLanguage = @"tr";
    }
    
    return searchLanguage;
}

@end
