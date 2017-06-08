//
//  AddViewController.h
//  YECoreData
//
//  Created by yongen on 2017/6/8.
//  Copyright © 2017年 yongen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    addType=0,
    updateType=1
    
}optionType;

@interface AddViewController : UIViewController

@property(nonatomic,assign)optionType type;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,assign)NSInteger age;
@property(nonatomic,copy)NSString* sexType;

@end
