//
//  BaseViewController.h
//  GuoKe
//
//  Created by mac on 15/9/25.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "MBProgressHUD.h"

@interface BaseViewController : UIViewController

- (void)createNavButton;

- (void)showHUD;
- (void)hideHUD;
- (void)completeHUD;



@end
