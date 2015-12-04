//
//  FirstNavigationItemButton.m
//  Demo布丁动画
//
//  Created by apple on 15/11/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "FirstNavigationItemView.h"
#import "Masonry.h"
#import "CustomSendMessage.h"
@interface FirstNavigationItemView ()
{
    UIButton *_tempButton;
    UIView *_lineView;
    void (^tempBlc)(UIButton *button,NSInteger index);
 

}
@end

@implementation FirstNavigationItemView

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {

        
        UIButton *button1 = [self buttonWithTitle:@"推荐" andTag:1101];
        [self addSubview:button1];
        [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.equalTo(self);
            make.bottom.equalTo(self.mas_bottom).with.offset(-3);
            make.width.equalTo(self.mas_width).with.multipliedBy(0.5);
        }];
        //让button1默认被选择
        button1.selected = YES;
        _tempButton = button1;
        
        UIButton *button2 = [self buttonWithTitle:@"分类" andTag:1102];
        [self addSubview:button2];
        [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.right.equalTo(self);
            make.bottom.equalTo(self.mas_bottom).with.offset(-3);
            make.width.equalTo(self.mas_width).with.multipliedBy(0.5);
        }];
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor orangeColor];
        [self addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(button1.mas_bottom);
            make.left.and.bottom.equalTo(self);
            make.width.equalTo(self.mas_width).with.multipliedBy(0.5);
        }];

        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor grayColor];
        [self addSubview:label];
        label.alpha = 0.2;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.equalTo(@1);
            make.top.equalTo(self.mas_top).with.offset(12);
            make.bottom.equalTo(self.mas_bottom).with.offset(-12);
        }];
    }
    return self;
}
#pragma mark - 创建button的方法
- (UIButton *)buttonWithTitle:(NSString *)title andTag:(NSInteger)tag{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = tag;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}
#pragma mark -点击button
- (void)buttonClicked:(UIButton *)sender{

    _tempButton.selected = NO;
    sender.selected = YES;
    _tempButton = sender;
    
    if (tempBlc) {
        tempBlc(sender,sender.tag - 1100);
    }
    
    if ([sender.currentTitle isEqual:@"推荐"]) {
        [self lineViewToLeft:sender];
    }else if ([sender.currentTitle isEqualToString:@"分类"]){
        
        [self lineViewToRight:sender];
    }
}
#pragma mark - 将lineView移到被选中的button下
- (void)lineViewToLeft:(UIButton *)sender{

    [_lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
    }];
    [self lineViewToleftAndRightLayout];
}

- (void)lineViewToRight:(UIButton *)sender{

    [_lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(self.frame.size.width * 0.5);
    }];
    [self lineViewToleftAndRightLayout];
}
#pragma mark - 布局动画
- (void)lineViewToleftAndRightLayout{
    [UIView animateWithDuration:0.35 animations:^{
        [self layoutIfNeeded];//需要时自动调用布局
    } completion:nil];
}
#pragma mark - 让button与外界交互
- (void)whichButtonClicked:(void (^)(UIButton *button, NSInteger index))blc{

    tempBlc = ^(UIButton *button,NSInteger index){
    
        blc(button,index);
    };
}

- (void)setWhichIndex:(NSInteger)whichIndex{

    UIButton *tempButton = (UIButton *)[self viewWithTag:whichIndex + 1100];
    
    _tempButton.selected = NO;
    tempButton.selected = YES;
    _tempButton = tempButton;

    if (whichIndex == 1) {
        [self lineViewToLeft:tempButton];
    }else if (whichIndex == 2){
        
        [self lineViewToRight:tempButton];
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
