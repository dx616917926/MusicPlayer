//
//  PlayerViewController.m
//  Music Player
//
//  Created by apple on 15/8/3.
//  Copyright (c) 2015年 dengxiong. All rights reserved.
//

#import "PlayerViewController.h"
#import "Masonry.h"
#import "AFHTTPRequestOperationManager.h"
#import "MJExtension.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "SongModel.h"
#import "CreateView.h"

@interface PlayerViewController ()
{
    UIImageView *_songPic;
    UISlider *_volumeSlider;
    UIView *_maxView;
    UIView *_minView;
    UIButton *_lastSongButton;
    UIButton *_playButton;
    UIButton *_nextSongButton;
    UIButton *_pauseButton;
    UILabel *_titleLabel;
    UIToolbar *_toolbar;
    UIView *_radiusView;
    UIView *_zhizhenView;
    AVPlayer * _Player;
    AVPlayerItem *_playerItem;
    NSInteger i;
    SongModel *songModel;
    NSInteger count;
    UILabel *_currentTimeLabel;
    UILabel *_totalTimeLabel;
    UIProgressView *_songProgressView;
    id _playbackObserver;
  
    
    
}
@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //数组个数
    count = self.songModelArray.count;
    
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    
    //光盘
    _radiusView = [UIImageView new];
    _radiusView.layer.cornerRadius = 140;
    _radiusView.layer.masksToBounds = YES;
    _radiusView.layer.borderWidth = 6;
    _radiusView.layer.borderColor = [UIColor whiteColor].CGColor;
    _radiusView.layer.contents = (__bridge id)([UIImage imageNamed:@"cd.png"].CGImage);
    _radiusView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_radiusView];
    
    //唱片图片
    _songPic = [UIImageView new];
    [self.view addSubview:_songPic];
    _songPic.layer.cornerRadius = 58;
    _songPic.layer.masksToBounds = YES;
    _songPic.layer.borderWidth = 0;
    _songPic.layer.borderColor = [UIColor blackColor].CGColor;
    
    //指针
    _zhizhenView = [UIView new];
    _zhizhenView.layer.anchorPoint = CGPointMake(0.85, 0.5);
    _zhizhenView.layer.contents = (__bridge id)([UIImage imageNamed:@"zhizhen.png"].CGImage);
    
    [self.view addSubview:_zhizhenView];
    
    //歌曲名
    _titleLabel = [UILabel new];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.numberOfLines = 0;
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:_titleLabel];
    
    //进度条
    _songProgressView = [UIProgressView new];
    _songProgressView.layer.cornerRadius = 5;
    _songProgressView.layer.masksToBounds = YES;
    _songProgressView.progressTintColor = [UIColor redColor];
    _songProgressView.trackTintColor = [UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:1];
    [self.view addSubview:_songProgressView];
    //当前进度显示时间
    _currentTimeLabel = [UILabel new];
    _currentTimeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_currentTimeLabel];
    //当前歌曲总时间
    _totalTimeLabel = [UILabel new];
    _totalTimeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_totalTimeLabel];

    //播放按钮
    _playButton = [CreateView creatButtonWithImage:@"pause.png" andAnotherImage:nil andTag:1001];
    [_playButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_playButton];
    //上一首按钮
    _lastSongButton = [CreateView creatButtonWithImage:@"lastsong1.png" andAnotherImage:nil andTag:1002];
    [_lastSongButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_lastSongButton];
    //下一首按钮
    _nextSongButton = [CreateView creatButtonWithImage:@"nextsong1.png" andAnotherImage:nil andTag:1003];
    [_nextSongButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextSongButton];
    
    //音量控制器
    _volumeSlider = [UISlider new];
    _volumeSlider.minimumValue = 0;
    _volumeSlider.maximumValue = 100.0;
    _volumeSlider.value = 20.0;
    _volumeSlider.minimumTrackTintColor = [UIColor redColor];
    _volumeSlider.maximumTrackTintColor = [UIColor blackColor];
    [self.view addSubview:_volumeSlider];
    [_volumeSlider addTarget:self action:@selector(changeVolume:) forControlEvents:UIControlEventValueChanged];
    //最小音量
    _minView = [UIView new];
    _minView.layer.contents = (__bridge id)([UIImage imageNamed:@"minview.png"].CGImage);
    [self.view addSubview:_minView];
    //最大音量
    _maxView = [UIView new];
    _maxView.layer.contents = (__bridge id)([UIImage imageNamed:@"maxview1.png"].CGImage);
    [self.view addSubview:_maxView];
    
    
    
    
    
    //工具栏toolbar
    _toolbar = [UIToolbar new];
    _toolbar.barTintColor = [UIColor blackColor];
    [self.view addSubview:_toolbar];
    
  
    
