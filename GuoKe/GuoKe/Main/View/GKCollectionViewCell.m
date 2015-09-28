

#import "GKCollectionViewCell.h"
#import "UIImageView+WebCache.h"

#define kMargin 10

@implementation GKCollectionViewCell

/*
- (UIView *)view
{
    _view = [[UIView alloc] initWithFrame:self.bounds];
    

    CGFloat width = self.width;
    
    UIFont *font = [UIFont boldSystemFontOfSize:11];
    
    //    标题大小
    CGSize sizes = [_resultModel.title sizeWithFont:font constrainedToSize:CGSizeMake(width,INT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    
    CGFloat labelHeight = sizes.height + 5;
    
    CGFloat imageHeight;
    
    if (_resultModel.headline_img_tb != nil)
    {
        NSString *soure = @"\\d\\d\\d";
        NSArray *array = [_resultModel.headline_img_tb componentsMatchedByRegex:soure];
        
        if (array.count == 0)
        {
            imageHeight = width;
        }
        else
        {
            
            CGFloat with = [array[0] floatValue];
            CGFloat height = [array[1] floatValue];
            
            imageHeight = width * (height / with);
        }
        
    }
    
    NSString *urlStr = _resultModel.headline_img_tb;
    [_cellImage sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    _cellImage = [[UIImageView alloc] init];
    _cellImage.frame = CGRectMake(0, 0, width, imageHeight);
    
    _cellLabel = [[UILabel alloc] init];
    _cellLabel.text = _resultModel.title;
    _cellLabel.numberOfLines = 3;
    _cellLabel.frame = CGRectMake(0, imageHeight, width, labelHeight);
    
    _labelView = [[UIView alloc] init];
    _labelView.frame = CGRectMake(0, imageHeight + labelHeight, width, 20);
    
    _soureLabel = [[UILabel alloc] init];
    _soureImage.frame = CGRectMake(5, 5, 15, 15);
    _soureLabel.text = _resultModel.source_name;
    _soureImage.frame = CGRectMake(20, 0, 80, 20);
    
    _timeLabel = [[UILabel alloc] init];
    _timeImage.frame = CGRectMake(100, 5, 15, 15);
    _timeLabel.text = @"";
    _timeLabel.frame = CGRectMake(115, 0, width - 30 - 80, 20);
    
    
    [_view addSubview:_cellImage];
    [_view addSubview:_cellLabel];
    [_view addSubview:_labelView];
    [_view addSubview:_soureLabel];
    [_view addSubview:_timeLabel];
    [_view addSubview:_timeImage];
    [_view addSubview:_soureImage];
   
    
    return _view;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self.contentView addSubview:_view];
    }
    
    return self;
}
*/

- (void)awakeFromNib
{
        
}

- (void)setResultModel:(ResultModel *)resultModel
{
    if (_resultModel != resultModel)
    {
        _resultModel = resultModel;
        [self setNeedsLayout];
    }
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    CGFloat width = self.width;
    
    UIFont *font = [UIFont boldSystemFontOfSize:11];
    
//    标题大小
    CGSize sizes = [_resultModel.title sizeWithFont:font constrainedToSize:CGSizeMake(width,INT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    
    CGFloat labelHeight = sizes.height + 5;
    
    CGFloat imageHeight;
    
    if (_resultModel.headline_img_tb != nil)
    {
        NSString *soure = @"\\d\\d\\d";
        NSArray *array = [_resultModel.headline_img_tb componentsMatchedByRegex:soure];
        
        if (array.count < 2)
        {
            imageHeight = width;
        }
        else
        {
            CGFloat with = [array[0] floatValue];
            CGFloat height = [array[1] floatValue];
            
            imageHeight = width * (height/with);
        }
        
    }

    NSString *urlStr = _resultModel.headline_img_tb;
    [_cellImage sd_setImageWithURL:[NSURL URLWithString:urlStr]];
   
    _cellLabel.text = _resultModel.title;
    _cellLabel.numberOfLines = 3;
    _soureLabel.text = _resultModel.source_name;
    _timeLabel.text = @"";
    
    
    _cellImage.frame = CGRectMake(0, 0, width, imageHeight);
    _cellLabel.frame = CGRectMake(0, imageHeight, width, labelHeight);
    _labelView.frame = CGRectMake(0, imageHeight + labelHeight, width, 20);
    _soureImage.frame = CGRectMake(5, 5, 15, 15);
    _soureLabel.frame = CGRectMake(20, 0, 80, 20);
    _timeImage.frame = CGRectMake(100, 5, 15, 15);
    _timeLabel.frame = CGRectMake(115, 0, width - 30 - 80, 20);
    
    
    self.height = imageHeight + labelHeight + 20;
    
}






@end
