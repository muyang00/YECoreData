//
//  Person+CoreDataProperties.h
//  YECoreData
//
//  Created by yongen on 2017/6/7.
//  Copyright © 2017年 yongen. All rights reserved.
//

#import "Person+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest;

@property (nonatomic) int32_t age;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *sex;
@property (nullable, nonatomic, copy) NSDate *updatedate;

@end

NS_ASSUME_NONNULL_END
