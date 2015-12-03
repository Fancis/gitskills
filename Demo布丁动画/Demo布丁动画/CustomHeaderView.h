//
//  CustomHeaderView.h
//  Demo布丁动画
//
//  Created by apple on 15/11/26.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomHeaderView : UIView
@property (nonatomic,strong)UIImage *headimage;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *follow;
@property (nonatomic,copy)NSString *fans;

@property (nonatomic,assign)BOOL isLoagin;
- (void)whichButtonClicked:(void(^)(UIButton *button,NSInteger index))blc;
@end