#pragma  mark -布局
    
#if 1
    //音量控制器
    [_volumeSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top).offset(80);
        make.left.equalTo(self.view.mas_left).offset(80);
        make.right.equalTo(self.view.mas_right).offset(-80);
        make.height.equalTo(@40);
        
    }];
    //最小音量
    [_minView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(_volumeSlider);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.height.and.width.equalTo(@40);
        
    }];
    //最大音量
    [_maxView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(_volumeSlider);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.and.width.equalTo(@40);
        
    }];
#endif

    
    //光盘
    [_radiusView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_volumeSlider.mas_bottom).offset(10);
        make.centerX.equalTo(self.view);
        make.height.and.width.equalTo(@280);
    }];
    //指针
    [_zhizhenView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.view.mas_right).offset(80);
        make.bottom.equalTo(_radiusView.mas_bottom).offset(-20);
        make.width.equalTo(@220);
        make.height.equalTo(@47);
    }];
    _zhizhenView.transform = CGAffineTransformMakeRotation(M_PI_2);
    
    
    //唱片图片
    [_songPic mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(_radiusView);
        make.width.and.height.equalTo(@116);
    }];
    //歌曲名
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_radiusView.mas_bottom).offset(5);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.height.equalTo(@50);
    }];
    //进度条
    [_songProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_titleLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@250);
        make.height.equalTo(@10);
        
    }];
    //当前进度显示时间
    [_currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_songProgressView);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(_songProgressView.mas_left);
        make.height.equalTo(@50);
  
    }];
    
    //当前歌曲总时间
    [_totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_songProgressView);
        make.right.equalTo(self.view.mas_right);
        make.left.equalTo(_songProgressView.mas_right);
        make.height.equalTo(@50);
        
    }];

    
    
    //播放按钮
    [_playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(_toolbar.mas_top).offset(-20);
        make.height.and.width.equalTo(@80);
    }];
    
    
    //上一首按钮
    [_lastSongButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(_playButton);
        make.right.equalTo(_playButton.mas_left).offset(-5);
        make.height.and.width.equalTo(@60);
        
    }];
    //下一首按钮
    [_nextSongButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(_playButton);
        make.left.equalTo(_playButton.mas_right).offset(5);
        make.height.and.width.equalTo(@60);
        
    }];

    //工具栏toolbar
    [_toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.and.left.and.bottom.equalTo(self.view);
        make.height.equalTo(@60);
        
    }];
    
    i = self.index;
    _Player = [AVPlayer playerWithPlayerItem:nil];
    [self songPlayer:i];
    _Player.volume =_volumeSlider.value/10;//默认音量
   
    
#pragma mark -监听
    [_currentTimeLabel addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    
}


#pragma mark -监听回调方法

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"text"]) {
//        NSLog(@">>>%@",change[@"new"]);
        if ([change[@"new"] isEqualToString:@"-00:00"]) {
            
            _songProgressView.progressTintColor = [UIColor redColor];
            
            [UIView animateWithDuration:0.2 animations:^{
                
                _zhizhenView.transform = CGAffineTransformMakeRotation(0*M_PI_2);
                
            }];
        }
        
#pragma mark -一首歌唱完了自动切换到下一首
        if ([change[@"new"] isEqualToString:[NSString stringWithFormat:@"-%@" ,_totalTimeLabel.text]]) {
            
                _songProgressView.progressTintColor = [UIColor clearColor];
            
                if (i<count-1) {
                    i++;
                    [self songPlayer:i];
                }
           
            
            if (i == count-1) {//如果是最后一首
                
                [CreateView alertViewShowWithTitle:@"提示" message:@"已经是最后一首歌啦!"];
                
                [self songPlayer:i];
                
            }

            
        }
    }
    
    
}

#pragma mark -歌曲播放

