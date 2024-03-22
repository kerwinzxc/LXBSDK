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
#import <SVProgressHUD/SVProgressHUD.h>
#import <ThinkingSDK/ThinkingSDK.h>
#import <MJExtension/MJExtension.h>
static DDLogLevel ddLogLevel = DDLogLevelDebug;
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)NSArray *actionLable;
@end

@implementation ViewController

- (void)loadView{
    [super loadView];
}

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
    
    
    
    NSLog(@"viewDidLoadviewDidLoadviewDidLoadviewDidLoad");
    
    [[SDKController getInstance] AdInitAfterControllerDidInit:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rewardedAdFinish:) name:AdRewardedNotiName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccHandle:) name:PaySuccNotiName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payFailHandle:) name:PayFailNotiName object:nil];
    
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
            // showToastWithMessage:@"王二麻子"];
            break;
        case 2:
            [[SDKController getInstance] showRewardedAd];
            break;
        case 3:
            [[SDKController getInstance] openCenterView];
            break;
        case 4:
            [[SDKController getInstance] showToast:@"王二麻子我反反复复"];
            break;
        case 5:
            [[SDKController getInstance] showToast:@"王二麻子仿佛山山水水反反复复发发发反反复复发的是冯绍峰地方奋斗奋斗发生的奋斗"];
            break;
        case 6:
            
            //[[[UIApplication sharedApplication] delegate] window].rootViewController
            break;
        case 7:
            [self shushuTest];
            break;
        case 8:
            [[SDKController getInstance] sdkLogin];
            break;
        default:
            break;
    }
}

- (void)initActionLable{
    self.actionLable = @[
        @"0  测试窗口",
        @"1  iToast",
        @"2  激励广告",
        @"3  用户中心",
        @"4  MyToast",
        @"5  大Toast",
        @"6  转菊花",
        @"7  数数测试",
        @"8  自动登录",
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



- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)paySuccHandle:(NSNotification *)noti{
    NSLog(@"pay succ  %@", noti.object);
    NSDictionary * dic = [self dictiognaryWithJsonString:noti.object];
    int price = [[dic objectForKey:@"amount"] intValue];
    int price2 = price / 100;
    
    [[SDKController getInstance] trackPurchase:@"576c1d" amount:price2 currency:@"USD"];
}

- (void)payFailHandle:(NSNotification *)noti{
    NSLog(@"pay fail  %@", noti.object);
}

- (void)rewardedAdFinish:(NSNotification *)noti{
    LXBADInfo *info = (LXBADInfo *)noti.object;
    NSLog(@"---%@", [info mj_JSONString]);
}

- (NSString *)jsonSgtringWithDict:(NSDictionary *)dict {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

- (NSDictionary *)dictiognaryWithJsonString:(NSString *)jsonString{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        return nil;
    }
    return dic;
}


- (void)shushuTest{
    [TDAnalytics track:@"login_call"];
}

@end
