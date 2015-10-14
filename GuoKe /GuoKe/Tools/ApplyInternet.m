//
//  ApplyInternet.m
//  请求网络方法封装
//
//  Created by apple on 15/8/28.
//  Copyright (c) 2015年 😄😄😄👌. All rights reserved.
//

#import "ApplyInternet.h"

#define BaseUrl @"http://apis.guokr.com/"

@implementation ApplyInternet

//params 参数
+ (void)requestInternet:(NSString *)urlString HTTPMethod:(NSString *)method params:(NSMutableDictionary *)params completionHandle:(void (^)(id))completionblock errorHandle:(void (^)(NSError *))errorblock;
{
//    [params setObject:@"by_since" forKey:@"retrieve_type"];//5
//    [params setObject:@"before" forKey:@"orientation"];//1
//    [params setObject:@"all" forKey:@"category"];//4
//    [params setObject:@"1" forKey:@"ad"];//2
    
//    拼接URL
    NSString *requestString = [BaseUrl stringByAppendingString:urlString];
    NSURL *url = [NSURL URLWithString:requestString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval = 60;
    request.HTTPMethod = method;
    
//    处理请求参数
    NSMutableString *paramString = [NSMutableString string];
    NSArray *allKeys = params.allKeys;
    for (int i = 0; i <allKeys.count; i++)
    {
        NSString *key = allKeys[i];
        NSString *value = params[key];
        
        [paramString appendFormat:@"%@=%@",key,value];
        if (i < params.count - 1)
        {
            [paramString appendString:@"&"];
        }
    }
    
//    get post 处理
    if ([method isEqualToString:@"GET"])
    {
//        url.query 判断url中是否有 ？
        NSString *seperate = url.query ? @"&" : @"?";
        NSString *paramsURLString = [NSString stringWithFormat:@"%@%@%@",requestString,seperate,paramString];
        
//        根据拼接好的URL进行修改 (更新URL)
        request.URL = [NSURL URLWithString:paramsURLString];
        
    }
    else if ([method isEqualToString:@"POST"])
    {
        NSData *bodyData = [paramString dataUsingEncoding:NSUTF8StringEncoding];
        request.HTTPBody = bodyData;

    }
    
    
//    发送异步网络请求
    NSOperationQueue *que = [[NSOperationQueue alloc] init];
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:que completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        if (connectionError)
        {
//            出现错误时回调 block
            errorblock(connectionError);
            
            return ;
        }
        
        if (data)
        {
            NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            completionblock(jsonDic);
        }
        
    }];
    
    
    
}


//params:普通参数 datas：和文件上传相关的参数
+(void)AFrequestData:(NSString *)urlString HTTPMethod:(NSString *)method params:(NSMutableDictionary *)params data:(NSMutableDictionary *)datas completionHandle:(void (^)(id))completionblock errorHandle:(void (^)(NSError *))errorblock {
    
    //拼接URL
    urlString = [BaseUrl stringByAppendingString:urlString];
    
    //创建管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //key->value @"pic":NSData*(二进制图片数据）
        
        for (NSString *key in datas) {
            //获取二进制文件数据
            NSData *data = datas[key];
            
            //把文件数据追加到formData的末尾
            [formData appendPartWithFileData:data name:key fileName:key mimeType:@"image/jpeg"];
        }
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        completionblock(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        errorblock(error);
    }];
    
}

@end
