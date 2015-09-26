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

static CGFloat const kMargin = 10.f;
static NSString * const reuseIdentifier = @"TLCollectionWaterFallCell";

@interface HomeViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) GKCollectionViewFlowLayout *layout;

@end

@implementation HomeViewController

#pragma mark -
#pragma mark init methods
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds
                                             collectionViewLayout:self.layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[GKCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
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
    self.dataList = [NSMutableArray array];
    
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 2*kMargin)/3.f;
    for (NSUInteger idx = 0; idx < 100; idx ++) {
        CGFloat height = 100 + (arc4random() % 100);
        NSValue *value = [NSValue valueWithCGSize:CGSizeMake(width, height)];
        [_dataList addObject:value];
    }
    
    [self.view addSubview:self.collectionView];
}

#pragma mark -
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GKCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:
                                       reuseIdentifier forIndexPath:indexPath];
    
    cell.label.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    cell.label.frame = cell.bounds;
    
    return  cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize size = [[_dataList objectAtIndex:indexPath.row] CGSizeValue];
    
    return  size;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 2*kMargin)/3.f;
    for (NSUInteger idx = 0; idx < 50; idx ++) {
        CGFloat height = 100 + (arc4random() % 100);
        NSValue *value = [NSValue valueWithCGSize:CGSizeMake(width, height)];
        [_dataList addObject:value];
    }
    
    [self.collectionView reloadData];
    
    NSLog(@"%ld",indexPath.item);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
