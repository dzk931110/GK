//
//  DetileViewController.h
//  GuoKe
//
//  Created by apple on 15/9/27.
//  Copyright © 2015年 dzk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "ResultModel.h"
#import "UIImageView+WebCache.h"

@interface DetileViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic , strong) NSArray *detaleArray;

@property (nonatomic , strong) ResultModel *model;

@property (nonatomic , assign) NSInteger index;

@end
