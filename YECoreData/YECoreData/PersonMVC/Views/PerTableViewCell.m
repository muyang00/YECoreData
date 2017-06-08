//
//  PerTableViewCell.m
//  YECoreData
//
//  Created by yongen on 2017/6/8.
//  Copyright © 2017年 yongen. All rights reserved.
//

#import "PerTableViewCell.h"

@implementation PerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)deleteAction:(UIButton *)sender {
    
    self.deleteblock(self);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
