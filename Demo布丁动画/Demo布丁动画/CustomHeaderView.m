//
//  CustomHeaderView.m
//  Demo布丁动画
//
//  Created by apple on 15/11/26.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CustomHeaderView.h"
#import "CircleView.h"
#import "Masonry.h"

@interface CustomHeaderView ()
{
    UIButton *_buttonHeader;
    UILabel *_nickName;
    UIButton *_followCount;
    UIButton *_fansCount;

    void(^tempBlc)(UIButton *,NSInteger);
}
@end

@implementation CustomHeaderView

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        CircleView *circleView = [CircleView new];
        [self addSubview:circleView];
        [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(40);
            make.centerX.equalTo(self);
            make.width.and.height.equalTo(@100);
            
        }];

        _buttonHeader = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonHeader addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        //裁剪圆外切矩形
        _buttonHeader.layer.masksToBounds = YES;
        _buttonHeader.layer.cornerRadius = 40;
        [self addSubview:_buttonHeader];
        [_buttonHeader setImage:[UIImage imageNamed:@"defaultLogin"] forState:UIControlStateNormal];
        _buttonHeader.tag = 2001;
        [_buttonHeader mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(circleView);
            make.width.and.height.equalTo(@80);
        }];
        
        _nickName = [UILabel new];
        [self addSubview:_nickName];
        _nickName.text = @"登录同步追番纪录";
        _nickName.textColor = [UIColor whiteColor];
        _nickName.textAlignment = NSTextAlignmentCenter;
        _nickName.font = [UIFont systemFontOfSize:20];
        [_nickName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(_buttonHeader.mas_bottom).with.offset(10);
            make.width.equalTo(@225);
            make.height.equalTo(@40);
        }];
        
        _followCount = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_followCount];
        [_followCount addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_followCount setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_followCount setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        _followCount.tag = 2002;
        _followCount.titleLabel.font = [UIFont systemFontOfSize:16];
        _followCount.hidden = YES;
        
        
        _fansCount = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_fansCount];
        [_fansCount addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_fansCount setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_fansCount setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        _fansCount.tag = 2003;
        _fansCount.titleLabel.font = [UIFont systemFontOfSize:16];
        _fansCount.hidden = YES;

        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    NSArray *labels = @[_followCount,_fansCount];
    [labels mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:50 leadSpacing:30 tailSpacing:30];
    [labels mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).with.offset(-20);
        make.height.equalTo(@30);
    }];
    
}

- (void)setHeadimage:(UIImage *)headimage{

    [_buttonHeader setImage:headimage forState:UIControlStateNormal];
}

- (void)setName:(NSString *)name{

    if (self.isLoagin == YES) {
        _nickName.text = name;
    }
    
}

- (void)setFollow:(NSString *)follow{

    NSString *title = [NSString stringWithFormat:@"关注 %@",follow];
    [_followCount setTitle:title forState:UIControlStateNormal];
}

- (void)setFans:(NSString *)fans{

    NSString *title = [NSString stringWithFormat:@"粉丝 %@",fans];
    [_fansCount setTitle:title forState:UIControlStateNormal];
}
#if 1
- (void)setIsLoagin:(BOOL)isLoagin{
    _isLoagin = isLoagin;
    _followCount.hidden = !isLoagin;
    _fansCount.hidden = !isLoagin;
}
#endif
#pragma mark - button被点击
- (void)buttonClicked:(UIButton *)sender{

    if (tempBlc) {
        tempBlc(sender,(sender.tag - 2000));
    }
}

- (void)whichButtonClicked:(void (^)(UIButton *button, NSInteger index))blc{

    tempBlc = ^(UIButton *button,NSInteger index){
    
        blc(button,index);
    };
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
}


@end
