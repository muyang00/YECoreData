//
//  PerTableViewCell.h
//  YECoreData
//
//  Created by yongen on 2017/6/8.
//  Copyright © 2017年 yongen. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^deleteBlock) (UITableViewCell *);

@interface PerTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (nonatomic, copy) deleteBlock deleteblock;

@end
