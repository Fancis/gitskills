//
//  CustomFooterView.m
//  Demo布丁动画
//
//  Created by apple on 15/11/26.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CustomFooterView.h"
#import "Masonry.h"

@interface CustomFooterView ()
{

    UIImageView *_footImage1;
    UIImageView *_footImage2;
    
    UIButton *_button1;
    UIButton *_button2;
    
    void(^tempBlc)(UIButton *,NSInteger);
}
@end

@implementation CustomFooterView

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _button1.backgroundColor = [UIColor clearColor];
        _button1.tag = 3001;
        [_button1 setTitle:@"设置" forState:UIControlStateNormal];
//        _button1.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_button1 setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [_button1 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button1];

        _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _button2.backgroundColor = [UIColor clearColor];
//        _button2.titleLabel.textAlignment = NSTextAlignmentLeft;//button文字居左
        _button2.tag = 3002;
        [_button2 setTitle:@"通知" forState:UIControlStateNormal];
        [_button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_button2 setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [_button2 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button2];
        
        _footImage1 = [UIImageView new];
        [self addSubview:_footImage1];
        _footImage1.image = [UIImage imageNamed:@"setIcon"];
    
        _footImage2 = [UIImageView new];
        [self addSubview:_footImage2];
        _footImage2.image = [UIImage imageNamed:@"notiIcon"];
    }
    return self;
}

- (void)layoutSubviews{
    
    NSArray *buttons = @[_footImage1,_button1,_footImage2,_button2];
    
    [buttons mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:20 tailSpacing:5 ];
    
    [buttons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).with.offset(-50);
        make.height.equalTo(@30);
    }];
}

- (void)buttonClicked:(UIButton *)sender{

    if (tempBlc) {
        tempBlc(sender,(sender.tag - 3000));
    }
}

- (void)whichButtonClicked:(void (^)(UIButton *button, NSInteger index))blc{

    tempBlc = ^(UIButton *button,NSInteger index){
    
        blc(button,index);
    };
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
