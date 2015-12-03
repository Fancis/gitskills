//
//  SecondeViewController.m
//  Demo布丁动画
//
//  Created by apple on 15/11/26.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SecondeViewController.h"
#import "UIViewController+MMDrawerController.h"

@interface SecondeViewController ()

@end

@implementation SecondeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.mm_drawerController.panGestureRecognizer.enabled = YES;
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
