//
//  NHLiveSocket.m
//  NegHao
//
//  Created by NegHao on 16/5/13.
//  Copyright © 2016年 NegHao.W All rights reserved.
//
//  github:https://github.com/iosDeveloper-s/sockect

#import <Foundation/Foundation.h>
#import "NHLiveSocketData.h"
#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const emit_msg;    //发送消息
UIKIT_EXTERN NSString *const emit_join;   //加入房间
UIKIT_EXTERN NSString *const emit_leave;  //离开房间
UIKIT_EXTERN NSString *const msg_barrage; //弹幕
UIKIT_EXTERN NSString *const msg_flower;  //送花

UIKIT_EXTERN const NSInteger cmd_sysMessage;    //系统消息-加入房间
UIKIT_EXTERN const NSInteger cmd_leaceMessage;  //系统消息-离开房间
UIKIT_EXTERN const NSInteger cmd_sendFlower;    //送花
UIKIT_EXTERN const NSInteger cmd_barrage;       //弹幕

@protocol NHLiveSocketDelegate <NSObject>

//接收到消息的方法
- (void)receiveSocketMessage:(NHLiveSocketData *)scoketData;

@end

@interface NHLiveSocket : NSObject

@property (nonatomic ,assign) id<NHLiveSocketDelegate> delegate;

@property (nonatomic ,strong) NHLiveSocketData *liveSocket;

@property (nonatomic ,assign) BOOL     isCommand;

@property (nonatomic, strong) NSString *liveCoverUrl;

//创建连接，具体通过什么属性来创建，由后台指定，这里是liveID
- (id)initWithLiveID:(NSString *)liveID;

//销毁
- (void)releaseSocketIO;

//发消息
- (void)emitMessageWithText:(NSString *)text Emit:(NSString *)emit Cmd:(NSInteger)cmd Msg:(NSString *)msg;

@end
