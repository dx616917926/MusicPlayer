//
//  ViewController.m
//  Music Player
//
//  Created by apple on 15/8/3.
//  Copyright (c) 2015年 dengxiong. All rights reserved.
//

#import "SongViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "SongModel.h"
#import "PlayerViewController.h"
#import "CustomTableViewCell.h"
#import "CreateView.h"
@interface SongViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *songModelArray;//歌曲模型数组
    UITableView *_tableView;
}

@end

@implementation SongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    //导航栏名
    self.navigationItem.title = [self.channelname componentsSeparatedByString:@"、"].lastObject ;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    songModelArray = [NSMutableArray array];
    _tableView = [UITableView new];
    _tableView.indicatorStyle=UIScrollViewIndicatorStyleWhite;
    _tableView.backgroundColor = [UIColor colorWithRed:41/255.0 green:41/255.0 blue:41/255.0 alpha:1];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 120;
    //设置tableViewCell间的分割的样式
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //设置tableViewCell间的分割线的颜色
    [_tableView setSeparatorColor:[UIColor redColor]];
    [_tableView registerClass:[CustomTableViewCell class] forCellReuseIdentifier:@"cell1"];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.left.and.bottom.right.equalTo(self.view);
        
        
    }];
    
    
    [self requestConnection];
    
}


#pragma mark - 请求链接
-(void)requestConnection{
    
    NSString *source = [NSString stringWithFormat:@"http://douban.fm/j/mine/playlist?type=n&channel=%ld",(long)self.index];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 10;
    [manager GET:source parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//网络正常
        
        NSArray *array = responseObject[@"song"];
        
        for (NSDictionary *tempDic in array) {
            
            SongModel *songModel = [SongModel objectWithKeyValues:tempDic];
            [songModelArray addObject:songModel];
            [_tableView reloadData];
            //            NSLog(@">>>%f",songModel.length);
        }
        //                NSLog(@">>>%@",responseObject[@"song"]);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {//网络错误
        
        [CreateView alertViewShowWithTitle:@"提示" message:[error localizedDescription]];
        NSLog(@"%@",[error localizedDescription]);
    }];
    
    
}




# pragma mark -View将要出现
-(void)viewWillAppear:(BOOL)animated{
    
    
    
}


#pragma mark -tableView的实现

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return songModelArray.count;


}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    SongModel *songModel = songModelArray[indexPath.row];
//    cell.pictureImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:songModel.picture]]];
    [cell.pictureImageView sd_setImageWithURL:[NSURL URLWithString:songModel.picture] placeholderImage:[UIImage imageNamed:@"1.jpg"]];
    cell.artistLabel.text = [NSString stringWithFormat:@"歌手:%@", songModel.artist];
    cell.titleLabel.text = [NSString stringWithFormat:@"曲名:%@", songModel.title];
    return cell;


}


#pragma mark - cell点击

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PlayerViewController *playerVC = [PlayerViewController new];
    playerVC.index = indexPath.row;
    playerVC.songModelArray = songModelArray;
    [self.navigationController pushViewController:playerVC animated:YES];
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
