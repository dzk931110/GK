//
//  BaseViewController.m
//  GuoKe
//
//  Created by mac on 15/9/25.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
{
    MBProgressHUD *HUD;
}

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createNavButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
//导航栏左边按钮
- (void)createNavButton{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setImage:[UIImage imageNamed:@"5.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = buttonItem;
}
- (void)buttonAction:(UIButton *)button{
    MMDrawerController *mmDraw = self.mm_drawerController;
    button.selected = !button.selected;
    
    if (button.selected) {
        [mmDraw openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }else{
        [mmDraw closeDrawerAnimated:YES completion:nil];
    }
}



- (void)showHUD;
{
    if (HUD == nil)
    {
        HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    [HUD show:YES];
    HUD.dimBackground = YES;
    HUD.labelText = @"Loading..";

}
- (void)hideHUD;
{
     [HUD hide:YES];
}
- (void)completeHUD;
{
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = @"加载完成";
    [HUD hide:YES afterDelay:1.5];
}




@end
