//
//  NHLiveSocketData.h
//  NegHao
//
//  Created by NegHao on 16/5/14.
//  Copyright © 2016年 NegHao.W All rights reserved.
//
//  github:https://github.com/iosDeveloper-s/sockect

//消息模型，模型属性自已定

#import <Foundation/Foundation.h>

@interface NHLiveSocketData : NSObject

@property (nonatomic ,assign) int      code;

@property (nonatomic ,strong) NSString *nickName;

@property (nonatomic ,strong) NSString *message;

@property (nonatomic ,strong) NSNumber *onlineNum;//在线人数

@property (nonatomic ,strong) NSNumber *flowerNum;//房间花朵总数

@property (nonatomic ,strong) NSNumber *flowerSend;//送花数

@property (nonatomic ,strong) NSNumber *liveOnline;//直播状态

@property (nonatomic ,strong) NSString *playM3U8;

@property (nonatomic ,strong) NSString *playRtmp;

@property (strong, nonatomic) NSString *out_roomID;

@property (strong, nonatomic) NSData   *head_img_url;

@property (strong, nonatomic) NSString *messagebody;

@property (strong, nonatomic) NSString *user_type;//用户类型

- (NHLiveSocketData *)reciveSocketData:(NSDictionary *)socketData;

@end
