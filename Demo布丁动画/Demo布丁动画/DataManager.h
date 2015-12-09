//
//  DataManager.h
//  Demo布丁动画
//
//  Created by apple on 15/12/9.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DataManager;

@protocol DataManagerDelegate <NSObject>

@optional
- (void)theDataManagerIsFull:(DataManager *)dataManager;
@end

@interface DataManager : NSObject

@property (nonatomic,copy)NSMutableArray *images;
@property (nonatomic,copy)NSMutableArray *names;
@property (nonatomic,copy)NSMutableArray *mutiplied;
@property (nonatomic,copy)NSMutableArray *scrollImages;

@property (nonatomic,weak)id<DataManagerDelegate> delegate;

- (void)dataManagerWithResponseObj:(id)responseObj andError:(NSError *)error;
@end
