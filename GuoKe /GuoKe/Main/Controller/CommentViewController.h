//
//  CommentViewController.h
//  GuoKe
//
//  Created by mac on 15/9/29.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) NSArray *resultArray;

@property (nonatomic , assign) BOOL isStoreView;
//记录当前为第几个单元格
@property (nonatomic , assign) NSInteger index;

//收藏 新闻 的所有 key
@property (nonatomic , strong) NSMutableArray *collectionarray;
//收藏的新闻信息
@property (nonatomic , strong) NSMutableDictionary *collectionDic;

@end
