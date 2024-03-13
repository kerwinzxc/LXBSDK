//
//  ViewController.m
//  TestDemo
//
//  Created by pub on 2024/1/30.
//

#import "ViewController.h"
#import <LXBSDK/LXBSDK.h>
#import <LXBSDK/LXBConfig.h>
#import <LXBSDK/LXBADInfo.h>
#import <CocoaLumberjack/CocoaLumberjack.h>
#import <ZHToast/ZHToastView.h>
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
    
    NSString *adID = @"ca-app-pub-3940256099942544/1712485313";
    [[SDKController getInstance] AdInitAfterControllerDidInit:self adID:adID];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showRewardedAd:) name:AdRewardedNotiName object:nil];
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
            [[SDKController getInstance] openTestView];
            break;
        case 1:
            [[SDKController getInstance] sdkInit];
            break;
        case 2:
            [[SDKController getInstance] login];
            break;
        case 3:
            [[SDKController getInstance] realName];
            break;
        case 4:
            [[SDKController getInstance] createOrder];
            break;
        case 5:
            [[SDKController getInstance] appleBuy];
            break;
        case 6:
            [[SDKController getInstance] launchAppleBind];
            break;
        case 7:
            [[SDKController getInstance] autoLogin];
            break;
        case 8:
            [[SDKController getInstance] launchAppleLogin];
            break;
        case 9:
            [[SDKController getInstance] showCenter];
            break;
        case 10:
            [[SDKController getInstance] openLoginView];
            break;
        case 11:
            [[SDKController getInstance] showRewardedAd];
            break;
        default:
            break;
    }
}

- (void)initActionLable{
    self.actionLable = @[
        @"0  测试窗口",
        @"1  初始化",
        @"2  游客登陆",
        @"3  实名认证",
        @"4  创建订单",
        @"5  苹果内购",
        @"6  绑定苹果",
        @"7  自动登录",
        @"8  苹果登录",
        @"9  用户中心",
        @"10 登录界面",
        @"11 激励广告",
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

- (void)showRewardedAd:(NSNotification *)noti{
    LXBADInfo *info = (LXBADInfo *)noti.object;
    
    NSLog(@"---%@", info.adType);
}


- (void)toast1{
   
}

- (void)toast2{
    //[LXBHelper showNormalDialogViewController];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
