//
//  DetileViewController.m
//  GuoKe
//
//  Created by apple on 15/9/27.
//  Copyright © 2015年 dzk. All rights reserved.
//

#import "DetailViewController.h"
#import "CommentViewController.h"
#import "ApplyInternet.h"
#import "CommentModel.h"

//http://apis.guokr.com/handpick/reply.json
@interface DetailViewController ()
{
    UITableView *_tableView;
    UIImageView *_topImage;
    UIWebView *_webView;
    CGFloat _webHeight;
    
    UIButton *_commentButton;
//    NSMutableArray *_commentArray;
    UIView *_toolView;
    
    //    底部工具栏
    UITextField *_textField;
    UIImageView *_edit;
    UIButton *_store;
    UIButton *_send;
    
    BOOL _isCollection;
    
    UILabel *_collectionImage;
    
    //    防止 webView循环调用
    NSInteger _i;
    
    NSString *idStr;
    
    UIButton *_buttonView;
}

@end

@implementation DetailViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        //键盘通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self _createView];
    [self _createButtomView];
    
    _i = 0;
//    _commentArray = [[NSMutableArray alloc] init];
    _collectionarray = [[NSMutableArray alloc] init];
    _collectionDic = [[NSMutableDictionary alloc] init];
    
    //提示视图
    _collectionImage = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 40, kScreenHeight / 2 + 20, 80, 40)];
    [_collectionImage setBackgroundColor:[UIColor colorWithWhite:0 alpha:1]];
    //    NSUserDefaultsstandardUserDefaults用来记录一下永久保留的数据非常方便，不需要读写文件，而是保留到一个NSDictionary字典里，由系统保存到文件里，系统会保存到该应用下的/Library/Preferences/gongcheng.plist文件中。需要注意的是如果程序意外退出，NSUserDefaultsstandardUserDefaults数据不会被系统写入到该文件，不过可以使用［[NSUserDefaultsstandardUserDefaults] synchronize］命令直接同步到文件里，来避免数据的丢失。
    
    //       01 读取本地持久化数据
    NSUserDefaults *infoDefault = [NSUserDefaults standardUserDefaults];
    
    //    NSUserDefaults 里所有的key
    //    删除 NSUserDefaults 里所有数据
//            NSDictionary *dic = [infoDefault dictionaryRepresentation];
//            for (NSString *s in [dic allKeys])
//            {
//                [infoDefault removeObjectForKey:s];
//            }
    
    
    NSArray *cArray = [infoDefault objectForKey:collectionKey];
    
    for (NSString *title in cArray)
    {
        [_collectionarray addObject:title];
    }
    
    for (NSString *str in _collectionarray)
    {
        NSArray *url = [infoDefault objectForKey:str];
        [_collectionDic setValue:url forKey:str];
    }
    
    //获取评论
