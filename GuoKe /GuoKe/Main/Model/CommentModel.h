//
//  CommentModel.h
//  GuoKe
//
//  Created by mac on 15/9/29.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

//"result": [{
//    "floor": 1,
//    "author": {
//        "ukey": "4s7h4j",
//        "is_title_authorized": false,
//        "nickname": "SN\u4e0d\u8bc6\u5b57",
//        "amended_reliability": "0",
//        "is_exists": true,
//        "title": "",
//        "url": "http://www.guokr.com/i/0289242739/",
//        "gender": null,
//        "followers_count": 0,
//        "avatar": {
//            "large": "http://3.im.guokr.com/z2xgXEcEbtQoBbeobWoGZcTJFr2naCOQVCv2dmbCSLegAAAAoAAAAEpQ.jpg?imageView2/1/w/160/h/160",
//            "small": "http://3.im.guokr.com/z2xgXEcEbtQoBbeobWoGZcTJFr2naCOQVCv2dmbCSLegAAAAoAAAAEpQ.jpg?imageView2/1/w/24/h/24",
//            "normal": "http://3.im.guokr.com/z2xgXEcEbtQoBbeobWoGZcTJFr2naCOQVCv2dmbCSLegAAAAoAAAAEpQ.jpg?imageView2/1/w/48/h/48"
//        },
//        "resource_url": "http://apis.guokr.com/community/user/4s7h4j.json"
//    },
//    "content": "\u5a31\u4e50\u81f3\u6b7b",
//    "pick_id": 16179,
//    "date_created": "2015-09-24T08:35:49.469024+08:00",
//    "id": 16648
//}],

#import "BaseModel.h"

@interface CommentModel : BaseModel

@property (nonatomic, assign) NSNumber *floor;    //楼数
@property (nonatomic, copy) NSString *content;  //文本内容
@property (nonatomic, copy) NSString *pick_id;   
@property (nonatomic, copy) NSString *date_created;
@property (nonatomic, copy) NSDictionary *author;



@end
