//
//  Tools.m
//  项目二
//
//  Created by mac on 15/9/16.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "Tools.h"
#import "RegexKitLite.h"

@implementation Tools
+ (NSDate *)dateFromString:(NSString *)dateString withFormatterStr:(NSString *)formatterStr{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatterStr];
    
    
    NSDate *date = [formatter dateFromString:dateString];
    return date;
    
}


+ (NSString *)stringFromDate:(NSDate *)date withFormmaterStr:(NSString *)formatterStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatterStr];
    NSString *dateString = [formatter stringFromDate:date];
    return  dateString;
    
    
}

+ (NSString *)weiboDateString:(NSString *)string{
    
    NSString *formatterStr = @"E MMM dd HH:mm:ss Z yyyy";
    NSDate *date = [Tools dateFromString:string withFormatterStr:formatterStr];
    
    NSString *dateString = [Tools stringFromDate:date withFormmaterStr:@"MM-dd HH:mm"];
    return dateString;
    
    
    
}


//处理文本中显示的图片
+ (NSString *)parseTextImage:(NSString *)text {
    //[哈哈]--->图片名 ----> 替换成： <image url = '图片名'>
    NSString *faceRegex = @"\\[\\w+\\]";
    NSArray *faceItem = [text componentsMatchedByRegex:faceRegex];
    
    //1>.读取emoticons.plist 表情配置文件
    NSString *configPath = [[NSBundle mainBundle] pathForResource:@"emoticons" ofType:@"plist"];
    NSArray *faceConfig = [NSArray arrayWithContentsOfFile:configPath];
    
    //2>.循环、遍历所有的查找出来的表情名：[哈哈]、[赞]、....
    for (NSString *faceName in faceItem) {
        //faceName = [哈哈]
        
        //3.定义谓词条件，到emoticons.plist中查找表情名对应的表情item
        NSString *t = [NSString stringWithFormat:@"self.chs='%@'",faceName];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:t];
        NSArray *items = [faceConfig filteredArrayUsingPredicate:predicate];
        
        if (items.count > 0) {
            //4.取得过滤出来的表情item
            NSDictionary *faceDic = items[0];
            
            //5.取得图片名
            NSString *imgName = faceDic[@"png"];
            
            //6.构造表情表情 <image url = '图片名'>
            NSString *replace = [NSString stringWithFormat:@"<image url = '%@'>",imgName];
            
            //7.替换：将[哈哈] 替换成 <image url = '90.png'>
            text = [text stringByReplacingOccurrencesOfString:faceName withString:replace];
            
        }
        
    }
    
    return text;
}

@end
