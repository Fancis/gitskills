//
//  AppDelegate.m
//  Demo布丁动画
//
//  Created by apple on 15/11/26.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "SecondeViewController.h"
#import "ThirdViewController.h"
#import "LeftViewController.h"

#import "MMDrawerController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];

    FirstViewController *firstVC = [FirstViewController new];
    SecondeViewController *secondeVC = [SecondeViewController new];
    ThirdViewController *thirdVC = [ThirdViewController new];
    
    LeftViewController *leftVC = [LeftViewController new];
    
    UINavigationController *firstNav = [[UINavigationController alloc]initWithRootViewController:firstVC];
    UINavigationController *secondeNav = [[UINavigationController alloc]initWithRootViewController:secondeVC];
    UINavigationController *thirdNav = [[UINavigationController alloc]initWithRootViewController:thirdVC];
    
    UITabBarController *tabBarController = [UITabBarController new];
    tabBarController.viewControllers = @[firstNav,secondeNav,thirdNav];
    
    UIImage *fanZu = [UIImage imageNamed:@"fanZu"];
    fanZu = [fanZu imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *seleFanZu = [UIImage imageNamed:@"selectFanZu"];
    seleFanZu = [seleFanZu imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *timeLine = [UIImage imageNamed:@"timeLine"];
    timeLine = [timeLine imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectTimeLine = [UIImage imageNamed:@"selectTimeLine"];
    selectTimeLine = [selectTimeLine imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *yiCiYuan = [UIImage imageNamed:@"yiCiYuan"];
    yiCiYuan = [yiCiYuan imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectYiCiYuan = [UIImage imageNamed:@"selectYiCiYuan"];
    selectYiCiYuan = [selectYiCiYuan imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    firstVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:nil image:seleFanZu selectedImage:fanZu];
    secondeVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:nil image:timeLine selectedImage:selectTimeLine];
    thirdVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:nil image:yiCiYuan selectedImage:selectYiCiYuan];
    
    MMDrawerController *drawerController = [[MMDrawerController alloc]initWithCenterViewController:tabBarController leftDrawerViewController:leftVC];
    //左边页面可被拉出
    drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    //MMOpenDrawerGestureModeBezelPanningCenterView，只有点击左边20个像素拖动才可以拉出抽屉
    drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    
    self.window.rootViewController = drawerController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
