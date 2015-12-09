//
//  NetworkManager.h
//  Demo布丁动画
//
//  Created by apple on 15/12/8.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NetworkManager;

@protocol NetWorkManagerDelegate <NSObject>

@optional
- (void)theResponseResultWith:(NetworkManager *)manager andResponseObj:(id)responseObj andError:(NSError *)error;

@end

@interface NetworkManager : NSObject

@property (nonatomic,strong,readonly)NSURL *url;
@property (nonatomic,weak)id<NetWorkManagerDelegate> delegate;

- (void)netWorkManagerWithURL:(NSString *)urlString andPara:(NSDictionary *)pare;

@end
