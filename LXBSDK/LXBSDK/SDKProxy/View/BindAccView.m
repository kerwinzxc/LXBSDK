//
//  BindAccView.m
//  LXBSDK
//
//  Created by xiaolong on 2024/2/12.
//

#import "BindAccView.h"

@implementation BindAccView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) initViews{
    [super initViews];
    
    [self.contentView addSubview:self.desView];
    //[self.contentView addSubview:self.bindApple];
    
    [self initBindSubView];
}



- (MyLinearLayout *)desView{
    if (_desView == nil) {
        _desView = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Horz];
        _desView.topPos.equalTo(self.titleView.bottomPos).offset(UI(1));
        //_desView.backgroundColor = [UIColor greenColor];
        _desView.myWidth = MyLayoutSize.fill;
        _desView.myHeight = UI(120);
        UILabel *desLable = [UILabel new];
        //titleLable.text = getLocalString(@"user_account_ui_usercenter");
        desLable.text = getLocalString(@"user_account_ui_bind_des");
        desLable.myWidth = MyLayoutSize.fill;
        desLable.myHeight = MyLayoutSize.fill;
        desLable.textAlignment = NSTextAlignmentLeft;
        desLable.font = [UIFont boldSystemFontOfSize:UI(16)];
        desLable.textColor = [UIColor grayColor];
        desLable.numberOfLines = 5;
        desLable.myCenterY = 0;
        desLable.myCenterX = 0;
        [_desView addSubview:desLable];
    }
    
    return _desView;
}

- (void)initBindSubView{
    NSArray *cfg = [LXBConfig getInstance].bindViewCfg;
    for (int i = 0; i < cfg.count; i++) {
        NSDictionary *dic = cfg[i];
        MyLinearLayout *bindApple = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Horz];
        bindApple.myWidth = MyLayoutSize.fill;
        bindApple.gravity = MyGravity_Center;
        
        bindApple.layer.cornerRadius = UI(6);
        bindApple.subviewHSpace = UI(10);
        bindApple.backgroundColor = [UIColor whiteColor];
        bindApple.myHeight = UI(50);
        bindApple.tag = i;
        LXBUITap *tap = [[LXBUITap alloc] init];
        [tap addTarget:self action:@selector(viewClick:)];
        [bindApple addGestureRecognizer:tap];
        UIImageView *appleIcon = [[UIImageView alloc] init];
        
        appleIcon.image = [LXBHelper imageWithName:dic[@"imgName"]];
        appleIcon.myHeight = UI(24);
        appleIcon.myWidth = UI(24);
        [bindApple addSubview:appleIcon];
        UILabel *titleLable = [UILabel new];
        titleLable.text = dic[@"showText"];
        titleLable.myWidth = MyLayoutSize.wrap;
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.myHeight = MyLayoutSize.wrap;
        titleLable.font = [UIFont boldSystemFontOfSize:UI(18)];
        titleLable.textColor = [UIColor blackColor];
        [titleLable sizeToFit];
        [bindApple addSubview:titleLable];
        [self.contentView addSubview:bindApple];
    }
}

- (void)viewClick:(LXBUITap *)send{
    DDLog(@"%li", send.view.tag);
}

@end
