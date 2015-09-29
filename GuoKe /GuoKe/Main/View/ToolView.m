//
//  ToolView.m
//  GuoKe
//
//  Created by mac on 15/9/29.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "ToolView.h"

@interface ToolView ()
{
    UITextField *_textField;
    UIImageView *_edit;
    UIButton *_store;
    
}

@end

@implementation ToolView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 5;
        self.layer.borderWidth = 2;
        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
        
        [self _createView];
    }
    
    return self;
}

- (void)_createView{
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 5, 300, 30)];
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.placeholder = @"      写评论";
    _textField.layer.cornerRadius = 2;
    _textField.layer.borderWidth = 1;
    _textField.layer.borderColor = [[UIColor grayColor] CGColor];
    [self addSubview:_textField];
    
    _edit = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 20, 20)];
    _edit.image = [UIImage imageNamed:@"9.png"];
    [_textField addSubview:_edit];
    
    _store = [[UIButton alloc] initWithFrame:CGRectMake(_textField.right+10, 0, 40, 40)];
    [_store setImage:[UIImage imageNamed:@"10.png"] forState:UIControlStateNormal];
    [_store setImage:[UIImage imageNamed:@"7.png"] forState:UIControlStateSelected];
    [_store addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_store];
    
}
- (void)buttonAction:(UIButton *)button{
    button.selected = !button.selected;
}
@end
