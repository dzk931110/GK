//
//  ApplyInternet.h
//  请求网络方法封装
//
//  Created by apple on 15/8/28.
//  Copyright (c) 2015年 😄😄😄👌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface ApplyInternet : NSObject


+ (void)requestInternet:(NSString *)urlString HTTPMethod:(NSString *)method params:(NSMutableDictionary *)params completionHandle:(void(^)(id result))completionblock errorHandle:(void(^)(NSError *error))errorblock;

//带图片的微博发送
//params:普通参数 datas：和文件上传相关的参数 
+(void)AFrequestData:(NSString *)urlString HTTPMethod:(NSString *)method params:(NSMutableDictionary *)params data:(NSMutableDictionary *)datas completionHandle:(void (^)(id))completionblock errorHandle:(void (^)(NSError *))errorblock;
@end
