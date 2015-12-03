//
//  CustomSendMessage.m
//  Demo布丁动画
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CustomSendMessage.h"

@implementation CustomSendMessage

+ (instancetype)sendMessage{

    static CustomSendMessage *sendMessage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
    
        sendMessage = [[[self class]alloc]init];
    });
    return sendMessage;
}


@end
