//
//  LeftViewController.m
//  GuoKe
//
//  Created by mac on 15/9/25.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "LeftViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MyCommentViewController.h"
#import "MySetViewController.h"
#import "MyStoreViewController.h"
#import "HomeViewController.h"

static NSString *identify = @"CellId";

@interface LeftViewController ()

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    
    [self _loadData];
    [self _initTableView];
}
//数据读取
- (void)_loadData{
    _rowNameArray = @[@"首页",@"我的收藏",@"设置",@"请吐槽",@"来个好评吧！"];
//    _rowImageArray = @[];
    
}
//初始化视图
- (void)_initTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 300, kScreenHeight)style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    _tableView.backgroundView = nil;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //取消滑动
    _tableView.scrollEnabled = NO;
//    _tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    
    [self.view addSubview:_tableView];
}
#pragma mark - tableView 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _rowNameArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        
    }
    cell.textLabel.text = [NSString stringWithFormat:@"       %@",_rowNameArray[indexPath.row]];
    cell.textLabel.textColor = [UIColor whiteColor];
//    cell.imageView.image = [UIImage imageNamed:@""];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.backgroundColor = [UIColor clearColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0)     { //首页
        HomeViewController *home = [[HomeViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:home];
        
        [self.mm_drawerController setCenterViewController:nav withCloseAnimation:YES completion:nil];
        
    }else if (indexPath.row ==1){ //我的收藏
        MyStoreViewController *myStore = [[MyStoreViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:myStore];
        
        [self.mm_drawerController setCenterViewController:nav withCloseAnimation:YES completion:nil];
        
    }else if (indexPath.row ==2){ //设置
        MySetViewController *mySet = [[MySetViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mySet];
        
        [self.mm_drawerController setCenterViewController:nav withCloseAnimation:YES completion:nil];
        
    }else if (indexPath.row ==3){ //请吐槽
        MyCommentViewController *myComment = [[MyCommentViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:myComment];
        
        [self.mm_drawerController setCenterViewController:nav withCloseAnimation:YES completion:nil];
        
    }else if (indexPath.row ==4){ //来个好评吧
        
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
