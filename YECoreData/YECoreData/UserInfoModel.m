//
//  UserInfoModel.m
//  YECoreData
//
//  Created by yongen on 2017/6/7.
//  Copyright © 2017年 yongen. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

#pragma mark -- NSCoding协议实现

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeInteger:self.age forKey:@"age"];
    
    [aCoder encodeBool:self.sex forKey:@"sex"];
    [aCoder encodeObject:self.address forKey:@"address"];
    
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.age =  [aDecoder decodeIntegerForKey:@"age"];
        self.sex = [aDecoder decodeBoolForKey:@"sex"];
        self.address = [aDecoder decodeObjectForKey:@"address"];
        
    }
    return self;
}

#pragma mark -- NSCopying协议实现
- (id)copyWithZone:(nullable NSZone *)zone{
    
    UserInfoModel *model = [[UserInfoModel allocWithZone:zone]init];
    
    model.address = self.address;
    
    model.sex = self.sex;
    
    model.age = self.age;
    
    return model;
}

@end
