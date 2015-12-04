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
#import "CustomScrollView.h"

#import "Masonry.h"
@interface FirstViewController ()<UIScrollViewDelegate>
{
    NSInteger _currentIndex;
    CGSize _size;
    FirstNavigationItemView *_itemView;
    UIView *_lineView;
    CustomScrollView *customScrollView;
}
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _size = self.view.frame.size;
    FirstScrollView *firstScrollView = [[FirstScrollView alloc]initWithFrame:CGRectMake(0, 64, _size.width, _size.height -64)];
    [self.view addSubview:firstScrollView];
    firstScrollView.tag = 2002;
    
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
            [firstScrollView setContentOffset:CGPointMake(_size.width, 0) animated:YES];
        }else{
        
            [firstScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
    }];
    self.navigationItem.titleView = _itemView;
    firstScrollView.delegate = self;
    //
    customScrollView = [self.view viewWithTag:2001];
//    [customScrollView.panGestureRecognizer addTarget:self action:@selector(closeDrawerController)];
    NSString *imageString1 = @"http://pic12.nipic.com/20110103/3800329_124553022195_2.jpg";
    NSString *imageString2 = @"http://img4q.duitang.com/uploads/item/201406/10/20140610224246_fFuUx.jpeg";
    NSString *imageString3 = @"http://p3.qhimg.com/t01516dde5c3b1e3b69.jpg";
    
    customScrollView.images = @[imageString1,imageString2,imageString3];
}

#pragma mark - 页面将要显示
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_currentIndex == 2) {
        self.mm_drawerController.panGestureRecognizer.enabled = NO;
    }
}
#pragma mark - 控制左边抽屉
- (void)headerIconClicked{
    //如果左边的页面是打开的就让它点击关闭
    if (self.mm_drawerController.openSide == MMDrawerSideLeft) {
        [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    }else{
    //如果左边的页面是关闭的就让它点击打开
        [self.mm_drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
//        self.mm_drawerController.panGestureRecognizer.enabled = YES;
    }
}
#pragma mark - scrollView手动滚动结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.tag != 2001) {
        [self configWithScrollView:scrollView];
        _itemView.whichIndex = _currentIndex;
    }
}
#pragma mark - scrollView代码滚动结束
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (scrollView.tag != 2001) {
        [self configWithScrollView:scrollView];
    }
}
#pragma mark - scrollView滚动不同方向控制抽屉开关
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
#pragma mark - 只要scrollView滚动且满足条件控制抽屉开关
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (_currentIndex == 1 && self.mm_drawerController.panGestureRecognizer.enabled == YES) {
        self.mm_drawerController.panGestureRecognizer.enabled = NO;
    }
}

- (void)closeDrawerController{

    self.mm_drawerController.panGestureRecognizer.enabled = NO;
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
