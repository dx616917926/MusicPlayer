//
//  CreateView.h
//  Music Player
//
//  Created by apple on 15/8/4.
//  Copyright (c) 2015年 dengxiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateView : UIView

# pragma mark -封装alertViewShow
+(void)alertViewShowWithTitle:(NSString *)title message:(NSString *)message;
#pragma mark -封装button
+(UIButton *)creatButtonWithImage:(NSString *)name1 andAnotherImage:(NSString *)name2 andTag:(NSInteger)tag;
@end
