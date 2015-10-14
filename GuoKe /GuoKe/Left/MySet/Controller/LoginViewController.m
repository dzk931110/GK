//
//  LoginViewController.m
//  GuoKe
//
//  Created by mac on 15/10/3.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "LoginViewController.h"
#import "SinaWeibo.h"
#import "AppDelegate.h"

@interface LoginViewController ()<UIAlertViewDelegate>
{

}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithWhite:.9 alpha:1];
    self.title = @"登录";
    
    [self _createView];
}
- (void)_createView{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-100, 80, 200, 20)];
    label.text = @"您可以用以下几种方式登录";
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor colorWithWhite:0.6 alpha:1];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    NSArray *imageArray = @[@"01.png",@"02.png",@"03.png"];
    NSArray *nameArray = @[@"qq登录",@"新浪微博登录",@"豆瓣登录"];
    
    for (int index = 0;index < imageArray.count; index ++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(label.left-80, (label.bottom+20)+index*90, kScreenWidth-2*(label.left-80), 80)];
        [button setImage:[UIImage imageNamed:imageArray[index]] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button setTitle:nameArray[index] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag = 100 + index;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
        [self.view addSubview:button];
    }
}

- (void)buttonAction:(UIButton *)button{
    if (button.tag == 100) {
        
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"暂不实现" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"取消", nil];
        [alterView show];
    }else if (button.tag == 101){
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        if ([appDelegate.sinaweibo isLoggedIn]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认登出么?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
            
            [alert show];
        }else{
            [appDelegate.sinaweibo logIn];
            
        }

    }else if (button.tag == 102){
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"暂不实现" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"取消", nil];
        [alterView show];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate.sinaweibo logOut];

    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    UIButton *button = (UIButton *)[self.view viewWithTag:101];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 50, 0, 0)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 70, 0, 0)];
    
    UIButton *button1 = (UIButton *)[self.view viewWithTag:102];
    [button1 setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [button1 setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
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
