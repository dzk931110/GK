//
//  LeftViewController.h
//  GuoKe
//
//  Created by mac on 15/9/25.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_rowNameArray;
    NSArray *_rowImageArray;
}
@end
