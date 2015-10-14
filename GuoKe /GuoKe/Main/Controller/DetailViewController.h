//
//  DetailViewController
//  GuoKe
//
//  Created by apple on 15/9/27.
//  Copyright © 2015年 dzk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "ResultModel.h"
#import "UIImageView+WebCache.h"

@interface DetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate,UITextFieldDelegate>
//resultmodel
@property (nonatomic , strong) NSArray *detaleArray;
@property (nonatomic , strong) ResultModel *model;
//记录当前为第几个单元格
@property (nonatomic , assign) NSInteger index;
//commentmodel
@property (nonatomic , strong) NSMutableArray *array;
//是否处于收藏状态
@property (nonatomic , assign) BOOL isStoreView;
//收藏 新闻 的所有 key
@property (nonatomic , strong) NSMutableArray *collectionarray;
//收藏的新闻信息
@property (nonatomic , strong) NSMutableDictionary *collectionDic;
@property (nonatomic , assign) NSInteger maxIndex;
//记录webview字体是否被改变
@property (nonatomic, assign) BOOL isChanged;

@end
