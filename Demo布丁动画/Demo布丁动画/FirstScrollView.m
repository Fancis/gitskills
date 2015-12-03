//
//  FirstScrollView.m
//  Demo布丁动画
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "FirstScrollView.h"
#import "UIViewController+MMDrawerController.h"

@interface FirstScrollView ()<UIScrollViewDelegate>
{
    CGSize _size;
}
@end

@implementation FirstScrollView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _size = self.frame.size;
        self.delegate = self;
        self.contentSize = CGSizeMake(_size.width * 2, _size.height);
        self.pagingEnabled = YES;
        
        UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _size.width, _size.height)];
        view1.backgroundColor = [UIColor yellowColor];
        [self addSubview:view1];
        UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(_size.width, 0, _size.width, _size.height)];
        view2.backgroundColor = [UIColor orangeColor];
        [self addSubview:view2];
        self.bounces = NO;//关闭scrollView的拖动弹性
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
