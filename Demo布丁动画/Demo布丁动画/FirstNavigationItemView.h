//
//  FirstNavigationItemButton.h
//  Demo布丁动画
//
//  Created by apple on 15/11/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstNavigationItemView : UIView

@property (nonatomic,assign)NSInteger whichIndex;

- (void)whichButtonClicked:(void(^)(UIButton *button,NSInteger index))blc;

@end
