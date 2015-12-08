//
//  CustomCollectionViewCell.m
//  Demo布丁动画
//
//  Created by apple on 15/12/7.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CustomCollectionViewCell.h"
#import "Masonry.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"

@interface CustomCollectionViewCell ()
{
    UIImageView *_imageView;
    UILabel *_label;
    
}
@end

@implementation CustomCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _imageView = [UIImageView new];
        _imageView.layer.cornerRadius = 10;
        _imageView.layer.masksToBounds = YES; //imageView的masksToBounds默认为NO设置为yes圆角才有效果
        [self addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom).with.offset(-20);
            make.width.equalTo(self);
        }];
        _label = [UILabel new];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.backgroundColor = [UIColor whiteColor];
        [self addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.height.equalTo(@20);
            make.width.equalTo(self);
        }];
        
    }
    return self;
}
- (void)setImage:(UIImage *)image{

    [_imageView setImageWithURL:(NSURL *)image placeholderImage:[UIImage imageNamed:@"IMG_0079.JPG"]];
}

- (void)setLabelString:(NSString *)labelString{

    _label.text = labelString;
}

@end
