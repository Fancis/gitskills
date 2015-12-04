//
//  FirstScrollView.m
//  Demo布丁动画
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "FirstScrollView.h"
#import "UIViewController+MMDrawerController.h"
#import "CustomScrollView.h"
#import "FirstViewController.h"

@interface FirstScrollView ()<UIScrollViewDelegate>
{
    CGSize _size;
    CustomScrollView *_customScrollView;
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
        view1.tag = 3001;
        [self addSubview:view1];
        UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(_size.width, 0, _size.width, _size.height)];
        view2.backgroundColor = [UIColor orangeColor];
        [self addSubview:view2];
        self.bounces = NO;//关闭scrollView的拖动弹性

        _customScrollView = [[CustomScrollView alloc]initWithFrame:CGRectMake(0, 0, _size.width, 128)];
        _customScrollView.tag = 2001;
        [view1 addSubview:_customScrollView];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    FirstViewController *firstVC = [self findFirstViewController:self];
    UITouch *touch = [touches anyObject];
    UIView *tempView = touch.view;
    if (tempView.tag == 3001) {
        firstVC.mm_drawerController.panGestureRecognizer.enabled = YES;
    }
}

- (FirstViewController *)findFirstViewController:(UIResponder *)responder{
    
    UIResponder *tempResponder = responder;
    if ([tempResponder isKindOfClass:[FirstViewController class]]) {
        return (FirstViewController *)tempResponder;
    }else{
        
        tempResponder = tempResponder.nextResponder;
        return [self findFirstViewController:tempResponder];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
