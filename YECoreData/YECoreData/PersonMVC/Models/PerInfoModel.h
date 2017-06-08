//
//  PerInfoModel.h
//  YECoreData
//
//  Created by yongen on 2017/6/8.
//  Copyright © 2017年 yongen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PerInfoModel : NSObject

@property(nonatomic,copy)NSString *name;

@property(nonatomic,strong)NSDate *update;

@property(nonatomic,assign)int age;

@property(nonatomic,copy)NSString*sex;

@end
