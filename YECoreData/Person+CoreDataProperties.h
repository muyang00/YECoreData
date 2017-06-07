//
//  Person+CoreDataProperties.h
//  YECoreData
//
//  Created by yongen on 17/3/10.
//  Copyright © 2017年 yongen. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Person+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest;

@property (nonatomic) int32_t age;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *sex;
@property (nullable, nonatomic, copy) NSDate *updatedate;

//插入数据
+ (BOOL)insertPersonname:(NSString *)name andage:(NSInteger)age andupdate:(NSDate *)update andsex:(NSString *)sex;

/**
 *  //条件查询
 *
 *  @param searchtype 1.为按更新时间   2.按年龄
 *  @param pagesize   2.查询个数
 *  @param age        3.年龄要求
 *  @param sex        4.性别要求
 *  @param ascending  5.是否升序
 *  @return
 */

+ (NSArray *)selectWithType:(NSInteger)searchtype andpageSize:(NSInteger)pagesize andAge:(NSInteger)age andsex:(NSInteger)sex andascending:(BOOL)ascending;

//查询all
+ (NSArray *)searchPerson;

//更新数据
+ (void)updatePerson:(Person *)person andkey:(NSString *)key anddata:(NSString *)data;

//删除数据
+ (void)deleteWithPerson:(Person *)person;

//删除所有数据
+ (void)deleteAllDatas;


@end

NS_ASSUME_NONNULL_END
