//
//  LXBTestView.m
//  LXBSDK
//
//  Created by pub on 2024/3/13.
//

#import "LXBTestView.h"
#import "ReqVisitor.h"
#import "PayController.h"
#import "ReqRealName.h"
#import "RealNameController.h"
#import "AppleLoginController.h"
#import "SDKController.h"
@interface LXBTestView ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSArray *actionLable;
@end

@implementation LXBTestView

- (instancetype)init{
    self = [super init];
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
    
    MyLinearLayout *layout = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    layout.myHeight = MyLayoutSize.fill;
    layout.myWidth = MyLayoutSize.fill;
    layout.padding = UIEdgeInsetsMake(100, 30, 100, 30);
    layout.layer.cornerRadius = 6;
    [self addSubview:layout];
    
    
    [self initActionLable];
    
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.myHeight = MyLayoutSize.fill;
    self.tableView.myWidth = MyLayoutSize.fill;
    self.tableView.layer.cornerRadius = 4;
                      
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor orangeColor];
    [layout addSubview:self.tableView];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.actionLable.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = self.actionLable[indexPath.row];
    cell.backgroundColor = [UIColor grayColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            [self destroy];
            break;
        case 1:
            [[SDKController getInstance] openWebView:@"https://www.baidu.com"];
            break;
        case 2:
            [ViewHub openLoginView];
            break;
        case 3:
            [LXBHelper showToast:@"xxx xxx xxx xxxx xxxxxxxxx xxxxx xxxxx xxx"];
            break;
        case 4:
            [self createOrder];
            break;
        case 5:
            [self appleBuy];
            break;
        case 6:
            break;
        case 7:
            break;
        case 8:
            break;
        case 9:
            
            break;
        case 10:
           
            break;
        default:
            break;
    }
}

- (void)initActionLable{
    self.actionLable = @[
        @"0  关闭自己",
        @"1  打开网页",
        @"2  登录界面",
        @"3  Tost测试",
        @"4  正常支付",
        @"5  直接拉起啊苹果支付",
    ];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


- (void)test{

}

- (void)payItem{
    //[[PayController getInstance] QueryInfo:@"12yuan"];
}

- (void)appleBuy{
    [[PayController getInstance] appleBuyWithProId:@"12yuan"];
}

- (void)realName{
    ReqRealName *req = [[ReqRealName alloc] init];
    
    req.app_id = [[SDKModel getInstance].sdkArg.U8_GAME_ID longLongValue];
    req.channel_id = [[SDKModel getInstance].sdkArg.U8_CHANNEL longLongValue];
    req.account_id = [DataHub getInstance].userModel.account_id;
    req.realname = @"张胜";
    req.id_card = @"422128197201131431";
    [RealNameController realName:req success:^(id  _Nonnull responseObject) {
        DDLog(@"xx");
        } failure:^(NSError * _Nonnull error) {
            DDLog(@"xxxx");
        }];
}

- (void)createOrder{
    NSDictionary *dic = @{
        @"product_id":@"12yuan",
        @"amount":@"100",
        @"body":@"body",
        @"detail":@"more detail",
        @"server_id":@"1",
        @"notify_url":@"https:www.baidu.com",
        @"extension":@"ext",
    };
    [[PayController getInstance] lxbPay:dic];
    
}
- (void)finishLostOrder{
    [[PayController getInstance] finishLostOrder];
}

- (void)testwwew{
//    - (void)QueryInfo:(NSString *)proId{
//        // 请求商品信息
//        NSSet *productIdentifiers = [NSSet setWithObject:proId];
//        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
//        productsRequest.delegate = self;
//        [productsRequest start];
//    }
}

@end
