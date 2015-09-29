//
//  ResultFrame.m
//  GuoKe
//
//  Created by apple on 15/9/28.
//  Copyright © 2015年 dzk. All rights reserved.
//

#import "ResultFrame.h"

@implementation ResultFrame

- (void)setModel:(ResultModel *)model
{
    if (_model != model)
    {
        _model = model;
        [self _layoutFrame];
    }
}

- (void)_layoutFrame
{
    UIFont *font = [UIFont boldSystemFontOfSize:11];
    
    //    标题大小
    CGSize sizes = [_model.title sizeWithFont:font constrainedToSize:CGSizeMake(widths,INT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    
    labelHeight = sizes.height + 5;
    
    if (_model.headline_img_tb != nil)
    {
        NSArray *array = [_model.headline_img_tb pathComponents];
        
        if (array.count>4)
        {
            if ([array[array.count-4] isEqualToString:@"w"] && array.count>4)
            {
                CGFloat with = [array[array.count-3] floatValue];
                CGFloat height = [array[array.count-1] floatValue];
                
                imageHeight = widths * (height/with);
            }
            else
            {
                imageHeight = widths;
            }
        }
        else
        {
            imageHeight = widths;
        }
    }
    
    _cellImageFrame = CGRectMake(0, 0, widths , imageHeight);
    _cellLabelFrame= CGRectMake(0, imageHeight, widths, labelHeight);
    _labelViewFrame = CGRectMake(0, imageHeight + labelHeight, widths, 20);
    _soureImageFrame = CGRectMake(5, 2, 15, 15);
    _soureLabelFrame = CGRectMake(20, 0, 80, 20);
    _timeImageFrame = CGRectMake(100, 2, 15, 15);
    _timeLabelFrame = CGRectMake(115, 0, widths - 30 - 80, 20);
        
    _heights = imageHeight+labelHeight+20;
}


@end
