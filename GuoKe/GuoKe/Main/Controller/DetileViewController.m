//
//  DetileViewController.m
//  GuoKe
//
//  Created by apple on 15/9/27.
//  Copyright © 2015年 dzk. All rights reserved.
//

#import "DetileViewController.h"

@interface DetileViewController ()
{
    UITableView *_tableView;
    
    UIImageView *_TopImage;
    
    UIWebView *_webView;
    
    NSInteger _webHeight;
}

@end

@implementation DetileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self _createNavView];
    [self _createTableView];
}

- (void)_createNavView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    editButton.frame = CGRectMake(0, 0, 100 / 3, 30);
    [editButton setBackgroundImage:[UIImage imageNamed:@"5.png"] forState:UIControlStateNormal];
    
    UIButton *collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    collectionButton.frame = CGRectMake(100 / 3, 0,100 / 3, 30);
    [collectionButton setBackgroundImage:[UIImage imageNamed:@"2.png"] forState:UIControlStateNormal];
    [collectionButton setBackgroundImage:[UIImage imageNamed:@"6.png"] forState:UIControlStateSelected];
    
    UIButton *messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    messageButton.frame = CGRectMake(100 / 3 * 2, 0, 100 / 3, 30);
    [messageButton setBackgroundImage:[UIImage imageNamed:@"4.png"] forState:UIControlStateNormal];
    
    [view addSubview:editButton];
    [view addSubview:collectionButton];
    [view addSubview:messageButton];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}


- (void)_createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    
//    _tableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    
//    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 150)];
    
//    _TopImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 150)];
//    
//    _model = _detaleArray[_index];
//    NSString *urlStr = _model.headline_img;
//    
//   [_TopImage sd_setImageWithURL:[NSURL URLWithString:urlStr]];
//    
//    [_tableView.tableHeaderView addSubview:_TopImage];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
 
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self topaction];
    }];
    
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self footAction];
    }];
    
}

- (void)topaction
{
    if (_index == 0)
    {

    }
    else
    {
        _index --;
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
        [_tableView.header endRefreshing];
    }
}


- (void)footAction
{
    if (_index == _detaleArray.count)
    {
        
    }
    else
    {
        _index ++;
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
        [_tableView.footer endRefreshing];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    _webHeight = [[_webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] integerValue];

    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
        _model = _detaleArray[_index];
        _webView = [[UIWebView alloc] init];
    
        NSURLRequest *requst = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_model.link_v2]];
        [_webView loadRequest:requst];
    
//        _webView.height = 
    
        [cell addSubview:_webView];
        
        return cell;
 
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    _TopImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 150)];
    
    _model = _detaleArray[_index];
    NSString *urlStr = _model.headline_img;
    
    [_TopImage sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    
//    
//    [_tableView.tableHeaderView addSubview:_TopImage];
//    
//    _tableView.dataSource = self;
//    _tableView.delegate = self;
    
//    [self.view addSubview:_tableView];
    
    return _TopImage;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 150;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
//    NSInteger height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] integerValue];
    
        return _webView.height;
    
 
//     CGFloat webViewHeight = [[self.webCell.webView stringByEvaluatingJavaScriptFromString: @"document.body.scrollHeight"] intValue];
//     return webViewHeight;
 
//    }
 
    
}


//下啦头视图放大
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yoffSet = scrollView.contentOffset.y;
    
    
    if (yoffSet < 0)
    {
        CGFloat scale = (150 - yoffSet) / 150;
        
        CGAffineTransform transform = CGAffineTransformMakeScale(scale, scale);
        _TopImage.transform = transform;
        
        
        _TopImage.center = CGPointMake(self.view.width / 2, 0);
        
        _TopImage.top = yoffSet;
        
    }
    else
    {
        _TopImage.transform = CGAffineTransformIdentity;
    }

}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
