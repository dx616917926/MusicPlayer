//
//  SongModel.h
//  Music Player
//
//  Created by apple on 15/8/3.
//  Copyright (c) 2015年 dengxiong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SongModel : NSObject

@property(nonatomic,copy)NSString *artist;//歌手名字artist = "Judy Collins";
@property(nonatomic,copy)NSString *picture;//歌曲图片picture = "http://img3.douban.com/lpic/s27318623.jpg";
@property(nonatomic,assign)NSInteger public_time;//歌曲发行时间"public_time" = 1990;
@property(nonatomic,copy)NSString *title;//歌曲名字title = "Just Like Tom Thumb's Blues";
@property(nonatomic,copy)NSString *url;//歌曲链接url = "http://mr3.douban.com/201508031711/8aa08159c6accf59b6698f326462cd2b/view/song/small/p2499596_128k.mp3";
@property(nonatomic,assign)double length;//歌曲时长length = 253;
@end
