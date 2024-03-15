//
//  LXBWebView.m
//  LXBSDK
//
//  Created by pub on 2024/2/21.
//

#import "LXBWebView.h"

@interface LXBWebView ()

@property(nonatomic, strong)NSString *urlStr;
@property(nonatomic, strong)NSString *title;
@end

@implementation LXBWebView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init{
    self = [super init];
    return self;
}

- (instancetype)initWithUrl:(NSString *)url title:(NSString *)title{
    self = [self init];
    self.urlStr = url;
    self.title = title;
    [self initView];
    return self;
}

- (void)initView{
    UIScreen *screen = [UIScreen mainScreen];
    self.frame = CGRectMake(0, 0, screen.bounds.size.width, screen.bounds.size.height);
    UIColor *color = [UIColor blackColor];
    self.backgroundColor = [color colorWithAlphaComponent:0.04];
    
    _contentView = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Vert];
    
    _contentView.myHeight = MyLayoutSize.fill;
    _contentView.myWidth = MyLayoutSize.fill;
    _contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_contentView];
    _contentView.insetsPaddingFromSafeArea = UIRectEdgeTop | UIRectEdgeLeft | UIRectEdgeRight;
   
    [_contentView addSubview:self.titleView];
    [self initProgressView];
    [self initWebView];
}

- (MyBaseLayout *)titleView{
    if(_titleView == nil){
        _titleView = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Horz];
        _titleView.myWidth = MyLayoutSize.fill;
        _titleView.backgroundColor = [LXBHelper titleBgView];
        _titleView.myHeight = UI(50);
        _titleView.myWidth = MyLayoutSize.fill;
        _titleView.gravity = MyGravity_Horz_Left;
        
        MyLinearLayout *closeView = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Horz];
        closeView.myHeight = MyLayoutSize.fill;
        closeView.myWidth = UI(60);
        //closeView.backgroundColor = [UIColor orangeColor];
        closeView.gravity = MyGravity_Vert_Center;
        [_titleView addSubview:closeView];
        
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.image = [UIImage systemImageNamed:@"chevron.left"];//[LXBHelper imageWithName:@"DeceptionMagicpoint"];
        imgView.myHeight = UI(28);
        imgView.myWidth = UI(20);
        imgView.myLeft = UI(12);
        LXBUITap *tap = [[LXBUITap alloc] init];
        [imgView setUserInteractionEnabled:YES];
        [tap addTarget:self action:@selector(closeBtnClick:)];
        [imgView addGestureRecognizer:tap];
        [closeView addSubview:imgView];
        
        
        MyLinearLayout *textView = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Horz];
        textView.myHeight = MyLayoutSize.fill;
        textView.weight = 1;
        textView.gravity = MyGravity_Center;
        //textView.backgroundColor = [UIColor redColor];
        [_titleView addSubview:textView];
        
        UILabel *label = [UILabel new];
        if(self.title != nil){
            label.text = self.title;
        }
        else{
            label.text = @"";
        }
        label.font = [UIFont boldSystemFontOfSize:UI(16)];
        label.myHeight = MyLayoutSize.wrap;
        [label sizeToFit];
        label.textAlignment = NSTextAlignmentCenter;
        [textView addSubview:label];
        
        MyLinearLayout *menu = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Horz];
        menu.myHeight = MyLayoutSize.fill;
        menu.myWidth = UI(60);
        //menu.backgroundColor = [UIColor blueColor];
        [_titleView addSubview:menu];
    }
    return _titleView;
}

- (void)initWebView{
    MyLinearLayout *layout = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Vert];
    layout.myWidth = MyLayoutSize.fill;
    layout.weight = 1;
    [_contentView addSubview:layout];
    
    _webView = [[WKWebView alloc] init];
    _webView.myWidth = MyLayoutSize.fill;
    _webView.myHeight = MyLayoutSize.fill;
    [layout addSubview:_webView];
    
}

- (void)showWeb:(NSString *)urlStr{
    NSString *urlString = urlStr;
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"] && object == self.webView) {
        // 更新进度条
        [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
        DDLog(@"xxxxx");
        // 进度达到1.0时隐藏进度条
        if (self.webView.estimatedProgress >= 1.0) {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.progressView.alpha = 0.0;
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0 animated:NO];
            }];
        }
    }
}


- (void)closeBtnClick:(LXBUITap *)send{
    DDLog(@"xxxxxxx");
    [self destroy];
}

- (void)onDestroy{
    [super onDestroy];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)initProgressView{
    _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    
    _progressView.myHeight = 2;
    _progressView.myWidth = MyLayoutSize.fill;
    [self.contentView addSubview:_progressView];
}

@end
