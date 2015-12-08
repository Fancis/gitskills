//
//  CustomCollectionViewLayout.h
//  自定义CollectionViewLayout
//
//  Created by apple on 15/12/7.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomCollectionViewLayoutDelegate <NSObject>

@required
- (CGFloat)collectionViewCellHeight:(NSIndexPath *)indexPath;

@end

@interface CustomCollectionViewLayout : UICollectionViewLayout

@property (nonatomic,assign)CGFloat itemWidth;
@property (nonatomic,assign)CGFloat itemSpace;

@property (nonatomic,weak)id<CustomCollectionViewLayoutDelegate> delegate;

@end
