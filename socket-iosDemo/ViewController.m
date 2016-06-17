//
//  ViewController.m
//  socket-iosDemo
//
//  Created by simope on 16/6/17.
//  Copyright © 2016年 NegHao.W. All rights reserved.

//  github:https://github.com/iosDeveloper-s/sockect

#import "ViewController.h"
#import "NHLiveSocket.h"
@interface ViewController ()<NHLiveSocketDelegate>
@property (nonatomic, strong) NHLiveSocket *socket;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _socket = [[NHLiveSocket alloc] initWithLiveID:@""];
    _socket.isCommand    = NO;
    _socket.delegate     = self;
}

-(void)receiveSocketMessage:(NHLiveSocketData *)scoketData{

}

-(void)dealloc{
    [_socket releaseSocketIO];
    _socket = nil;
}

@end
