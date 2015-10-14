//
//  MyStoreViewController.m
//  GuoKe
//
//  Created by mac on 15/9/25.
//  Copyright (c) 2015年 dzk. All rights reserved.
//
#import "MyStoreViewController.h"
#define collectionKey @"collectionKey"


@interface MyStoreViewController ()
{
    NSArray *_newsArray;
    NSMutableArray *_collectionarray;
    
    NSMutableDictionary *_collectionDic;
    
    UITableView *_tableView;
}

@end

@implementation MyStoreViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    self.view.backgroundColor = [UIColor whiteColor];
    _collectionarray = [[NSMutableArray alloc] init];
    _collectionDic = [[NSMutableDictionary alloc] init];
    
    [self reloadTbleView];
    
    [self _createtableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTbleView) name:collectCancal object:nil];
    
}

- (void)reloadTbleView
{
    NSUserDefaults *infoDefault = [NSUserDefaults standardUserDefaults];
    NSArray *cArray = [infoDefault objectForKey:collectionKey];
    for (NSString *title in cArray)
    {
        [_collectionarray addObject:title];
    }
    
    for (NSString *str in _collectionarray)
    {
        NSArray *urlArray = [infoDefault objectForKey:str];
        [_collectionDic setValue:urlArray forKey:str];
    }
    
    [_tableView reloadData];
    
}

- (void)_createtableView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.contentInset = UIEdgeInsetsMake(-40, 0, 0, 0);
    
    [self.view addSubview:_tableView];
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_collectionDic allKeys].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [_collectionDic allKeys][indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detail = [[DetailViewController alloc] init];
    detail.index = indexPath.row;
    detail.isStoreView = YES;
    
//    detail.model
    
    [self.navigationController pushViewController:detail animated:NO];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
