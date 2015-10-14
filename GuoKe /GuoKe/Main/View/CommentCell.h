//
//  CommentCell.h
//  GuoKe
//
//  Created by mac on 15/9/29.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
#import "WXLabel.h"

@interface CommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageViews;
@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UILabel *createDate;
@property (weak, nonatomic) IBOutlet UILabel *floor;


@property (nonatomic, strong) WXLabel *contentLabel;

@property (nonatomic, strong) CommentModel *commentModel;

+ (CGFloat)getCommentHeight:(CommentModel *)commentModel;

@end
