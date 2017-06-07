//
//  UserInfoModel.h
//  YECoreData
//
//  Created by yongen on 2017/6/7.
//  Copyright © 2017年 yongen. All rights reserved.
//

#import <Foundation/Foundation.h>

//遵守NSCoding协议实现数据存储，但先要了解NSCoder，因为协议目的只是规范，真正进行归档和解档作用的是NSCoder。
//为了实现 copy
@interface UserInfoModel : NSObject<NSCoding, NSCopying>

/* brief:年龄 */
@property (nonatomic,assign)  NSInteger age;

/* brief:性别 */
@property (nonatomic,assign)  BOOL sex;

/* brief:地址 */
@property (nonatomic,strong)  NSString *address;


@end
