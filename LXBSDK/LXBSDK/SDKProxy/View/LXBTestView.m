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
            
            break;
        case 2:
            [ViewHub openLoginView];
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        case 5:
            
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
        @"1  游客登陆",
        @"2  登录界面",
    ];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


- (void)test{
    ReqVisitor *req = [[ReqVisitor alloc] init];
    req.device_id = @"123456";
    req.uuid = @"123465";
    NSInteger cId = [U8_CHANNEL intValue];
    NSDictionary *dic = req.mj_keyValues;
}

- (void)payItem{
    [[PayController getInstance] QueryInfo:@"12yuan"];
}

- (void)appleBuy{
    [[PayController getInstance] appleBuyWithProId:@"12yuan"];
}

- (void)realName{
    ReqRealName *req = [[ReqRealName alloc] init];
    req.app_id = [U8_GAME_ID longLongValue];
    req.channel_id = [U8_CHANNEL longLongValue];
    req.account_id = [DataHub getInstance].useModel.account_id;
    req.realname = @"张胜";
    req.id_card = @"422128197201131431";
    [RealNameController realName:req success:^(id  _Nonnull responseObject) {
        DDLog(@"xx");
        } failure:^(NSError * _Nonnull error) {
            DDLog(@"xxxx");
        }];
}

- (void)createOrder{
    ReqPayCreate *req = [[ReqPayCreate alloc] init];
    req.account_id = [DataHub getInstance].useModel.account_id;
    req.amount = 100;
    req.currency = @"CNY";
    req.cash_fee = 100;
    req.cash_currency = @"CNY";
    req.body = @"body";
    req.detail = @"detaildetaildetaildetail";
    req.platform = @"apple";
    req.trade_type = @"APP";
    req.game_id = [U8_GAME_ID longLongValue];
    //游戏服id
    req.server_id = 1;
    //必须穿
    req.notify_url = @"";
    //必须穿
    req.extension = @"ext";
    //必须穿
    req.device_id = @"";
    req.product_id = @"12yuan";
    
    
    DDLog(@"%@",req.mj_keyValues);
    [PayController ceratePayOrder:req
                          success:^(id  _Nonnull responseObject) {
        NSLog(@"");
        
    }
                          failure:^(NSError * _Nonnull error) {
        DDLog(@"");
    }];
}
- (void)finishLostOrder{
    [[PayController getInstance] finishLostOrder];
}

@end
