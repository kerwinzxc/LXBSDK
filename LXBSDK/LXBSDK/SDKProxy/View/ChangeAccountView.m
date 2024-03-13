//
//  ChangeAccountView.m
//  LXBSDK
//
//  Created by pub on 2024/2/19.
//

#import "ChangeAccountView.h"
#import "GoogleLoginController.h"
@implementation ChangeAccountView

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

- (void)initViews{
    [super initViews];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self initMenuView];
}

- (void)initMenuView{
    NSArray *cfg = [LXBConfig getInstance].changeAccViewCfg;
    for (int i = 0; i < cfg.count; i++) {
        NSDictionary *dic = cfg[i];
        
        MyLinearLayout *bindApple = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Horz];
        bindApple.myWidth = MyLayoutSize.fill;
        bindApple.gravity = MyGravity_Center;
        bindApple.layer.cornerRadius = UI(20);
        bindApple.subviewHSpace = UI(10);
        bindApple.backgroundColor = [LXBHelper bgViewColor];
        bindApple.myHeight = UI(50);
        bindApple.tag = i;
        bindApple.myTop = UI(13);
        LXBUITap *tap = [[LXBUITap alloc] init];
        [tap addTarget:self action:@selector(viewClick:)];
        [bindApple addGestureRecognizer:tap];
        
        NSString *imgName = dic[@"imgName"];
        if([imgName isEqual:@""] == false){
            UIImageView *appleIcon = [[UIImageView alloc] init];
            appleIcon.image = [LXBHelper imageWithName:imgName];
            appleIcon.myHeight = UI(28);
            appleIcon.myWidth = UI(28);
            [bindApple addSubview:appleIcon];
        }
        
        UILabel *titleLable = [UILabel new];
        titleLable.text = dic[@"showText"];
        titleLable.myWidth = MyLayoutSize.wrap;
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.myHeight = MyLayoutSize.wrap;
        titleLable.font = [UIFont boldSystemFontOfSize:UI(18)];
        titleLable.textColor = [LXBHelper normalTextColor];
        [titleLable sizeToFit];
        [bindApple addSubview:titleLable];
        [self.contentView addSubview:bindApple];
    }
}

- (void)viewClick:(LXBUITap *)send{
    DDLog(@"--- %li" ,send.view.tag);
    if(send.view.tag == 0){
       //todo facebook 登录
        //[[NSNotificationCenter defaultCenter] postNotificationName:CloseAllViewNotiName object:nil];
    }
    else if (send.view.tag == 1){
        [[GoogleLoginController getInstance] googleLogin];
    }
    else if (send.view.tag == 3){
        [self destroy];
    }
}

@end
