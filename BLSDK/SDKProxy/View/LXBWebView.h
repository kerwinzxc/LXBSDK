//
//  LXBWebView.h
//  LXBSDK
//
//  Created by pub on 2024/2/21.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface LXBWebView : LXBBaseView

@property(nonatomic, strong)MyLinearLayout *contentView;

@property(nonatomic, strong)MyBaseLayout *titleView;

@property(nonatomic, strong)WKWebView *webView;

@property(nonatomic, strong)UIProgressView *progressView;

- (instancetype)initWithUrl:(NSString *)url title:(NSString *)title;

- (void)showWeb:(NSString *)urlStr;
@end

NS_ASSUME_NONNULL_END
