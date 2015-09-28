//
//  MyNetWorkQuery.m
//  天气预报
//
//  Created by kangkathy on 15/8/28.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "MyNetWorkQuery.h"
#import "AFNetworking.h"

#define BaseURL @"http://mobile.ximalaya.com"



@implementation MyNetWorkQuery

+ (void)requestData:(NSString *)urlString HTTPMethod:(NSString *)method params:(NSMutableDictionary *)params completionHandle:(void (^)(id))completionblock errorHandle:(void (^)(NSError *))errorblock{
    
    //1.拼接URL
    NSString *requestString = [BaseURL stringByAppendingString:urlString];
    NSURL *url = [NSURL URLWithString:requestString];
    
    
    //2.创建网络请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval = 60;
    request.HTTPMethod = method;
    
    
    //3.处理请求参数
    //key1=value1&key2=value2
    NSMutableString *paramString = [NSMutableString string];
    
    NSArray *allKeys = params.allKeys;
    
    for (NSInteger i = 0; i < params.count; i++) {
        NSString *key = allKeys[i];
        NSString *value = params[key];
        
        [paramString appendFormat:@"%@=%@",key,value];
        
        if (i < params.count - 1) {
            [paramString appendString:@"&"];
        }
        
    }
    
    //4.GET和POST分别处理
    if ([method isEqualToString:@"GET"]) {
        
        //http://www.baidu.com?key1=value1&key2=value2
        //http://www.baidu.com?key0=value0&key1=value1&key2=value2
        
        NSString *seperate = url.query ? @"&" : @"?";
        NSString *paramsURLString = [NSString stringWithFormat:@"%@%@%@",requestString,seperate,paramString];
        
        //根据拼接好的URL进行修改
        request.URL = [NSURL URLWithString:paramsURLString];
        
        
    }
    else if([method isEqualToString:@"POST"]) {
        
    }
    
    
    //5.发送异步网络请求
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            //出现错误时回调block
            errorblock(connectionError);
            
            return;
        }
        
        if (data) {
            
            //解析JSON
            NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            //把JSON解析后的数据返回给调用者,回调block
            completionblock(jsonDic);
            
        }
        
        
        
        
    }];
    
    
    
    
    
    
    
}

//params:普通参数 datas：和文件上传相关的参数 
+(void)AFrequestData:(NSString *)urlString HTTPMethod:(NSString *)method params:(NSMutableDictionary *)params data:(NSMutableDictionary *)datas completionHandle:(void (^)(id))completionblock errorHandle:(void (^)(NSError *))errorblock {
    
    //拼接URL
    urlString = [BaseURL stringByAppendingString:urlString];
    
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
