//
//  ViewHub.h
//  LXBSDK
//
//  Created by pub on 2024/3/13.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface ViewHub : NSObject
+ (void)openKeFuView;
+ (void)openLoginView;
+ (void)openWebView:(NSString *)urlString title:(NSString *)title;
+ (void)openCenterView;
@end

NS_ASSUME_NONNULL_END
