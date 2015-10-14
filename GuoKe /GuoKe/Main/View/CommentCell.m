//
//  CommentCell.m
//  GuoKe
//
//  Created by mac on 15/9/29.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "CommentCell.h"
#import "UIImageView+WebCache.h"
#import "RegexKitLite.h"

@implementation CommentCell

- (void)awakeFromNib
{
    //内容
    _contentLabel = [[WXLabel alloc] init];
    _contentLabel.linespace = 5;
    _contentLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_contentLabel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCommentModel:(CommentModel *)commentModel
{
    if (_commentModel != commentModel) {
        _commentModel = commentModel;
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //昵称
    NSDictionary *name = _commentModel.author;
    _nickname.text = name[@"nickname"];
    _nickname.textColor = [UIColor grayColor];
    
    //日期
    _createDate.textColor = [UIColor grayColor];
    NSString *date = _commentModel.date_created;
    //    NSLog(@"%@",date);//\d\d\d\d-\d\d-\d\d
    NSString *regex = @"\\d+-\\d+-\\d+";
    NSArray *array = [date componentsMatchedByRegex:regex];
    //    NSLog(@"%@",array);
    _createDate.text = array[0];
    
    //楼数
    _floor.text = [NSString stringWithFormat:@"%@楼",_commentModel.floor];
    _floor.textAlignment = NSTextAlignmentCenter;
    _floor.textColor = [UIColor grayColor];
    
    //内容
//    _contentLabel = [[WXLabel alloc] init];
//    _contentLabel.linespace = 5;
//    _contentLabel.font = [UIFont systemFontOfSize:14];
//    [self.contentView addSubview:_contentLabel];
    
    CGFloat height = [WXLabel getTextHeight:14.0 width:240 text:_commentModel.content linespace:5.0];
    _contentLabel.frame = CGRectMake(_nickname.left, _nickname.bottom+5, kScreenWidth-100, height);
    _contentLabel.text = _commentModel.content;
    _contentLabel.textColor = [UIColor blackColor];
    
    //头像
    NSDictionary *dic = name[@"avatar"];
    NSString *urlStr = dic[@"large"];
    [_imageViews sd_setImageWithURL:[NSURL URLWithString:urlStr]];

}

//计算文本高度
+(CGFloat)getCommentHeight:(CommentModel *)commentModel {
    CGFloat height = [WXLabel getTextHeight:14.0 width:kScreenWidth-70 text:commentModel.content linespace:5.0];

    return height+45;
}

@end
