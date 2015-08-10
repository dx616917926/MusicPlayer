//
//  ViewController.h
//  Music Player
//
//  Created by apple on 15/8/3.
//  Copyright (c) 2015年 dengxiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SongViewController : UIViewController
@property(nonatomic,assign)NSInteger index;//用来接收上个界面push过来点击的是那个cell
@property(nonatomic,strong)NSString *channelname;//电台名
@end

