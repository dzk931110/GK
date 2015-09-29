//
//  MyCommentViewController.m
//  GuoKe
//
//  Created by mac on 15/9/25.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "MyCommentViewController.h"

@interface MyCommentViewController ()
{
    UILabel *_emailLabel;
    UITextView *_textView1;
    
    UILabel *_adviceLabel;
    UITextView *_textView2;
}
@end

@implementation MyCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"请吐槽";
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    [self _createView];
}
- (void)_createView{
    _emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 64+5, 100, 30)];
    _emailLabel.text = @"联系邮箱";
    _emailLabel.textColor = [UIColor blackColor];
    
    _textView1 = [[UITextView alloc] initWithFrame:CGRectMake(40, _emailLabel.bottom+5, 300, 50)];
    _textView1.backgroundColor = [UIColor whiteColor];
    
    _adviceLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, _textView1.bottom+5, 100, 30)];
    _adviceLabel.text = @"您的建议";
    _adviceLabel.textColor = [UIColor blackColor];
    
    _textView2 = [[UITextView alloc] initWithFrame:CGRectMake(40, _adviceLabel.bottom+5, 300, 250)];
    _textView2.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_emailLabel];
    [self.view addSubview:_adviceLabel];
    [self.view addSubview:_textView1];
    [self.view addSubview:_textView2];
    
    //提交按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submitAction:)];
}

//提交按钮
- (void)submitAction:(UIButton *)button{
    if (_textView1.text.length == 0) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"请填写邮箱" message:@"咦？要填写邮箱哦～" delegate:self cancelButtonTitle:@"好吧" otherButtonTitles:nil, nil];
        [alterView show];
    }else if (_textView2.text.length == 0){
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"请填写意见" message:@"欢迎填写意见" delegate:self cancelButtonTitle:@"好吧" otherButtonTitles:nil, nil];
        [alterView show];
    }
    [_textView1 resignFirstResponder];
    [_textView2 resignFirstResponder];
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
