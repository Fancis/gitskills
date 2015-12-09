//
//  DataManager.m
//  Demo布丁动画
//
//  Created by apple on 15/12/9.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "DataManager.h"
#import "YYModel.h"
#import "YYModelCollectionViewCell.h"
#import "YYModelScorllImages.h"
#import "APIs.h"

@implementation DataManager

- (void)dataManagerWithResponseObj:(id)responseObj andError:(NSError *)error{

    if ([responseObj isKindOfClass:[NSDictionary class]]) {
        _scrollImages = [NSMutableArray array];
        NSDictionary *dict = responseObj;
        NSArray *scrollImages = dict[kScrollImagesArray];
        for (NSDictionary *tempDict in scrollImages) {
            YYModelScorllImages *yyImageUrl = [YYModelScorllImages yy_modelWithJSON:tempDict];

            [_scrollImages addObject:yyImageUrl.imageUrl];
        }
        if ([self.delegate respondsToSelector:@selector(theDataManagerIsFull:)]) {
            [self.delegate theDataManagerIsFull:self];
        }
    }else if ([responseObj isKindOfClass:[NSArray class]]){
        _images = [NSMutableArray array];
        _names = [NSMutableArray array];
        _mutiplied = [NSMutableArray array];
        NSArray *JsonArray = responseObj;
        for (NSDictionary *tempDict in JsonArray) {
            YYModelCollectionViewCell *yyCell = [YYModelCollectionViewCell yy_modelWithJSON:tempDict];
            [_images addObject:yyCell.image.url];
            [_names addObject:yyCell.name];
            [_mutiplied addObject:@(yyCell.image.width/yyCell.image.height)];
        }
        if ([self.delegate respondsToSelector:@selector(theDataManagerIsFull:)]) {
            [self.delegate theDataManagerIsFull:self];
        }
    }
}
@end
