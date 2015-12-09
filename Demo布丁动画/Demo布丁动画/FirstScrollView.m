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
#import "CustomCollectionViewCell.h"
#import "Masonry.h"
#import "CustomCollectionViewLayout.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "NetworkManager.h"
#import "DataManager.h"
#import "APIs.h"

#import "YYModel.h"
#import "YYModelCollectionViewCell.h"
#import "YYModelScorllImages.h"


@interface FirstScrollView ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CustomCollectionViewLayoutDelegate,NetWorkManagerDelegate,DataManagerDelegate>
{
    CGSize _size;
    CustomScrollView *_customScrollView;
    UICollectionView *_collectionView;
    NSMutableArray *_images;
    NSMutableArray *_names;
    NSMutableArray *_mutiplied;
    
    NSMutableArray *_customScrollViewImages;
    
    DataManager *_dataManager;
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
        [self.panGestureRecognizer addTarget:self action:@selector(openDrawerController)];

        _customScrollView = [[CustomScrollView alloc]initWithFrame:CGRectMake(0, 0, _size.width, 128)];
        [view1 addSubview:_customScrollView];
        //网络请求类
        NetworkManager *netManager = [NetworkManager new];
        netManager.delegate = self;
        //数据解析类
        _dataManager = [DataManager new];
        _dataManager.delegate = self;
        [netManager netWorkManagerWithURL:[NSString stringWithFormat:@"%@%@",kHomePath,kCategoryScrollImages] andPara:nil];
        //
        _images = [NSMutableArray array];
        _names = [NSMutableArray array];
        _mutiplied = [NSMutableArray array];
        _customScrollViewImages = [NSMutableArray array];
        
        CustomCollectionViewLayout *customLayout = [CustomCollectionViewLayout new];
        customLayout.itemSpace = 2;
        customLayout.itemWidth = 190;
        //高度－49是因为下面tabBar的高度为49
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 128, self.frame.size.width, self.frame.size.height - 128 - 49) collectionViewLayout:customLayout];//用masonry约束会出bug；
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:kCellId];
        [self addSubview:_collectionView];
        [netManager netWorkManagerWithURL:[NSString stringWithFormat:@"%@%@",kHomePath,kCategoryCollectionViewCell] andPara:nil];
        customLayout.delegate = self;
    }
    return self;
}
#pragma mark - 网络请求成功回调方法
- (void)theResponseResultWith:(NetworkManager *)manager andResponseObj:(id)responseObj andError:(NSError *)error{
    if (error) {
        NSLog(@"%@",error);
        return;
    }
    [_dataManager dataManagerWithResponseObj:responseObj andError:error];
}
#pragma mark - 数据解析完成后调用的方法
- (void)theDataManagerIsFull:(DataManager *)dataManager{

    _dataManager = dataManager;
    if ([_dataManager.scrollImages count] != 0) {
    _customScrollView.images = _dataManager.scrollImages;
    }
    if ([_dataManager.images count] != 0) {
        [_collectionView reloadData];
    }
}
#pragma mark - 返回的collectionViewCell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

        return [_dataManager.images count];
}
#pragma mark - 取出注册的collectionViewCell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    CustomCollectionViewCell *cell = (CustomCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCellId forIndexPath:indexPath];

    cell.labelString = _dataManager.names[indexPath.row];
    cell.image = _dataManager.images[indexPath.row];

    return cell;
}
#pragma mark - 每个cell的高度
- (CGFloat)collectionViewCellHeight:(NSIndexPath *)indexPath{
        static NSInteger num = 0;
        NSString *strMutiplied = _dataManager.mutiplied[num];
        CGFloat mutiplied = strMutiplied.floatValue;
        num++;
        return 200/mutiplied;
}
#pragma mark - 拖动手势panGestureRecognizer被触发调用方法
- (void)openDrawerController{
    FirstViewController *firstVC = [self findFirstViewController:self];
    firstVC.mm_drawerController.panGestureRecognizer.enabled = YES;
}
#pragma mark - 从responder层中获取到FirstViewController
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
