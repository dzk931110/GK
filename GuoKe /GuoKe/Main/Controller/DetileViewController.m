//
//  DetileViewController.m
//  GuoKe
//
//  Created by apple on 15/9/27.
//  Copyright © 2015年 dzk. All rights reserved.
//

#import "DetileViewController.h"
#import "ToolView.h"
@interface DetileViewController ()
{
    UITableView *_tableView;
    UIImageView *_topImage;
    UIWebView *_webView;
    CGFloat _webHeight;
    
    UIView *_toolView;
}

@end

@implementation DetileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     _model = _detaleArray[_index];
    self.view.backgroundColor = [UIColor whiteColor];
    [self _createView];
}
- (void)_createView{

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
 //   _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    _topImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    NSString *urlString = _model.headline_img_tb;
    [_topImage sd_setImageWithURL:[NSURL URLWithString:urlString]];
    [_tableView.tableHeaderView addSubview:_topImage];
    
    _webView =  [[UIWebView alloc] initWithFrame:CGRectMake(0, _topImage.bottom, kScreenWidth, kScreenHeight)];
//    _webView.userInteractionEnabled = NO;
    _webView.delegate = self;

    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_model.link_v2]];
    [_webView loadRequest:request];
    [_tableView addSubview:_webView];
    
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self topaction];
    }];
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self footAction];
    }];
    
    //工具栏
    ToolView *toolView = [[ToolView alloc] initWithFrame:CGRectMake(0, kScreenHeight-40, kScreenWidth, 40)];
    [self.view addSubview:toolView];
}
#pragma mark - tableView 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _webHeight;
}
#pragma mark - webview代理
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    _webHeight = [[_webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    _webView.frame = CGRectMake(0, _topImage.bottom, kScreenWidth, _webHeight);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_tableView reloadData];
    });
}
#pragma mark － 刷新
- (void)topaction
{
    if (_index == 0){

    }else{
        _index --;
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
        [_tableView.header endRefreshing];
    }
}
- (void)footAction
{
    if (_index == _detaleArray.count){
        
    }else{
        _index ++;
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
        [_tableView.footer endRefreshing];
    }
}

//下啦头视图放大
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yoffSet = scrollView.contentOffset.y;
    
    if (yoffSet < 0){
        CGFloat scale = (_topImage.height - yoffSet) / _topImage.height;
        
        CGAffineTransform transform = CGAffineTransformMakeScale(scale, scale);
        _topImage.transform = transform;
        _topImage.center = CGPointMake(self.view.width / 2, 0);
        
        _topImage.top = yoffSet;
    }else{
        _topImage.transform = CGAffineTransformIdentity;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