//    [self getComment];
    
    //
    _isChanged = NO;

}
#pragma mark - 创建视图
- (void)_createView{

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
    
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _topImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    
    _webView =  [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//    _webView.userInteractionEnabled = NO;
    _webView.delegate = self;
    
    [_tableView addSubview:_webView];
    
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self topaction];
    }];
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self footAction];
    }];
    
    //获取评论按钮
    _commentButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [_commentButton setTitle:@"评论" forState:UIControlStateNormal];
    [_commentButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_commentButton addTarget:self action:@selector(getComment:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *commentItem = [[UIBarButtonItem alloc] initWithCustomView:_commentButton];
    self.navigationItem.rightBarButtonItem = commentItem;
    
}
#pragma mark - 获取评论按钮
- (void)getComment:(UIButton *)button{
    CommentViewController *commentVC = [[CommentViewController alloc] init];

//    commentVC.data = _commentArray;
    commentVC.resultArray = _detaleArray;
    commentVC.index = _index;
    commentVC.collectionarray = _collectionarray;
    commentVC.collectionDic = _collectionDic;
    commentVC.isStoreView = _isStoreView;
    
    [self.navigationController pushViewController:commentVC animated:YES];

}
#pragma mark - tableView 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (!_isStoreView)
    {
        _model = _detaleArray[_index];
        
        for (NSString *title in [_collectionDic allKeys])
        {
            if ([_model.title isEqualToString:title])
            {
                _isCollection = YES;
                [_store setImage:[UIImage imageNamed:@"9.png"] forState:UIControlStateNormal];
                [_store setImage:[UIImage imageNamed:@"10.png"] forState:UIControlStateSelected];
                break ;
            }else{
                _isCollection = NO;
                [_store setImage:[UIImage imageNamed:@"10.png"] forState:UIControlStateNormal];
                [_store setImage:[UIImage imageNamed:@"9.png"] forState:UIControlStateSelected];
            }
        }
        
        NSString *urlString = _model.headline_img;
        [_topImage sd_setImageWithURL:[NSURL URLWithString:urlString]];

        if (_i == 0)
        {
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_model.link_v2]];
            [_webView loadRequest:request];
        }
        
        return 2;
        
    }
    else
    {
        _isCollection = YES;
        [_store setImage:[UIImage imageNamed:@"9.png"] forState:UIControlStateNormal];
        [_store setImage:[UIImage imageNamed:@"10.png"] forState:UIControlStateSelected];
        NSArray *values = [_collectionDic allValues];
        NSArray *array = values[_index];
        
        NSString *urlString = array[1];
        [_topImage sd_setImageWithURL:[NSURL URLWithString:urlString]];
        [_tableView.tableHeaderView addSubview:_topImage];
        
        
        if (_i == 0)
        {
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:array[0]]];
            [_webView loadRequest:request];
        }
        return 2;
    }
    

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (indexPath.row == 0)
    {
        [cell addSubview:_topImage];
    }
    else
    {
        [cell addSubview:_webView];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0)
    {
        return 150;
    }
    
    return _webHeight;

}
#pragma mark - webview代理
- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    _webHeight = [[_webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
////    CGFloat width = [[_webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollWidth"] floatValue];
//    
//    _webView.frame = CGRectMake(0, _topImage.bottom, kScreenWidth, _webHeight);
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [_tableView reloadData];
//        
//    });

    //开关通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeWebViewFont) name:switchStateOn
                                               object:nil];
    
    UIScrollView *tempView = (UIScrollView *)[_webView.subviews objectAtIndex:0];
    tempView.scrollEnabled = NO;
    
    //
    CGRect frame = _webView.frame;
    frame.size.height = 1;
    _webView.frame = frame;
    
    CGSize fittingSize = [_webView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    //    _webView.frame = frame;
    
    _webHeight = frame.size.height;
    
    _webView.frame = CGRectMake(0,0, kScreenWidth, _webHeight);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!_isChanged) {
            [_tableView reloadData];
        }else if (_isChanged){
            [_tableView reloadData];
            NSString *str =@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= 500%";
            [_webView stringByEvaluatingJavaScriptFromString:str];
        }
    });
    
    _i ++;
}

#pragma mark － 上啦下啦刷新
- (void)topaction
{
    _i = 0;
    if (_index == 0)
    {
        [_tableView.header endRefreshing];
    }
    else
    {
        _index --;
        _tableView.top = 0;
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
        
        [_tableView.header endRefreshing];
    }
}
- (void)footAction
{
    _i = 0;
    if (_index == _detaleArray.count)
    {
        [_tableView.footer endRefreshing];
    }
    else
    {
        _index ++;
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
        [_tableView.footer endRefreshing];
        //        让 tableView 滚回顶部
        [_tableView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
    
}
#pragma mark - 下啦放大
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
//#pragma mark - 获取评论
//- (void)getComment
//{
//    if (_isStoreView)
//    {
//        NSArray *values = [_collectionDic allValues];
//        NSArray *array = values[_index];
//        
//        idStr = array[2];
//    }
//    else
//    {
//        _model = _detaleArray[_index];
//        idStr = self.model.idStr;
//    }
//
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:idStr forKey:@"article_id"];
//   [ApplyInternet requestInternet:commentUrl HTTPMethod:@"GET" params:params completionHandle:^(id result) {
//       
//       NSArray *res = [result objectForKey:@"result"];
//       for (NSDictionary *dic in res) {
//           CommentModel *commentModel = [[CommentModel alloc] initWithDataDic:dic];
//           [_commentArray addObject:commentModel];
//       }
//   } errorHandle:^(NSError *error) {
//       NSLog(@"%@",error);
//   }];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 创建工具栏
- (void)_createButtomView
{
    //工具栏
    _toolView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-40, kScreenWidth, 40)];
    _toolView.layer.cornerRadius = 5;
    _toolView.layer.borderWidth = 2;
    _toolView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _toolView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    
    [self.view addSubview:_toolView];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 5, 250, 30)];
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.placeholder = @"      写评论";
    _textField.layer.cornerRadius = 2;
    _textField.layer.borderWidth = 1;
    _textField.delegate = self;
    _textField.layer.borderColor = [[UIColor grayColor] CGColor];
    [_textField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingDidBegin];
    [_toolView addSubview:_textField];
    
    _edit = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 20, 20)];
    _edit.image = [UIImage imageNamed:@"11.png"];
    [_textField addSubview:_edit];
    
    //    收藏按钮
    _store = [[UIButton alloc] initWithFrame:CGRectMake(_textField.right+5, 0, 40, 40)];
    [_store setImage:[UIImage imageNamed:@"10.png"] forState:UIControlStateNormal];
    [_store setImage:[UIImage imageNamed:@"9.png"] forState:UIControlStateSelected];
    
    [_store addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_toolView addSubview:_store];
    
    //发送按钮
    _send = [[UIButton alloc] initWithFrame:CGRectMake(_textField.right+5, 0, 40, 40)];
    [_send setTitle:@"发送" forState:UIControlStateNormal];
    [_send setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_send addTarget:self action:@selector(sendButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _send.hidden = YES;
     [_toolView addSubview:_send];
    
}
//点击textfield
- (void)textFieldDidChange{
    [_textField becomeFirstResponder];
}
#pragma mark - textfield 代理
//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    [_textField becomeFirstResponder];
//    
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [_textField resignFirstResponder];
    _toolView.bottom = kScreenHeight;
    
    return YES;
}
#pragma mark -计算键盘高度
- (void)keyBoardWillShow:(NSNotification *)notification{
    NSLog(@"%@",notification);
    NSValue *bounsValue = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect frame = [bounsValue CGRectValue];
    //2 键盘高度
    CGFloat height = frame.size.height;
    
    _toolView.bottom = kScreenHeight - height;
    NSLog(@"height = %f",height);
    
    _edit.hidden = YES;
    _store.hidden = YES;
    _send.hidden = NO;
    
}

