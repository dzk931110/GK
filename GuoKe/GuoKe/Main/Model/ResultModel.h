//
//  ResultModel.h
//  GuoKe
//
//  Created by apple on 15/9/26.
//  Copyright © 2015年 dzk. All rights reserved.
//

#import "BaseModel.h"
#import "RegexKitLite.h"



@interface ResultModel : BaseModel

@property (nonatomic , copy) NSString *title;
@property (nonatomic , retain) NSNumber *date_picked;//获取日期
@property (nonatomic , retain) NSNumber *date_created;//创建日期
@property (nonatomic , copy) NSString *headline_img;
@property (nonatomic , copy) NSString *headline_img_tb;
@property (nonatomic , copy) NSString *page_source;
@property (nonatomic , copy) NSString *source_name;
@property (nonatomic , copy) NSString *source;
@property (nonatomic , copy) NSString *link_v2;




//@property (nonatomic , strong) NSMutableArray *widthArray;
//@property (nonatomic , strong) NSMutableArray *heightArray;




@end
