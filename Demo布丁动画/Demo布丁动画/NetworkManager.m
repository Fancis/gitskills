//
//  NetworkManager.m
//  Demo布丁动画
//
//  Created by apple on 15/12/8.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "NetworkManager.h"
#import "AFNetworking.h"

@implementation NetworkManager
- (void)netWorkManagerWithURL:(NSString *)urlString andPara:(NSDictionary *)pare{

    _url = [NSURL URLWithString:urlString];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plian", nil];
    
    manager.requestSerializer.timeoutInterval = 10;
    [manager GET:urlString parameters:pare success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if ([self.delegate respondsToSelector:@selector(theResponseResultWith:andResponseObj:andError:)]) {
            [self.delegate theResponseResultWith:self andResponseObj:responseObject andError:nil];
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if ([self.delegate respondsToSelector:@selector(theResponseResultWith:andResponseObj:andError:)]) {
            [self.delegate theResponseResultWith:self andResponseObj:nil andError:error];
        }
    }];
    
}

@end
