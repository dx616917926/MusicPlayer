//
//  DouBanChannelViewController.m
//  Music Player
//
//  Created by apple on 15/8/3.
//  Copyright (c) 2015年 dengxiong. All rights reserved.
//

#import "DouBanChannelViewController.h"
#import "Masonry.h"
#import "SongViewController.h"
#import "MASConstraint.h"
@interface DouBanChannelViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_channelArray;
    UITableView *_channelTableView;
}

@end

@implementation DouBanChannelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"豆瓣电台";
    //导航栏颜色
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    //导航栏标题颜色
    UIColor *color= [UIColor blackColor];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey: NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    _channelArray = @[@"1、华语MHz",@"2、欧美MHz",@"3、70MHz ",@"4、80MHz",@"5、90MHz",@"6、粤语MHz ",@"7、摇滚MHz ",@"8、民谣MHz ",@"9、轻音乐MHz",@"10、电影原声MHz ",@"11、爵士MHz",@"12、电子MHz",@"13、说唱MHz ",@"14、R&BMHz ",@"15、日语MHz"];
    
    
    
    _channelTableView = [UITableView new];
    [self.view addSubview:_channelTableView];
    _channelTableView.delegate = self;
    _channelTableView.dataSource = self;
    _channelTableView.rowHeight = 60;
    //    _tableView.separatorStyle = NO;
    [_channelTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [_channelTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.left.and.bottom.right.equalTo(self.view);
        
        
    }];

}






#pragma mark -tableView的实现

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _channelArray.count;
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    cell.textLabel.text = _channelArray[indexPath.row];
    return cell;
    
    
}


#pragma mark - cell点击

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SongViewController *VC = [SongViewController new];
    VC.index = indexPath.row;
    VC.channelname = _channelArray[indexPath.row];
    [self.navigationController pushViewController:VC animated:YES];
    


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
