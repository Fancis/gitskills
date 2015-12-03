//
//  CircleView.m
//  Demo布丁动画
//
//  Created by apple on 15/11/27.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(5, 5, rect.size.width - 10, rect.size.height - 10)];
    [[UIColor colorWithWhite:1 alpha:0.5]setStroke];
    bezierPath.lineWidth = 2;
    [bezierPath stroke];
    
}


@end
