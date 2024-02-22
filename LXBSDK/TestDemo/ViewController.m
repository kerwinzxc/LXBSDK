//
//  ViewController.m
//  TestDemo
//
//  Created by pub on 2024/1/30.
//

#import "ViewController.h"
#import <LXBSDK/LXBSDK.h>
#import <CocoaLumberjack/CocoaLumberjack.h>

static DDLogLevel ddLogLevel = DDLogLevelDebug;
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)NSArray *actionLable;
@end

@implementation ViewController

- (void)viewDidLoad {
    [self initActionLable];
    [self tableViewInit];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [DDLog addLogger:[DDOSLogger sharedInstance]];
    DDFileLogger *fileLog = [[DDFileLogger alloc] init];
    fileLog.rollingFrequency = 60 * 60 *24;
    fileLog.logFileManager.maximumNumberOfLogFiles = 3;
    [DDLog addLogger:fileLog];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.actionLable.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = self.actionLable[indexPath.row];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            [[SDKController getInstance] sdkInit];
            break;
        case 1:
            [[SDKController getInstance] login];
            break;
        case 2:
            [[SDKController getInstance] realName];
            break;
        case 3:
            [[SDKController getInstance] createOrder];
            break;
        case 4:
            [[SDKController getInstance] appleBuy];
            break;
        case 5:
            [[SDKController getInstance] finishLostOrder];
            break;
        case 6:
            NSLog(@"DDLogDebug");
            break;
        case 7:
            
            break;
        case 8:
            [[SDKController getInstance] launchAppleBind];
            break;
        case 9:
            [[SDKController getInstance] autoLogin];
            break;
        case 10:
            [[SDKController getInstance] launchAppleLogin];
            break;
        case 11:
            [[SDKController getInstance] showCenter];
            break;
        case 12:
            [[SDKController getInstance] openLoginView];
            break;
        default:
            break;
    }
}

- (void)initActionLable{
    self.actionLable = @[
        @"0SDKInit",
        @"1游客登陆",
        @"2实名认证",
        @"3创建订单",
        @"4苹果内购",
        @"5处理未处理苹果订单",
        @"6绑定更新",
        @"7 30元购买",
        @"8bind Apple",
        @"9autoLogin",
        @"10apple login",
        @"11 showCenter",
        @"12 登录界面",
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
