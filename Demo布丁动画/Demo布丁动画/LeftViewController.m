//
//  LeftViewController.m
//  Demo布丁动画
//
//  Created by apple on 15/11/26.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "LeftViewController.h"
#import "CustomTableViewCell.h"
#import "CustomFooterView.h"
#import "CustomHeaderView.h"

#import "Masonry.h"

@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>
{

    UITableView *_tableView;
    NSArray *_List;
    NSArray *_images;
}
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[CustomTableViewCell class] forCellReuseIdentifier:@"cellId"];
    [self.view addSubview:_tableView];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, self.view.frame.size.height)];
    _tableView.backgroundView = imageView;
    imageView.image = [UIImage imageNamed:@"BGI_1.jpg"];
#pragma mark - tableheaderView
    CustomHeaderView *headerView = [[CustomHeaderView alloc]initWithFrame:CGRectMake(0, 0, 100, 250)];
    _tableView.tableHeaderView = headerView;
    
    headerView.isLoagin = YES;
//    headerView.headimage = [UIImage imageNamed:@""];
    headerView.name = @"Francis";
    headerView.follow = @"30";
    headerView.fans = @"40亿";
    [headerView whichButtonClicked:^(UIButton *button, NSInteger index) {
        NSLog(@"--->%ld",index);
    }];
    
    
#pragma mark - tableFootView
    CustomFooterView *footerView = [[CustomFooterView alloc]initWithFrame:CGRectMake(0, 0, 100, 250)];
    _tableView.tableFooterView = footerView;
    
    [footerView whichButtonClicked:^(UIButton *button, NSInteger index) {
        NSLog(@"~~~~>%ld",index);
    }];
    //
    _tableView.rowHeight = 66;
    _tableView.scrollEnabled = NO;//设置cell不可滚动
    _tableView.separatorStyle = NO;//设置cell无分割线／分隔线
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
  
        make.edges.equalTo(self.view);
    }];
    //
    _List = @[@"追番纪录",@"离线缓存",@"布丁统计",@"布丁娘送周边"];
    UIImage *image = [UIImage imageNamed:@"zhuiFan"];
    UIImage *image2 = [UIImage imageNamed:@"cloud"];
    UIImage *image3 = [UIImage imageNamed:@"tongji"];
    UIImage *image4 = [UIImage imageNamed:@"zhoubian"];
    _images = @[image,image2,image3,image4];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [_List count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cellId"];
    
    cell.headTitle = _List[indexPath.row];
    cell.headImage = _images[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
