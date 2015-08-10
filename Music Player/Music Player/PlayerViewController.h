//
//  PlayerViewController.h
//  Music Player
//
//  Created by apple on 15/8/3.
//  Copyright (c) 2015年 dengxiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerViewController : UIViewController

@property(nonatomic,strong) NSMutableArray *songModelArray;
@property(nonatomic,assign)NSInteger index;

@end
