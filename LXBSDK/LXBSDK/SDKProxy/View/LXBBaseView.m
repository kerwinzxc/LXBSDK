//
//  BaseView.m
//  LXBSDK
//
//  Created by xiaolong on 2024/2/12.
//

#import "LXBBaseView.h"

@interface LXBBaseView ()
@property(nonatomic, strong)NSString *titleString;
@property(nonatomic, assign)BOOL rightClose;
@end


@implementation LXBBaseView



- (instancetype)init{
    self = [super init];
    
    [self initViews];
    
    [self initDatum];
    
    [self initListeners];
    return self;
}


- (instancetype)initTitle:(NSString *)title isRightCloseBtn:(BOOL)rightClose{
    self = [super init];
    
    self.titleString = title;
    self.rightClose = rightClose;
    
    [self initViews];
    
    [self initDatum];
    
    [self initListeners];
    return self;
}


- (void)initDatum{
    
}

- (void)initListeners{
    
}

- (void)initViews{
    UIScreen *screen = [UIScreen mainScreen];
    self.frame = CGRectMake(0, 0, screen.bounds.size.width, screen.bounds.size.height);
    UIColor *color = [UIColor blackColor];
    self.backgroundColor = [color colorWithAlphaComponent:0.04];
    _rootContainer = [[MyFrameLayout alloc] init];
    _rootContainer.gravity = MyGravity_Center;
    _rootContainer.myCenterX = 0;
    _rootContainer.myCenterY = 0;
    _rootContainer.myHeight = MyLayoutSize.fill;
    _rootContainer.myWidth = MyLayoutSize.fill;
    _rootContainer.backgroundColor = [UIColor clearColor];
    
    [self addSubview:_rootContainer];
    [_rootContainer addSubview:self.bgView];
    [_rootContainer addSubview:self.contentView];
    [self.contentView addSubview:self.titleView];
}

- (MyFrameLayout *)titleView{
    if (_titleView == nil) {
        _titleView = [[MyFrameLayout alloc] init];
        _titleView.myWidth = MyLayoutSize.fill;
        _titleView.myHeight = UI(40);
        UILabel *titleLable = [UILabel new];
        //titleLable.text = getLocalString(@"user_account_ui_usercenter");
        titleLable.text = self.titleString;
        titleLable.myWidth = MyLayoutSize.wrap;
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.myHeight = MyLayoutSize.wrap;
        titleLable.font = [UIFont boldSystemFontOfSize:UI(18)];
        titleLable.textColor = [UIColor blackColor];
        titleLable.myCenterY = 0;
        titleLable.myCenterX = 0;
        [_titleView addSubview:titleLable];
        
        UIImageView *closeBtn = [[UIImageView alloc] init];
        [closeBtn setUserInteractionEnabled:YES];
        closeBtn.myHeight = UI(28);
        closeBtn.myWidth = UI(28);
        closeBtn.topPos.equalTo(_titleView.topPos).offset(10);
        if(self.rightClose){
            //UIView *closeBtn = [[UIView alloc] init];
            closeBtn.image = [LXBHelper imageWithName:@"DeceptionMagicpoint"];
            closeBtn.rightPos.equalTo(_titleView.rightPos);
            
        }
        else{
            closeBtn.image = [LXBHelper imageWithName:@"GoBack"];
            closeBtn.leftPos.equalTo(_titleView.leftPos);
        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
        [tap addTarget:self action:@selector(closeBtnClick)];
        [closeBtn addGestureRecognizer:tap];
        [_titleView addSubview:closeBtn];
    }

    return _titleView;
}


- (UIImageView *)bgView{
    if(_bgView == nil){
        _bgView = [[UIImageView alloc] init];
        _bgView.image = [LXBHelper imageWithName:@"UcBgView"];
        _bgView.myWidth = UI(390);
        _bgView.myHeight = UI(300);
        _bgView.myCenterX = 0;
        _bgView.myCenterY = 0;
    }
    return _bgView;
}


- (MyBaseLayout *)contentView{
    if(_contentView == nil){
        _contentView = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Vert];
        _contentView.myWidth = UI(360);
        _contentView.myHeight = UI(300);
        _contentView.gravity = MyGravity_Horz_Center;
        _contentView.subviewSpace = UI(10);
    }
    return _contentView;
}

- (void)closeBtnClick{
    [self removeFromSuperview];
}


@end
