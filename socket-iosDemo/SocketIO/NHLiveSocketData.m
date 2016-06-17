//
//  NHLiveSocketData.h
//  NegHao
//
//  Created by NegHao on 16/5/14.
//  Copyright © 2016年 NegHao.W All rights reserved.
//
//  github:https://github.com/iosDeveloper-s/sockect

#import "NHLiveSocketData.h"

@class NHLiveSocketData;

@interface NHLiveSocketData()
{
    NHLiveSocketData *socketIO;
}
@end

@implementation NHLiveSocketData

-(id)init{
    
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NHLiveSocketData *)reciveSocketData:(NSDictionary *)socketData{
    
    socketIO = [[NHLiveSocketData alloc]init];
    socketIO.code = [[socketData objectForKey:@"cmd"]intValue];
    socketIO.nickName = [socketData objectForKey:@"nickname"];
    socketIO.message = [socketData objectForKey:@"msg"];
    socketIO.user_type = [NSString stringWithFormat:@"%@",[socketData objectForKey:@"user_type"] ];
    NSDictionary *dataDic = [socketData objectForKey:@"data"];
    if (socketIO.code == 1004) {
        socketIO.messagebody = [dataDic objectForKey:@"msgbody"];
    }else{
        socketIO.onlineNum = [dataDic objectForKey:@"room_online_users"];
        socketIO.flowerNum = [dataDic objectForKey:@"room_reviced_flowers"];
        socketIO.flowerSend = [dataDic objectForKey:@"flowers_to_send"];
        socketIO.liveOnline = [dataDic objectForKey:@"is_live_online"];
        socketIO.playM3U8 = [dataDic objectForKey:@"play_url_m3u8"];
        socketIO.playRtmp = [dataDic objectForKey:@"play_url_rtmp"];
    }
    return socketIO;
}

@end
