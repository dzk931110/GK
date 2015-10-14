//
//  ResultModel.m
//  GuoKe
//
//  Created by apple on 15/9/26.
//  Copyright © 2015年 dzk. All rights reserved.
//

#import "ResultModel.h"

@implementation ResultModel

- (NSDictionary*)attributeMapDictionary{
    
    //   @"属性名": @"数据字典的key"
    NSDictionary *mapAtt = @{
                             @"title":@"title",
                             @"date_picked":@"date_picked",
                             @"headline_img":@"headline_img",
                             @"headline_img_tb":@"headline_img_tb",
                             @"page_source":@"page_source",
                             @"source_name":@"source_name",
                             @"source":@"source",
                             @"link_v2":@"link_v2",
                             @"link":@"link",
                             @"idStr":@"id"
                             };
    return mapAtt;
}


@end
