//
//  ResultFrame.h
//  GuoKe
//
//  Created by apple on 15/9/28.
//  Copyright © 2015年 dzk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResultModel.h"

#define kMargin 10.f

#define widths ([UIScreen mainScreen].bounds.size.width - 2*kMargin)/2.


@interface ResultFrame : NSObject
{
    CGFloat imageHeight;
    
    CGFloat labelHeight;
}

@property (nonatomic , assign) CGRect cellImageFrame;
@property (nonatomic , assign) CGRect cellLabelFrame;
@property (nonatomic , assign) CGRect labelViewFrame;
@property (nonatomic , assign) CGRect soureLabelFrame;
@property (nonatomic , assign) CGRect timeLabelFrame;
@property (nonatomic , assign) CGRect soureImageFrame;
@property (nonatomic , assign) CGRect timeImageFrame;


@property (nonatomic , assign) CGFloat heights;

@property (nonatomic , strong) ResultModel *model;




@end