-(void)songPlayer:(NSInteger)songIndex{
    
    i = songIndex;
    songModel = self.songModelArray[i];
    _songPic.image = [self getImage];
    _titleLabel.text = songModel.title;
    _songProgressView.progress = 0;
    _currentTimeLabel.text = @"00:00";
    [_playButton setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
    isPlayer = YES;

    NSString *str = [PlayerViewController getSongtimeFormatterFrom:songModel.length];
    _totalTimeLabel.text = [[str componentsSeparatedByString:@"-"] lastObject];
# pragma mark -监听歌曲播放进度
    
    NSURL *url = [NSURL URLWithString:songModel.url];
    _playerItem = [[AVPlayerItem alloc]initWithURL:url];
    [_Player replaceCurrentItemWithPlayerItem:_playerItem];
    [_Player play];
    [_Player removeTimeObserver:_playbackObserver];
    AVPlayerItem *theItem=_Player.currentItem;
    CMTime interval = CMTimeMake(1, 24);
    __block UILabel *label = _currentTimeLabel;
    __block UIProgressView *progressView = _songProgressView;
    __block UIView *blackView = _radiusView;
    _playbackObserver = [_Player addPeriodicTimeObserverForInterval:interval queue:nil usingBlock:^(CMTime time) {
       double durationTime = CMTimeGetSeconds(theItem.duration);
       double currentTime = CMTimeGetSeconds(theItem.currentTime);
        label.text = [PlayerViewController getSongtimeFormatterFrom:currentTime];
        CGFloat j = currentTime/durationTime;
        //驱动进度条
        [progressView setProgress:j animated:NO];
        //驱动光盘转动
        blackView.transform = CGAffineTransformMakeRotation(currentTime*M_PI_4*10);
        
        
        
    }];
    



}




#pragma mark -点击button

bool isPlayer = YES;

-(void)clickButton:(UIButton *)sender{
    
#pragma mark -点击播放按钮
    if (sender.tag == 1001) {//点击播放按钮


        if (isPlayer) {//如果是播放状态
            sender.selected = YES;
            [_Player pause];
            [sender setImage:[UIImage imageNamed:@"player.png"] forState:UIControlStateNormal];
            isPlayer = NO;
            [UIView animateWithDuration:0.5 animations:^{
                
                _zhizhenView.transform = CGAffineTransformMakeRotation(M_PI_2);
                
            }];
            
            
        }else{//如果是暂停状态
            
            sender.selected = YES;
            [_Player play];
            [sender setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
            isPlayer = YES;
            [UIView animateWithDuration:0.3 animations:^{
                
                _zhizhenView.transform = CGAffineTransformMakeRotation(0*M_PI_2);
            }];

            
        }
        
    }
    
    
    
#pragma mark -点击上一首按钮
    
    if(sender.tag == 1002){
        
        
        
        
        if (i > 0) {//如果不是第一首
            i --;
            [self songPlayer:i];
    
        }
        
        if (i == 0) {//如果是第一首
            
            [CreateView alertViewShowWithTitle:@"提示" message:@"已经是第一首歌了啦!"];
            [self songPlayer:i];
       
        }
    
    
    }
    
#pragma mark -点击下一首按钮 
    
    if (sender.tag == 1003) {
        
        
        if (i<count-1) {//如果不是最后一首
            i++;
            [self songPlayer:i];
            [_playButton setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
            isPlayer = YES;
            
            
        }
        
        if (i == count-1) {//如果是最后一首
            
            [CreateView alertViewShowWithTitle:@"提示" message:@"已经是最后一首歌啦!"];
            
            [self songPlayer:i];
            
            [_playButton setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
            isPlayer = YES;
            
        }
        
        

        
        
    }
    
    
    

}

#pragma mark -控制音量
-(void)changeVolume:(UISlider *)sender{
    
    _Player.volume = sender.value/10;
    if (sender.value == 0) {
        _minView.layer.contents = (__bridge id)([UIImage imageNamed:@"jingyin.png"].CGImage);
    }else{
        _minView.layer.contents = (__bridge id)([UIImage imageNamed:@"minview.png"].CGImage);
    
    
    }
    
    
    if (sender.value>0&&sender.value<=33) {
        
        _maxView.layer.contents = (__bridge id)([UIImage imageNamed:@"maxview1.png"].CGImage);
    }else if (sender.value>33&&sender.value<=66){
    
         _maxView.layer.contents = (__bridge id)([UIImage imageNamed:@"maxview2.png"].CGImage);
    
    }else if(sender.value>66&&sender.value<=100){
        
        _maxView.layer.contents = (__bridge id)([UIImage imageNamed:@"maxview3.png"].CGImage);
        
    
    }else{
        
        _maxView.layer.contents = (__bridge id)([UIImage imageNamed:nil].CGImage);
    
    
    }


}

#pragma mark -获取唱片图片

-(UIImage *)getImage{
    
    
    NSURL *url = [NSURL URLWithString:songModel.picture];
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    
    return image;



}

#pragma mark -获取歌曲时间格式

+(NSString *)getSongtimeFormatterFrom:(double)time{
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"-mm:ss"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSString *timeString = [dateFormatter stringFromDate:date];
    return timeString;

}


# pragma mark -视图将要消失


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#if 1
-(void)dealloc{
    
    [_currentTimeLabel removeObserver:self forKeyPath:@"text"];
}
#endif


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
