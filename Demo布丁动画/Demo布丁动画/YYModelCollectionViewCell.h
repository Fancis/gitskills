//
//  YYModelCollectionViewCell.h
//  Demo布丁动画
//
//  Created by apple on 15/12/8.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModelCollectionVIewCellImage.h"
#import "YYModel.h"
@interface YYModelCollectionViewCell : NSObject

@property (nonatomic,copy)NSString *name;
@property (nonatomic,strong)YYModelCollectionVIewCellImage *image;
@end
