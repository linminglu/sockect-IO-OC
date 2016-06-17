//
//  NHLiveSocket.m
//  NegHao
//
//  Created by NegHao on 16/5/13.
//  Copyright © 2016年 NegHao.W All rights reserved.
//
//  github:https://github.com/iosDeveloper-s/sockect

#import "NHLiveSocket.h"
#import <socket_iosDemo-Swift.h>

#define POSTURL @""
#define connectURL @"http://120.55.137.123:8084"//服务器的socket地址和端口

NSString *const emit_msg    = @"msg";   //发送消息
NSString *const emit_join   = @"join";  //加入房间
NSString *const emit_leave  = @"leave"; //离开房间
NSString *const msg_barrage = @"弹幕";   //弹幕
NSString *const msg_flower  = @"送花";   //送花

const NSInteger cmd_sysMessage   = 1001; //系统消息-加入房间
const NSInteger cmd_otherMessage = 1002; //系统消息-离开房间
const NSInteger cmd_flower       = 1003; //送花
const NSInteger cmd_barrage      = 1004; //弹幕

@interface NHLiveSocket ()
{
    SocketIOClient   *socketIO;
    SocketAckEmitter *resetAck;
    NHLiveSocketData *_socketData;
    BOOL             isReConnet;
    NSArray          *_socketArr;
}
@end

@implementation NHLiveSocket
-(id)initWithLiveID:(NSString *)liveID{
    self = [super init];
    if(self) {
        _socketData   = [[NHLiveSocketData alloc]init];
    }
    return self;
}


-(void)connectSccket{
    
    socketIO = [[SocketIOClient alloc]initWithSocketURL:[NSURL URLWithString:@""] options:@{@"transports":@"websocket"}];

    @autoreleasepool {
        [socketIO connectWithTimeoutAfter:10 withTimeoutHandler:^{
            [socketIO reconnect];
        }];
    }
    
    [socketIO onAny:^(SocketAnyEvent * event) {
        NSLog(@"event.event = %@,,%@",event.event,event.items);
        if ([event.event isEqualToString:@"connect"]) {
            if (_isCommand) {//观众
                //消息内容
                NSDictionary * varUser=  [NSDictionary dictionaryWithObjectsAndKeys:@"存放连接参数-value",@"存放连接参数-key",nil];
                _socketArr = [NSArray arrayWithObject:varUser];
                //加入房间
                [socketIO emit:emit_join withItems:_socketArr];
                
            }else{//主播
                //消息内容
                NSDictionary *_varUser = [NSDictionary dictionaryWithObjectsAndKeys:@"存放连接参数-value",@"存放连接参数-key",nil];
                _socketArr = [NSArray arrayWithObject:_varUser];
                //加入房间
                [socketIO emit:emit_join withItems:_socketArr];
            }
        }else if ([event.event isEqualToString:@"sys"]) {
            NSDictionary *socketDic = [event.items objectAtIndex:0];
            NSLog(@"socketDic:%@",socketDic);
            _liveSocket = [_socketData reciveSocketData:socketDic];
            if (self.delegate && [self.delegate respondsToSelector:@selector(receiveSocketMessage:)]) {
                [self.delegate receiveSocketMessage:_liveSocket];
            }
        }else if ([event.event isEqualToString:@"reconnectAttempt"]){
            isReConnet = YES;
        }
    }];
}


- (void)emitMessageWithText:(NSString *)text Emit:(NSString *)emit Cmd:(NSInteger)cmd Msg:(NSString *)msg{
    
    NSDictionary * var_msg =  [NSDictionary dictionaryWithObjectsAndKeys:@"存放连接参数-value",@"存放连接参数-key",nil];
    
    NSArray *var_arr = [NSArray arrayWithObject:var_msg];
    
    [socketIO emit:emit withItems:var_arr];
}

- (void)socketIoWithOn{
    
    socketIO = [[SocketIOClient alloc]initWithSocketURL:[NSURL URLWithString:@""] options:@{@"transports":@"websocket"}];

    [socketIO on:@"connect" callback:^(NSArray * array, SocketAckEmitter * emitter) {
        //消息内容
        NSDictionary *varUser = [NSDictionary dictionaryWithObjectsAndKeys:@"存放连接参数-value",@"存放连接参数-key",nil];

        _socketArr = [NSArray arrayWithObject:varUser];
        //加入房间
        [socketIO emit:@"join" withItems:_socketArr];
    }];
    
    [socketIO onAny:^(SocketAnyEvent * event) {
        NSLog(@"event.event = %@,,%@",event.event,event.items);
    }];
    
    //加入自动释放池，不然内存泄露
    @autoreleasepool {
        //重连，时间为10秒
        [socketIO connectWithTimeoutAfter:10 withTimeoutHandler:^{
            [socketIO reconnect];
        }];
    }
}

-(void)releaseSocketIO{
    [socketIO disconnect];
    socketIO = nil;
}

-(void)engineDidError:(NSString *)reason{
    NSLog(@"reason = %@",reason);
}


@end