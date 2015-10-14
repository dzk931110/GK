//
//  AppDelegate.h
//  GuoKe
//
//  Created by mac on 15/9/24.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,SinaWeiboDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SinaWeibo *sinaweibo;


@end

