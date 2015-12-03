//
//  CustomTableViewCell.m
//  Demo布丁动画
//
//  Created by apple on 15/11/26.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "Masonry.h"

@interface CustomTableViewCell ()
{

    UIImageView *_headerImage;
    UILabel *_headerTitle;
}
@end

@implementation CustomTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        _headerImage = [UIImageView new];
        [self addSubview:_headerImage];
        [_headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
            make.left.equalTo(self.mas_left).with.offset(5);
            make.top.equalTo(self.mas_top).with.offset(8);
            make.bottom.equalTo(self.mas_bottom).with.offset(-8);
            make.width.equalTo(@50);
        }];
        
        _headerTitle = [UILabel new];
        _headerTitle.textColor = [UIColor whiteColor];
        _headerTitle.font = [UIFont systemFontOfSize:18];
        [self addSubview:_headerTitle];
        [_headerTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headerImage.mas_right).with.offset(20);
            make.top.equalTo(self.mas_top).with.offset(8);
            make.bottom.equalTo(self.mas_bottom).with.offset(-8);
            make.width.equalTo(@168);
            
        }];
        
    }
    return self;
    
}

- (void)setHeadImage:(UIImage *)headImage{

    _headerImage.image = headImage;
}

- (void)setHeadTitle:(NSString *)headTitle{

    _headerTitle.text = headTitle;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
