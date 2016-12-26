//
//  YYChatCell.m
//  YYChatMovie
//
//  Created by ayong on 2016/12/25.
//  Copyright © 2016年 ayong. All rights reserved.
//

#import "YYChatCell.h"

@interface YYChatCell ()
@property (weak, nonatomic) IBOutlet UIImageView *userImgview;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *messageLab;


@end
@implementation YYChatCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