#pragma mark - 发表评论
- (void)sendButtonAction:(UIButton *)button{

    if (_isStoreView)
    {
        NSArray *values = [_collectionDic allValues];
        NSArray *array = values[_index];
        idStr = array[2];
    }
    else
    {
        _model = _detaleArray[_index];
        idStr = self.model.idStr;
    }

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:_textField.text forKey:@"content"];
    [params setObject:GKtoken forKey:@"access_token"];
    [params setObject:idStr forKey:@"article_id"];
    
    [ApplyInternet requestInternet:commentUrl HTTPMethod:@"POST" params:params completionHandle:^(id result) {
        NSLog(@"发表成功");
        NSLog(@"result = %@",result);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _textField.text = @"";
            [_textField resignFirstResponder];
            _toolView.bottom = kScreenHeight;
        });
    } errorHandle:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
#pragma mark - 收藏
- (void)buttonAction:(UIButton *)button
{
    button.selected = !button.selected;
    
    if (_isCollection)
    {
        //        将本地数据删除
        if (!_isStoreView)
        {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:_model.title];
            //            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [_collectionarray removeObject:_model.title];
            
            [[NSUserDefaults standardUserDefaults] setObject:_collectionDic forKey:collectionKey];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            _isCollection = NO;
            
        }else{
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:_collectionarray[_index]];
            //            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [_collectionarray removeObject:_collectionarray[_index]];
            
            [[NSUserDefaults standardUserDefaults] setObject:_collectionDic forKey:collectionKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
            _isCollection = NO;
            
            //            发出通知
            [[NSNotificationCenter defaultCenter] postNotificationName:collectCancal object:nil];
            
        }
        
        _collectionImage.text = @"取消收藏";
        _collectionImage.textAlignment = NSTextAlignmentCenter;
        _collectionImage.textColor = [UIColor whiteColor];
        [self.view addSubview:_collectionImage];
        _collectionImage.hidden = NO;
        [self performSelector:@selector(hidden) withObject:nil afterDelay:1.0];
        
    }else{
        NSArray *array = @[_model.link_v2,_model.headline_img,_model.idStr];
        
        [[NSUserDefaults standardUserDefaults] setObject:array forKey:_model.title];
        //        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [_collectionarray addObject:_model.title];
        
        //        储存收藏 新闻 的 key
        [[NSUserDefaults standardUserDefaults] setObject:_collectionarray forKey:collectionKey];
        
        //        手动 将数据存储到本地
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        _isCollection = YES;
        
        _collectionImage.text = @"收藏成功";
        _collectionImage.textAlignment = NSTextAlignmentCenter;
        _collectionImage.textColor = [UIColor whiteColor];
        [self.view addSubview:_collectionImage];
        _collectionImage.hidden = NO;
        [self performSelector:@selector(hidden) withObject:nil afterDelay:1.0];
    }
}

#pragma mark - 隐藏alterView
- (void)hidden
{
    _collectionImage.hidden = YES;
}

#pragma mark - 调整webview的字体大小

- (void)changeWebViewFont{
    _isChanged = YES;
    NSLog(@"--------1");
    NSString *str =@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= 500%";
    [_webView stringByEvaluatingJavaScriptFromString:str];
//    [_tableView reloadData];
}
@end
