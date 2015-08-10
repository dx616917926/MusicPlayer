//
//  CustomTableViewCell.m
//  Music Player
//
//  Created by apple on 15/8/3.
//  Copyright (c) 2015年 dengxiong. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "Masonry.h"

@implementation CustomTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:41/255.0 green:41/255.0 blue:41/255.0 alpha:1];
        //改变UITableViewCell选中时背景色
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.selectedBackgroundView.backgroundColor = [UIColor grayColor];

        _pictureImageView = [UIImageView new];
        _pictureImageView.layer.borderWidth = 2;
        _pictureImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        [self.contentView addSubview:_pictureImageView];
        
        _artistLabel = [UILabel new];
        _artistLabel.numberOfLines = 1;
        _artistLabel.textColor = [UIColor whiteColor];
        _artistLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_artistLabel];
        
        _titleLabel = [UILabel new];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titleLabel];
        
        [_pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.contentView).offset(5);
            make.left.equalTo(self.contentView).offset(10);
            make.height.and.width.equalTo(@110);
        }];
        
        
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_pictureImageView).offset(10);
            make.left.equalTo(_pictureImageView.mas_right).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.bottom.equalTo(_artistLabel.mas_top).offset(-10);
            make.height.equalTo(_artistLabel);
            
        }];
        
        
        [_artistLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.left.equalTo(_titleLabel);
            make.right.equalTo(_titleLabel);
            make.bottom.equalTo(_pictureImageView).offset(-10);
            
            
        }];

        
        
        
        
        
    }
    
    return self;
    



}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
