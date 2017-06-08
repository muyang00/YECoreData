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

@property (nullable, nonatomic, retain) NSNumber *age;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *sex;
@property (nullable, nonatomic, copy) NSDate *updatedate;


//插入数据
+(BOOL)insertPersonname:(NSString*)name andage:(NSInteger)age andupdate:(NSDate*)update andsex:(NSString*)sex;

//删除数据
+ (void)deleteWithPerson:(Person *)person;



//删除所有数据

+(void)deleteAllDatas;

//更新数据
+(void)updatePeson:(Person*)peson andkey:(NSString*)key anddata:(NSString*)data;

/**
 *  //条件查询
 *
 *  @param Searchtype 1.为按更新时间   2.按年龄
 *  @param pageSize   2.查询个数
 *  @param age        3.年龄要求
 *  @param Sex        4.性别要求
 *  @param ascending  5.是否升序
 *
 */

+(NSArray*)selectWithType:(NSInteger)Searchtype andpageSize:(NSInteger)pageSize andAge:(NSInteger)age  andSex:(NSInteger)Sex andascending:(BOOL)ascending;


//查询所以人
+(NSArray *)searchPerson;


@end

NS_ASSUME_NONNULL_END
