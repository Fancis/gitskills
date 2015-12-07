//
//  CustomScrollView.m
//  Demo_OCScroll展示图片
//
//  Created by apple on 15/12/2.
//  Copyright © 2015年 apple. All rights reserved.
//  自定义scrollView控件,用3个view展示无限的内容

#import "CustomScrollView.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "Masonry.h"
#import "UIViewController+MMDrawerController.h"
#import "FirstViewController.h"

@interface CustomScrollView ()<UIScrollViewDelegate>
{

    CGSize _size;
    
    NSMutableArray *_imageViews;
    NSMutableArray *_images;

    UIPageControl *_pageControl;
}
@end

@implementation CustomScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _size = self.frame.size;
        self.delegate = self;
        self.contentSize = CGSizeMake(_size.width * 3, _size.height);
        _imageViews = [NSMutableArray array];
        for (int i = 0; i < 3 ; i++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * _size.width, 0, _size.width, _size.height)];
            imageView.image = _images[i];
            [self addSubview:imageView];
            [_imageViews addObject:imageView];
        }
        self.pagingEnabled = YES;
        [self setContentOffset:CGPointMake(_size.width, 0)];
        [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(autoScrollView) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)didMoveToSuperview{
    _pageControl = [UIPageControl new];
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.numberOfPages = [_imageViews count];
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    _pageControl.currentPage = 1;
    //加载在self的父视图superview上。
    [self.superview addSubview:_pageControl];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
        make.height.equalTo(@10);
        make.width.equalTo(@100);
    }];
}

- (void)autoScrollView{

    [self setContentOffset:CGPointMake(_size.width*2, 0) animated:YES];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
   
    [self anyScrollViewDidEnd:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    [self anyScrollViewDidEnd:scrollView];
}

- (void)setImages:(NSArray *)images{
    _images = [NSMutableArray array];
    [_images addObjectsFromArray:images];
   
    for (int i = 0; i < [_images count]; i++) {
        NSURL *imageURL = [NSURL URLWithString:_images[i]];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _size.width, _size.height)];
        [imageView setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"IMG_0079.JPG"]];
        [_images replaceObjectAtIndex:i withObject:imageView];
    }
    
    if ([_images count] <= 1) {
        UIImageView *imageView = _imageViews[1];
        UIImageView *tempImageView = (UIImageView *)_images[0];
        imageView.image = tempImageView.image;
        
        self.scrollEnabled = NO;

    }else if ([_images count] == 2){
        for (int i = 0; i < 2; i++) {
            UIImageView *imageView = _imageViews[i];
            UIImageView *tempImageView = (UIImageView *)_images[i];
            imageView.image = tempImageView.image;
        }
        UIImageView *imageView3 = _imageViews[2];
        imageView3.image = _images[0];
    }else{
        for (int i = 0; i < 3; i++) {
            UIImageView *imageView = _imageViews[i];
            UIImageView *tempImageView = (UIImageView *)_images[i];
            imageView.image = tempImageView.image;
        }
    }
}

- (void)anyScrollViewDidEnd:(UIScrollView *)scrollView{
    
    static NSInteger currentIndex = 1;
    static NSInteger num = 1;
    NSInteger beforeIndex = 0;
    NSInteger nextIndex = 2;
    
    
    UIImageView *beforeImageView = _imageViews[0];
    UIImageView *currentImageView = _imageViews[1];
    UIImageView *nextImageView = _imageViews[2];
    
    if (scrollView.contentOffset.x == _size.width *2) {
        currentIndex++;
        num++;
        if (num > 2) {
            num = 0;
        }
        if (currentIndex > [_images count] - 1) {
            currentIndex = 0;
        }
    }else if (scrollView.contentOffset.x == 0){
        currentIndex--;
        num--;
        if (num < 0) {
            num = 2;
        }
        if (currentIndex < 0) {
            currentIndex = [_images count] - 1;
        }
    }
    if (currentIndex == 0) {
        beforeIndex = [_images count] - 1;
        nextIndex = currentIndex + 1;
    }else if (currentIndex == [_images count] - 1){
        
        beforeIndex = currentIndex - 1;
        nextIndex = 0;
    }else{
        
        beforeIndex = currentIndex - 1;
        nextIndex = currentIndex + 1;
    }
    
    UIImageView *tempBeforeImageView = (UIImageView *)_images[beforeIndex];
    beforeImageView.image = tempBeforeImageView.image;
    
    UIImageView *tempCurrentImageView = (UIImageView *)_images[currentIndex];
    currentImageView.image = tempCurrentImageView.image;
    
    UIImageView *tempNextImageView = (UIImageView *)_images[nextIndex];
    nextImageView.image = tempNextImageView.image;
    
    [scrollView setContentOffset:CGPointMake(_size.width, 0) animated:NO];
    
    _pageControl.currentPage = num;
    
}
#if 1
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    FirstViewController *firstVC = [self findFirstViewController:self];
    firstVC.mm_drawerController.panGestureRecognizer.enabled = NO;
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
#endif

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
