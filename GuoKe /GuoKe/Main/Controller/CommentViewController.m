//
//  CommentViewController.m
//  GuoKe
//
//  Created by mac on 15/9/29.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentCell.h"
#import "ApplyInternet.h"
#import "CommentModel.h"
#import "ResultModel.h"

@interface CommentViewController () <UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    UILabel *_tipLabel;
    NSString *idStr;
    
}
@end

@implementation CommentViewController

static NSString *identify = @"CommentCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"评论页面";
    _data = [[NSMutableArray alloc] init];
    
    [self getComment];
    [self _createView];
}

#pragma mark - 创建视图
- (void)_createView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.contentInset = UIEdgeInsetsMake(-40, 0, 0, 0);
    _tableView.hidden = YES;
    [self.view addSubview:_tableView];
    
    //注册单元格
    UINib *nib = [UINib nibWithNibName:@"CommentCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:identify];
    
    _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 250, 200, 40)];
    _tipLabel.text = @"暂时还没评论~~~";
    _tipLabel.textColor = [UIColor colorWithWhite:0.2 alpha:0.6];
    _tipLabel.hidden = YES;
    _tipLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_tipLabel];
}

#pragma mark - tableview代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_data.count == 0) {
        _tipLabel.hidden = NO;
        return 0;
    }
    _tipLabel.hidden = YES;
    return _data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CommentCell" owner:nil options:nil] lastObject];
    }
    cell.commentModel = _data[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentModel *model = _data[indexPath.row];
    
    CGFloat height = [CommentCell getCommentHeight:model];
    
    return height;
}
#pragma mark - 获取评论
- (void)getComment
{
    if (_isStoreView)
    {
        NSArray *values = [_collectionDic allValues];
        NSArray *array = values[_index];
        idStr = array[2];
        
    }else{
        ResultModel *resultModel = _resultArray[_index];
        idStr = resultModel.idStr;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:idStr forKey:@"article_id"];
    [ApplyInternet requestInternet:commentUrl HTTPMethod:@"GET" params:params completionHandle:^(id result) {
        
        NSArray *res = [result objectForKey:@"result"];
        for (NSDictionary *dic in res) {
            CommentModel *commentModel = [[CommentModel alloc] initWithDataDic:dic];
            [_data addObject:commentModel];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
            _tableView.hidden = NO;
        });
        
    } errorHandle:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
}

//- (void)viewWillAppear:(BOOL)animated {
//    [_tableView reloadData];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
