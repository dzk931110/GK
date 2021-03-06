//
//  MySetViewController.m
//  GuoKe
//
//  Created by mac on 15/9/25.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "MySetViewController.h"
#import "LoginViewController.h"
#import "SinaWeibo.h"
#import "AppDelegate.h"

@interface MySetViewController () <UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    UITableView *_tableView;
    UILabel *_label;
    UISwitch *mySwitch;
    UIButton *button;
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
    
    _tableView.delegate = self;
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
        
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        button = [[UIButton alloc] initWithFrame:CGRectMake(250, 5, 80, 30)];
        [cell.contentView addSubview:button];
        if ([appDelegate.sinaweibo isLoggedIn] ) {
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:0.5]];
            [button setTitle:@"登出" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(logOutAction) forControlEvents:UIControlEventTouchUpInside];
        }

    }else if (indexPath.section == 1 && indexPath.row == 0){
        cell.textLabel.text = @"自动离线下载";
        UISwitch *MySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(kScreenWidth-40-20, 5, 40, 30)];
        [cell.contentView addSubview:MySwitch];
        
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"大字体";
            mySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(kScreenWidth-40-20, 5, 40, 30)];
//            [mySwitch setOn:NO];
            [mySwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
            
            [cell.contentView addSubview:mySwitch];
        }else{
            cell.textLabel.text = @"清理缓存";
            _label = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-40-20, 5, 100, 30)];
            [cell.contentView addSubview:_label];
            [self count];

        }
    }else if (indexPath.section == 3 && indexPath.row == 0){
        cell.textLabel.text = @"关于我们";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, kScreenWidth, 20)];
        label.text = @"打开后，WIFI下将自动下载最新的20篇文章提供离线下载";
        label.font = [UIFont systemFontOfSize:12.0f];
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
    if (indexPath.section == 0 && indexPath.row == 0) {  //登录
        
//        LoginViewController *vc = [[LoginViewController alloc] init];
//        [self.navigationController pushViewController:vc
//                                             animated:YES];
        
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        if(![appDelegate.sinaweibo isLoggedIn]){
            [appDelegate.sinaweibo logIn];
            button.hidden = NO;
            [_tableView reloadData];
        }
    }else if (indexPath.section == 2 && indexPath.row == 0){ // 大字体
    }else if (indexPath.section == 2 && indexPath.row == 1){ // 清理缓存
        [self clear];
    }else if (indexPath.section == 3 && indexPath.row == 0){ // 关于我们
    }
}
//账号登出
- (void)logOutAction{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认登出么?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    
    [alert show];
}
#pragma mark - 计算缓存
- (void)count{
    NSString *homePath = NSHomeDirectory();
    NSLog(@"%@",homePath);
    // /Library/Caches/-23.GuoKe/
    // /Library/Caches/com.hackemist.SDWebImageCache.default/
    long long fileSize = 0;
    NSArray *filePathArray = @[@"/Library/Caches/-23.GuoKe/",@"/Library/Caches/com.hackemist.SDWebImageCache.default/"];
    for (NSString *filePath in filePathArray) {
        //获取缓存文件路径
        NSString *path = [homePath stringByAppendingPathComponent:filePath];
        //创建文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //获取某个路径下的所有文件名
        NSArray *fileNames = [fileManager subpathsOfDirectoryAtPath:path error:nil];
        //遍历文件夹
        for (NSString *fileName in fileNames) {
            NSString *file = [path stringByAppendingPathComponent:fileName];
            //根据文件路径，获取文件的相关信息
            NSDictionary *dic = [fileManager attributesOfItemAtPath:file error:nil];
//            NSLog(@"dic = %@",dic);
            fileSize += [dic[NSFileSize] longLongValue];
        }
    }
    _label.text = [NSString stringWithFormat:@"%.2fM",(CGFloat)fileSize/1024/1024];
}
#pragma mark - 清理缓存
- (void)clear{
    NSString *homePath = NSHomeDirectory();

    NSArray *filePathArray = @[@"/Library/Caches/-23.GuoKe/",@"/Library/Caches/com.hackemist.SDWebImageCache.default/"];
    for (NSString *filePath in filePathArray) {
        //获取缓存文件路径
        NSString *path = [homePath stringByAppendingPathComponent:filePath];
        //创建文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //获取某个路径下的所有文件名
        NSArray *fileNames = [fileManager subpathsOfDirectoryAtPath:path error:nil];
        //遍历文件夹
        for (NSString *fileName in fileNames) {
            NSString *file = [path stringByAppendingPathComponent:fileName];
            //删除文件
            [fileManager removeItemAtPath:file error:nil];
        }
    }
    _label.text = @"清理中....";
    [self performSelector:@selector(count) withObject:nil afterDelay:0.6];

}
#pragma mark - 开关动作
- (void)switchAction:(UISwitch *)switchs{
    
    if (switchs.isOn) {
        //发送通知 字体放大
        [[NSNotificationCenter defaultCenter] postNotificationName:switchStateOn object:nil];
        [mySwitch setOn:YES];
    }else if (!switchs.isOn){
        //发送通知 字体还原
        [[NSNotificationCenter defaultCenter] postNotificationName:switchStateOff object:nil];
        [mySwitch setOn:NO];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate.sinaweibo logOut];
        button.hidden = YES;
    }
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
