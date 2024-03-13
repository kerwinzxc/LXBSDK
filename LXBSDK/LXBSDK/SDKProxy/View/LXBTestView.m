//
//  LXBTestView.m
//  LXBSDK
//
//  Created by pub on 2024/3/13.
//

#import "LXBTestView.h"

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
    
    [self initActionLable];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.frame];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor orangeColor];
    [self addSubview:self.tableView];
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
        @"0关闭自己",
        @"1游客登陆",
    ];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}


@end
