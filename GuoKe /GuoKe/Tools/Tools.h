//
//  Tools.h
//  项目二
//
//  Created by mac on 15/9/16.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools : NSObject

//通用 string 转date
+ (NSDate *)dateFromString:(NSString *)dateString withFormatterStr:(NSString *)formatterStr;

//通用 date 转 string
+ (NSString *)stringFromDate:(NSDate *)date withFormmaterStr:(NSString *)formatterStr;

//专用于微博项目 把 Fri Aug 28 00:00:00 +0800 2009 转换成 月-日 时:分格式
+ (NSString *)weiboDateString:(NSString *)string;

//处理文字中的表情
+ (NSString *)parseTextImage:(NSString *)text ;


@end
