//
//  DeleteAccConfirmView.m
//  LXBSDK
//
//  Created by pub on 2024/2/20.
//

#import "DeleteAccConfirmView.h"

@interface DeleteAccConfirmView ()
@property(nonatomic, assign)BOOL hasScrollButtom;
@end

@implementation DeleteAccConfirmView



- (instancetype)init{
    self = [super init];
    
    [self initViews];
    
    [self initDatum];
    
    [self initListeners];
    return self;
}

- (void)initDatum{
    self.hasScrollButtom = NO;
}

- (void)initListeners{
    
}

- (void)initViews{
    UIScreen *screen = [UIScreen mainScreen];
    self.frame = CGRectMake(0, 0, screen.bounds.size.width, screen.bounds.size.height);
    UIColor *color = [UIColor blackColor];
    self.backgroundColor = [color colorWithAlphaComponent:0.04];
    _contentView = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Vert];
    _contentView.gravity = MyGravity_Horz_Center;
    _contentView.myCenterX = 0;
    _contentView.myCenterY = 0;
    _contentView.myHeight = UI(380);
    _contentView.myWidth = UI(390);
    _contentView.layer.cornerRadius = UI(10);
    _contentView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:_contentView];
    
    [self initTiltle];
    [self initScrollView];
    [self initButtomBtn];
}

- (void)initTiltle{
    MyLinearLayout *titleView = [[MyLinearLayout alloc] init];
    titleView.myWidth = MyLayoutSize.fill;
    titleView.gravity = MyGravity_Center;
    titleView.myHeight = UI(60);
    titleView.backgroundColor = [LXBHelper btnBGColor];
    
    [self.contentView addSubview:titleView];
    
    UILabel *label = [UILabel new];
    label.text = getLocalString(@"u8_account_cutacc_delete_warper_title");
    label.font = [UIFont boldSystemFontOfSize:UI(18)];
    [label sizeToFit];
    
    [titleView addSubview:label];
    
}

- (void)initScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.myWidth = MyLayoutSize.fill;
    scrollView.weight = 1;
    _scorllView = scrollView;
    scrollView.delegate = self;
    //_scorllView.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:scrollView];
    
    
    MyLinearLayout *contentLayout = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    contentLayout.padding = UIEdgeInsetsMake(10, 10, 10, 10); //设置布局内的子视图离自己的边距.
    contentLayout.myHorzMargin = 0;                          //同时指定左右边距为0表示宽度和父视图一样宽
    contentLayout.heightSize.lBound(scrollView.heightSize, 10, 1); //高度虽然是自适应的。但是最小的高度不能低于父视图的高度加10.
    [scrollView addSubview:contentLayout];
    
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"xxxxxxx";
    label.font = [UIFont boldSystemFontOfSize:UI(16)];
    label.myTop = 20;
    label.textColor = [UIColor grayColor];
    label.myLeading = label.myTrailing = 0;
    label.myHeight = MyLayoutSize.wrap;
    label.textAlignment = NSTextAlignmentCenter;
    [contentLayout addSubview:label];
    
    
}

- (void)initButtomBtn{
    UIView *view = [[UIView alloc] init];
    view.myWidth = MyLayoutSize.fill;
    view.myHeight = 1;
    view.topPos.equalTo(self.scorllView.bottomPos).offset(UI(6));
    view.backgroundColor = [LXBHelper btnBGColor];
    [self.contentView addSubview:view];
    
    MyLinearLayout *btnParent = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Horz];
    btnParent.myHeight = UI(60);
    btnParent.myWidth = MyLayoutSize.fill;
    btnParent.gravity = MyGravity_Center;
    [self.contentView addSubview:btnParent];
    btnParent.subviewHSpace = UI(30);
    
    MyLinearLayout *left = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Horz];
    left.myHeight = UI(50);
    left.myWidth = UI(130);
    left.layer.cornerRadius = UI(6);
    left.backgroundColor = [UIColor clearColor];
    left.gravity = MyGravity_Center;
    [btnParent addSubview:left];
    UILabel *label = [UILabel new];
    label.text = getLocalString(@"u8_account_cutacc_warper_tips_cancle");
    label.font = [UIFont boldSystemFontOfSize:UI(16)];
    [label sizeToFit];
    [left addSubview:label];
    left.tag = 1;
    
    UIView *vLine = [[UIView alloc] init];
    vLine.myWidth = 1;
    vLine.myHeight = MyLayoutSize.fill;
    vLine.backgroundColor = [LXBHelper btnBGColor];
    [btnParent addSubview:vLine];
    
    MyLinearLayout *right = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Horz];
    right.myHeight = UI(50);
    right.myWidth = UI(130);
    right.layer.cornerRadius = UI(6);
    right.backgroundColor = [UIColor clearColor];
    right.gravity = MyGravity_Center;
    [btnParent addSubview:right];
    
    UILabel *confirmTxt = [UILabel new];
    confirmTxt.text = getLocalString(@"u8_account_cutacc_delete_confirm_yes_btn");
    confirmTxt.textColor = [LXBHelper btnBGColor];;
    confirmTxt.font = [UIFont boldSystemFontOfSize:UI(16)];
    [confirmTxt sizeToFit];
    [right addSubview:confirmTxt];
    right.tag = 2;
    _deleteUILabel = confirmTxt;
    
    LXBUITap *tap = [LXBUITap new];
    [tap addTarget:self action:@selector(btnClick:)];
    [right addGestureRecognizer:tap];
    [left addGestureRecognizer:tap];
}

- (void)btnClick:(LXBUITap *)send{
    if(send.view.tag == 1){
        [self clsoeView];
    }
    else if(send.view.tag == 2){
        if (self.hasScrollButtom == YES) {
            [self showSecView];
        }
    }
}

- (void)clsoeView{
    [self destroy];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
    if(bottomEdge >= scrollView.contentSize.height){
        if(self.hasScrollButtom == NO){
            [self changeBtnStutas];
        }
        self.hasScrollButtom = YES;
    }
}

- (void)changeBtnStutas{
    self.deleteUILabel.textColor = [UIColor redColor];
}

- (void)showSecView{
    
}

@end
