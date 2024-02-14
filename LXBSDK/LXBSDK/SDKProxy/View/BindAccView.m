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
    [self.contentView addSubview:self.bindApple];
}



- (MyLinearLayout *)desView{
    if (_desView == nil) {
        _desView = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Horz];
        _desView.topPos.equalTo(self.titleView.bottomPos).offset(UI(20));
        UILabel *desLable = [UILabel new];
        //titleLable.text = getLocalString(@"user_account_ui_usercenter");
        desLable.text = @"xxxxxx";
        desLable.myWidth = MyLayoutSize.wrap;
        desLable.textAlignment = NSTextAlignmentCenter;
        desLable.myHeight = MyLayoutSize.wrap;
        desLable.font = [UIFont boldSystemFontOfSize:UI(18)];
        desLable.textColor = [UIColor blackColor];
        desLable.myCenterY = 0;
        desLable.myCenterX = 0;
        
        [_desView addSubview:desLable];
    }
    
    return _desView;
}

- (MyLinearLayout *)bindApple{
    if (_bindApple == nil) {
        _bindApple = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Horz];
        _bindApple.topPos.equalTo(self.desView.bottomPos).offset(10);
        _bindApple.myWidth = MyLayoutSize.fill;
        _bindApple.gravity = MyGravity_Center;
        _bindApple.layer.cornerRadius = UI(6);
        _bindApple.subviewHSpace = UI(10);
        _bindApple.backgroundColor = [UIColor whiteColor];
        _bindApple.myHeight = UI(50);
        UIImageView *appleIcon = [[UIImageView alloc] init];
        appleIcon.image = [LXBHelper imageWithName:@"PingIcon"];
        appleIcon.myHeight = UI(40);
        appleIcon.myWidth = UI(40);
        [_bindApple addSubview:appleIcon];
        
        UILabel *titleLable = [UILabel new];
        //titleLable.text = getLocalString(@"user_account_ui_usercenter");
        titleLable.text = @"APPLE";
        titleLable.myWidth = MyLayoutSize.wrap;
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.myHeight = MyLayoutSize.wrap;
        titleLable.font = [UIFont boldSystemFontOfSize:UI(18)];
        titleLable.textColor = [UIColor blackColor];
        [titleLable sizeToFit];
        
        [_bindApple addSubview:titleLable];
    }
    return _bindApple;
}


@end
