//
//  CustomCollectionViewLayout.m
//  自定义CollectionViewLayout
//
//  Created by apple on 15/12/7.
//  Copyright © 2015年 apple. All rights reserved.
// 自定义高度不一样的cell

#import "CustomCollectionViewLayout.h"


@interface CustomCollectionViewLayout ()
{

    CGFloat _itemWidth;
    CGFloat _itemSpace;

    NSInteger _totalColumn;
    NSMutableArray *_recodesPosition_y;
    NSMutableArray *_attrs;
    
}
@end

@implementation CustomCollectionViewLayout

- (instancetype)init{

    self = [super init];
    if (self) {

        _itemWidth = 88;
        _itemSpace = 8;
        
        _recodesPosition_y = [NSMutableArray array];
        _attrs = [NSMutableArray array];
        
    }
    return self;
}
//准备布局
- (void)prepareLayout{

    [super prepareLayout];
    
    _totalColumn = (CGFloat)(self.collectionView.frame.size.width - _itemSpace ) / (_itemSpace + _itemWidth);
    _totalColumn = (NSInteger)floorf(_totalColumn);//不满1取小
    _itemSpace = (self.collectionView.frame.size.width - _totalColumn * _itemWidth) / (_totalColumn + 1);
    //每一列item的所有y坐标用一个数组存起来再放到一个大数组里
    for (int i = 0; i < _totalColumn; i++) {
        NSMutableArray *recodeY = [NSMutableArray array];
        if ([_recodesPosition_y count] < _totalColumn) {
            [_recodesPosition_y addObject:recodeY];
        }
    }
    
    NSInteger sections = [self.collectionView numberOfSections];//获取sections的总数
    for (int i = 0; i < sections; i++) {
        NSInteger totalItems = [self.collectionView numberOfItemsInSection:i];//获取该sections里所有的items
        
        for (int j = 0; j < totalItems; j++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];//拿到当前item的indexPath
            NSInteger currentIndex = j % _totalColumn;//计算当前item处于第几列就放到第几个储存Y坐标的数组里
            NSMutableArray *tempRecodeY = _recodesPosition_y[currentIndex];
            NSNumber *numOfY = [tempRecodeY lastObject];
            
            CGFloat position_y = numOfY.integerValue + _itemSpace;
            CGFloat position_x = (currentIndex + 1)*_itemSpace + currentIndex * _itemWidth;
            
            CGFloat itemHeight = [self.delegate collectionViewCellHeight:indexPath];//获取外界给的item的高度
            [tempRecodeY addObject:@(itemHeight + position_y)];
            
            UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            attr.frame = CGRectMake(position_x, position_y, _itemWidth, itemHeight);//给当前indexPath的item属性赋值
            
            [_attrs addObject:attr];
        }
    }
}
#pragma mark - 必需要实现的方法三个方法之一，给所有的item设置属性attributes
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{

    return _attrs;
}
//设置collectionViewContentSize
- (CGSize)collectionViewContentSize{
    if (![_attrs count]) {
        return CGSizeZero;
    }
    //拿到最底下的那个item的高度maxHeight
    NSMutableArray *tempY = [NSMutableArray array];
    for (NSMutableArray *tempArray in _recodesPosition_y) {
        NSNumber *numOfY = [tempArray lastObject];
        [tempY addObject:numOfY];
    }
    NSNumber *tempNumOfY = tempY[0];
    CGFloat maxHeight = tempNumOfY.floatValue;
    for (NSNumber *tempHeight in tempY) {

        if (maxHeight < tempHeight.floatValue) {
            maxHeight = tempHeight.floatValue;
        }
    }
    return CGSizeMake(self.collectionView.frame.size.width, maxHeight + _itemSpace);
}

- (void)setItemWidth:(CGFloat)itemWidth{

    _itemWidth = itemWidth;
}

- (void)setItemSpace:(CGFloat)itemSpace{

    _itemSpace = itemSpace;
}

@end
