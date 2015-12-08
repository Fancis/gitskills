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

@interface FirstScrollView ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CustomCollectionViewLayoutDelegate>
{
    CGSize _size;
    CustomScrollView *_customScrollView;
    UICollectionView *_collectionView;
    NSMutableArray *_images;
    NSMutableArray *_names;
    NSMutableArray *_mutiplied;
    
    NSMutableArray *_customScrollViewImages;
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
        NSMutableURLRequest *request1 = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://pudding.cc/api/v1/config?fields=featured_banner&apiKey=yuki_android&version=2.6.5&timestamp=1442737459&auth1=43259fe436b93b0c35681466980d33e3"]];
        [self AFHTTPRequst:request1];
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
        [_collectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
        [self addSubview:_collectionView];
        
        NSMutableURLRequest *request2 = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://pudding.cc/api/v1/category?offset=0&limit=18&apiKey=yuki_android&version=2.6.5&timestamp=1442739762&auth1=76d6029863f2c0c3081e9dea9b67d0ee"]];
        [self AFHTTPRequst:request2];
        
        customLayout.delegate = self;
    }
    return self;
}

- (void)AFHTTPRequst:(NSMutableURLRequest *)request{

    AFHTTPRequestOperationManager *afManager = [AFHTTPRequestOperationManager manager];
    afManager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [request setValue:@"Mozilla/5.0" forHTTPHeaderField:@"User-Agent"];
    
    AFHTTPRequestOperation *operation = [afManager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if ([request.URL isEqual:[NSURL URLWithString:@"http://pudding.cc/api/v1/config?fields=featured_banner&apiKey=yuki_android&version=2.6.5&timestamp=1442737459&auth1=43259fe436b93b0c35681466980d33e3"]]) {
            [self JSonRequest:responseObject];
        }else{
            [self collectionViewCellJSonRequest:responseObject];
        }
        
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"失败，%@",error);
    }];
    [operation start];
}

- (void)JSonRequest:(NSData *)request{

    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:request options:NSJSONReadingMutableLeaves error:nil];
    NSArray *scrollImages = dict[@"featured_banner"];
    for (NSDictionary *tempDict in scrollImages) {
        [_customScrollViewImages addObject:tempDict[@"imageUrl"]];
    }
    _customScrollView.images = _customScrollViewImages;
}

- (void)collectionViewCellJSonRequest:(NSData *)request{
    
    NSArray *JsonArray = [NSJSONSerialization JSONObjectWithData:request options:NSJSONReadingMutableLeaves error:nil];
    for (NSDictionary *tempDict in JsonArray) {
        NSDictionary *imageDict = tempDict[@"image"];
        NSString *urlString = imageDict[@"url"];
        NSURL *url = [NSURL URLWithString:urlString];
        [_images addObject:url];
        NSString *nickName = tempDict[@"name"];
        [_names addObject:nickName];
        NSNumber *width = imageDict[@"width"];
        NSNumber *height = imageDict[@"height"];
        CGFloat tempMutiplied = width.floatValue / height.floatValue;
        NSString *strMutiplied = [NSString stringWithFormat:@"%f",tempMutiplied];
        [_mutiplied addObject:strMutiplied];
    }
    [_collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if ([_images count] != 0) {
        return [_images count];

    }else{
    
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    CustomCollectionViewCell *cell = (CustomCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];

        cell.labelString = _names[indexPath.row];
        cell.image = _images[indexPath.row];

    return cell;
}
//每个cell的高度
- (CGFloat)collectionViewCellHeight:(NSIndexPath *)indexPath{
    if ([_mutiplied count] != 0) {
        static NSInteger num = 0;
        NSString *strMutiplied = _mutiplied[num];
        CGFloat mutiplied = strMutiplied.floatValue;
        num++;
        return 200/mutiplied;

    }else{
    
        return 200.0;
    }
    
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
