//
//  GKCollectionViewCell.h
//  GuoKe
//
//  Created by mac on 15/9/25.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultModel.h"

@interface GKCollectionViewCell : UICollectionViewCell

//@property (nonatomic , strong) UIView *view;
//
//@property (nonatomic , strong) UIImageView *cellImage;
//@property (nonatomic , strong) UILabel *cellLabel;
//@property (nonatomic , strong) UILabel *soureLabel;
//@property (nonatomic , strong) UILabel *timeLabel;
//@property (nonatomic , strong) UIView *labelView;
//@property (nonatomic , strong) UIImageView *soureImage;
//@property (nonatomic , strong) UIImageView *timeImage;

@property (nonatomic , strong) ResultModel *resultModel;

@property (weak, nonatomic) IBOutlet UIImageView *cellImage;
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;
@property (weak, nonatomic) IBOutlet UILabel *soureLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *labelView;
@property (weak, nonatomic) IBOutlet UIImageView *soureImage;
@property (weak, nonatomic) IBOutlet UIImageView *timeImage;


@end
