//
//  MySetViewController.m
//  GuoKe
//
//  Created by mac on 15/9/25.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "MySetViewController.h"

@interface MySetViewController () <UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}

@end

@implementation MySetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self _initTableView];
}
- (void)_initTableView{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    
    _tableView.delegate =self;
    _tableView.dataSource = self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1 || section == 3) {
        return 1;
    }
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.textLabel.text = @"点击登录";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else if (indexPath.section == 1 && indexPath.row == 0){
        cell.textLabel.text = @"自动离线下载";
        UISwitch *MySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(320, 5, 40, 30)];
        [cell.contentView addSubview:MySwitch];
        
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"大字体";
            UISwitch *MySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(320, 5, 40, 30)];
            [cell.contentView addSubview:MySwitch];
        }else{
            cell.textLabel.text = @"清理缓存";
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(320, 5, 40, 30)];
            label.text = @"0.0M";
            [cell.contentView addSubview:label];
            
            NSString *homePath = NSHomeDirectory();
            NSLog(@"%@",homePath);
        }
    }else if (indexPath.section == 3 && indexPath.row == 0){
        cell.textLabel.text = @"关于我们";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, kScreenWidth, 20)];
        label.text = @"打开后，WIFI下将自动下载最新的20篇文章提供离线下载";
        label.font = [UIFont systemFontOfSize:13.0f];
        label.textColor = [UIColor colorWithWhite:0.4 alpha:0.5];
        label.textAlignment = NSTextAlignmentCenter;
        return label;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.item == 0) {  //登录
        
    }else if (indexPath.section == 3 && indexPath.item == 0){ // 关于我们
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
