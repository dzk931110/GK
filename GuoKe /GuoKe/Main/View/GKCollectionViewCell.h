//
//  GKCollectionViewCell.h
//  GuoKe
//
//  Created by mac on 15/9/25.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultFrame.h"

@interface GKCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cellImage;
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;
@property (weak, nonatomic) IBOutlet UILabel *soureLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *labelView;
@property (weak, nonatomic) IBOutlet UIImageView *soureImage;
@property (weak, nonatomic) IBOutlet UIImageView *timeImage;

@property (nonatomic , assign) CGFloat heights;

@property (nonatomic , strong) ResultFrame *cellFrame;


@end
