//
//  FirstViewController.m
//  Demo布丁动画
//
//  Created by apple on 15/11/26.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "FirstViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "FirstNavigationItemView.h"
#import "FirstScrollView.h"
#import "CustomSendMessage.h"
#import "Masonry.h"
@interface FirstViewController ()<UIScrollViewDelegate>
{
    NSInteger _currentIndex;
    CGSize _size;
    FirstNavigationItemView *_itemView;
    
    CustomSendMessage *_sendMessage;
    UIView *_lineView;
}
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _size = self.view.frame.size;
    FirstScrollView *scrollView = [[FirstScrollView alloc]initWithFrame:CGRectMake(0, 64, _size.width, _size.height -64)];
    [self.view addSubview:scrollView];
    
    self.view.backgroundColor = [UIColor cyanColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //leftBarButtonItem
    UIImage *defaultLogin = [UIImage imageNamed:@"leftItemDefaultLogin"];
    defaultLogin = [defaultLogin imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIButton *button_defaultLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [button_defaultLogin setImage:defaultLogin forState:UIControlStateNormal];
    [button_defaultLogin addTarget:self action:@selector(headerIconClicked) forControlEvents:UIControlEventTouchUpInside];
    button_defaultLogin.frame = CGRectMake(0, 0, 40, 40);
    button_defaultLogin.layer.masksToBounds = YES;
    button_defaultLogin.layer.cornerRadius = 20;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button_defaultLogin];
    //rightBarButtonItem
    UIImage *seekImage = [UIImage imageNamed:@"seek"];
    seekImage = [seekImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:seekImage style:UIBarButtonItemStylePlain target:nil action:nil];
    //navigationTitleItem
    _itemView = [[FirstNavigationItemView alloc]initWithFrame:CGRectMake(0, 0, 180, 45)];
    
    //点击navigationTitleItem上的button
    [_itemView whichButtonClicked:^(UIButton *button, NSInteger index) {

        if (index == 2) {
            [scrollView setContentOffset:CGPointMake(_size.width, 0) animated:YES];
        }else{
        
            [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
    }];
    self.navigationItem.titleView = _itemView;
    scrollView.delegate = self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_currentIndex == 1) {
        self.mm_drawerController.panGestureRecognizer.enabled = NO;
    }
}

- (void)headerIconClicked{
    //如果左边的页面是打开的就让它点击关闭
    if (self.mm_drawerController.openSide == MMDrawerSideLeft) {
        [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    }else{
    //如果左边的页面是关闭的就让它点击打开
        [self.mm_drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
        self.mm_drawerController.panGestureRecognizer.enabled = YES;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self configWithScrollView:scrollView];
    _itemView.whichIndex = _currentIndex;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{

    [self configWithScrollView:scrollView];
}

- (void)configWithScrollView:(UIScrollView *)scrollView{

    //如果scrollView往右边偏移滚动就把抽屉的拖动手势关闭
    if (scrollView.contentOffset.x == _size.width) {
        self.mm_drawerController.panGestureRecognizer.enabled = NO;
        scrollView.bounces = YES;//打开scrollView的拖动弹性
        _currentIndex = 2;
    }else if (scrollView.contentOffset.x == 0){
        //如果scrollView没有偏移滚动就把抽屉的拖动手势打开
        self.mm_drawerController.panGestureRecognizer.enabled = YES;
        scrollView.bounces = NO;//关闭scrollView的拖动弹性
        _currentIndex = 1;//用一个标签区别其他ViewController的抽屉开关
    }
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (_currentIndex == 1 && self.mm_drawerController.panGestureRecognizer.enabled == YES) {
        self.mm_drawerController.panGestureRecognizer.enabled = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
