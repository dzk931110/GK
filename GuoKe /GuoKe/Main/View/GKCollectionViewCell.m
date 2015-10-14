

#import "GKCollectionViewCell.h"
#import "UIImageView+WebCache.h"

//#define kMargin 10

@implementation GKCollectionViewCell

- (void)awakeFromNib
{
    [self setNeedsLayout];
}

- (void)setCellFrame:(ResultFrame *)cellFrame
{
    if (_cellFrame != cellFrame)
    {
        _cellFrame = cellFrame;
        [self _createView];

        [self setNeedsLayout];
    }
}

- (void)_createView
{
//    设置cell 圆角
    self.layer.cornerRadius = 5;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [[UIColor grayColor] CGColor];
    
    ResultModel *model = _cellFrame.model;
    
    NSString *urlStr = model.headline_img_tb;
    [_cellImage sd_setImageWithURL:[NSURL URLWithString:urlStr]];

    _cellLabel.text = [NSString stringWithFormat:@" %@",model.title];
    _cellLabel.numberOfLines = 0;
    
    _soureLabel.text = model.source_name;
    
    _labelView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _labelView.layer.borderWidth = 0.5;
    
//    计算显示时间
    CGFloat agoTime = [model.date_picked floatValue];
    NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
    CGFloat time = (nowTime - agoTime) / 3600;
    NSString *str ;
    if (time < 1){
        str = [NSString stringWithFormat:@"%.0f分钟前",(time * 60)];
    }else{
        if (time > 24){
            str = [NSString stringWithFormat:@"%.0f天前",(time / 24)];
        }else{
            str = [NSString stringWithFormat:@"%.0f小时前",time];
        }
    }
    
    _timeLabel.text = str;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _cellImage.frame = _cellFrame.cellImageFrame;
    _cellLabel.frame = _cellFrame.cellLabelFrame;
    _labelView.frame = _cellFrame.labelViewFrame;
    _soureImage.frame = _cellFrame.soureImageFrame;
    _soureLabel.frame = _cellFrame.soureLabelFrame;
    _timeImage.frame = _cellFrame.timeImageFrame;
    _timeLabel.frame = _cellFrame.timeLabelFrame;
    
}
@end
