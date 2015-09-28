//
//  MyNetWorkQuery.h
//  天气预报
//
//  Created by kangkathy on 15/8/28.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyNetWorkQuery : NSObject


+ (void)requestData:(NSString *)urlString HTTPMethod:(NSString *)method  params:(NSMutableDictionary *)params completionHandle:(void(^)(id result))completionblock errorHandle:(void(^)(NSError *error))errorblock;

//使用AFNetworking框架来实现文件上传，datas是和文件有关的参数
+ (void)AFrequestData:(NSString *)urlString HTTPMethod:(NSString *)method  params:(NSMutableDictionary *)params data:(NSMutableDictionary *)datas completionHandle:(void(^)(id result))completionblock errorHandle:(void(^)(NSError *error))errorblock;

@end
