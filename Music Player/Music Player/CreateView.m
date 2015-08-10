//
//  CreateView.m
//  Music Player
//
//  Created by apple on 15/8/4.
//  Copyright (c) 2015年 dengxiong. All rights reserved.
//

#import "CreateView.h"

@implementation CreateView

 
+(void)alertViewShowWithTitle:(NSString *)title message:(NSString *)message{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    
    [alertView show];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        [alertView dismissWithClickedButtonIndex:0 animated:YES];
//    });
    



}


#pragma mark -封装button
+(UIButton *)creatButtonWithImage:(NSString *)name1 andAnotherImage:(NSString *)name2 andTag:(NSInteger)tag{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:name1] forState:UIControlStateNormal];
//    [button setImage:[UIImage imageNamed:name2] forState:UIControlStateSelected];
    button.tag = tag;

    return button;

}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/




@end
