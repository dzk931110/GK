//
//  HomeViewController.m
//  GuoKe
//
//  Created by mac on 15/9/25.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "HomeViewController.h"
#import "GKCollectionViewFlowLayout.h"
#import "GKCollectionViewCell.h"
#import "ApplyInternet.h"
#import "DetileViewController.h"

static CGFloat const kMargin = 10.f;

static NSString * const reuseIdentifier = @"fcell";

@interface HomeViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    ResultModel *_resultModel;
    
    GKCollectionViewCell *cell;
}


@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) GKCollectionViewFlowLayout *layout;

@end

@implementation HomeViewController

#pragma mark -
#pragma mark init methods
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:self.layout];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        
//        注册
        UINib *nib = [UINib nibWithNibName:@"GKCollectionViewCell" bundle:[NSBundle mainBundle]];
       [_collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
        
//        [_collectionView registerClass:[GKCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        
        _collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self _loadNewDatas];
        }];
        
        _collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self _loadMoreDatas];
        }];
        

        
    }
    return _collectionView;
}


- (GKCollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[GKCollectionViewFlowLayout alloc] init];
        _layout.minimumInteritemSpacing = kMargin;
        _layout.minimumLineSpacing = kMargin;
        _layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    }
    return _layout;
}

#pragma mark lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"果壳精选";
    self.dataList = [[NSMutableArray alloc] init];
    
    [self.view addSubview:self.collectionView];
    
     [self _loadDatas];
    
    
}

#pragma mark - request
- (void)_loadDatas
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];

    [params setObject:[NSString stringWithFormat:@"%.0f",time] forKey:@"since"];//3
    
    [ApplyInternet requestInternet:times_news
                        HTTPMethod:@"GET"
                            params:params
                  completionHandle:^(id result) {
                      
                      NSLog(@"请求数据成功");
                      
                      NSArray *array = [result objectForKey:@"result"];
                      
                      for (NSDictionary *d in array)
                      {
                          _resultModel = [[ResultModel alloc] initWithDataDic:d];
                          [_dataList addObject:_resultModel];
                      }
                      
//                      更新UI 在主线程中
                      dispatch_async(dispatch_get_main_queue(), ^{
                           [_collectionView reloadData];
                      });
                      
                  } errorHandle:^(NSError *error) {
                      NSLog(@"错误 : %@",error);

                  }];
    
}

//下拉刷新
- (void)_loadNewDatas
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    
    [params setObject:[NSString stringWithFormat:@"%.0f",time] forKey:@"since"];//3
    
    [ApplyInternet requestInternet:times_news
                        HTTPMethod:@"GET"
                            params:params
                  completionHandle:^(id result){
                      
                      NSLog(@"请求数据成功");
                      
                      NSArray *array = [result objectForKey:@"result"];
                      
                      for (NSDictionary *d in array)
                      {
                          _resultModel = [[ResultModel alloc] initWithDataDic:d];
                          [_dataList addObject:_resultModel];
                      }
                      
                      //                      更新UI 在主线程中
                      dispatch_async(dispatch_get_main_queue(), ^{
                          [_collectionView reloadData];
                      });
                      
                      [_collectionView.header endRefreshing];
                      
                  } errorHandle:^(NSError *error) {
                      NSLog(@"错误 : %@",error);
                      
                  }];
    
}



//上拉加载
- (void)_loadMoreDatas
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    ResultModel *model = [_dataList lastObject];
    
    NSNumber *data = model.date_picked;
    
    CGFloat agotime = [data floatValue];
    
    [params setObject:[NSString stringWithFormat:@"%.0f",agotime] forKey:@"since"];
    
    [ApplyInternet requestInternet:times_news
                        HTTPMethod:@"GET"
                            params:params
                  completionHandle:^(id result) {
                      
                      NSMutableArray *array = [result objectForKey:@"result"];

                      [array removeObjectAtIndex:0];
                      
                      for (NSDictionary *d in array)
                      {
                          _resultModel = [[ResultModel alloc] initWithDataDic:d];
                          [_dataList addObject:_resultModel];
                      }
                      
                      //                      更新UI 在主线程中
                      dispatch_async(dispatch_get_main_queue(), ^{
                          [_collectionView reloadData];
                      });
                      
                      [_collectionView.footer endRefreshing];
                      
                  } errorHandle:^(NSError *error) {
                      NSLog(@"错误 : %@",error);
                      
                  }];

}





#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    [_collectionView.collectionViewLayout invalidateLayout];
    return _dataList.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.resultModel = _dataList[indexPath.row];
    
    cell.backgroundColor = [UIColor blackColor];
    
//    cell.view.frame = cell.bounds;
    
    [cell sizeToFit];
    
    return  cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
     CGFloat width = ([UIScreen mainScreen].bounds.size.width - 2*kMargin)/2.f;

     ResultModel *model = _dataList[indexPath.row];
    
     UIFont *font = [UIFont boldSystemFontOfSize:11];
 
     CGSize sizes = [model.title sizeWithFont:font constrainedToSize:CGSizeMake(width,INT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    
     CGFloat labelHeight = sizes.height + 5;
    
    if (model.headline_img_tb != nil)
    {
        NSString *soure = @"\\d\\d\\d";
        
        NSArray *array = [model.headline_img_tb componentsMatchedByRegex:soure];
       
        if (array.count < 2)
        {
            CGSize size = CGSizeMake(width, width + labelHeight + 20);
            
            return size;
        }
        else
        {
            CGFloat with = [array[0] floatValue];
            CGFloat height = [array[1] floatValue];
            
            CGSize size = CGSizeMake(width, width*(height/with) + labelHeight + 20);
            
            return size;
        }
        
    }
    
    return CGSizeMake(width, labelHeight + 20);
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetileViewController *detaleController = [[DetileViewController alloc] init];
    
    detaleController.index = indexPath.row;

    
    detaleController.detaleArray = self.dataList;
    
    [self.navigationController pushViewController:detaleController animated:NO];
    
}


//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//}


@end
