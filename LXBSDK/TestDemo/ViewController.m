//
//  ViewController.m
//  TestDemo
//
//  Created by pub on 2024/1/30.
//

#import "ViewController.h"
#import <LXBSDK/LXBSDK.h>
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)NSArray *actionLable;
@end

@implementation ViewController

- (void)viewDidLoad {
    [self initActionLable];
    [self tableViewInit];
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
    
    NSLog(@"xxx");

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.actionLable.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = self.actionLable[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            [SDKController sdkInit];
            break;
        case 1:
            [SDKController login];
            break;
        case 2:
            [SDKController createOrder];
            break;
        default:
            break;
    }
}

- (void)initActionLable{
    self.actionLable = @[
        @"SDKInit",
        @"游客登陆",
        @"创建订单",
        @"账号绑定检测",
        @"账号绑定",
        @"发送验证码",
        @"绑定更新",
        @"微信绑定",
        @"解封冻结账号",
        @"账号解绑",
        @"账号切换检测",
        @"账号切换",
        @"账号解绑",
        @"硬核渠道登录",
        @"一键、验证码登录",
        @"自动登录校验",
        
        @"账号解绑",
    ];
    
}

- (void)tableViewInit{
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.tableView = [[UITableView alloc] initWithFrame:rect];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

@end
