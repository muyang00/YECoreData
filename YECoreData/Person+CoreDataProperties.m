//
//  Person+CoreDataProperties.m
//  YECoreData
//
//  Created by yongen on 17/3/10.
//  Copyright © 2017年 yongen. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Person+CoreDataProperties.h"
#import "AppDelegate.h"

@implementation Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Person"];
}

@dynamic age;
@dynamic name;
@dynamic sex;
@dynamic updatedate;

+ (BOOL)insertPersonname:(NSString *)name andage:(NSInteger)age andupdate:(NSDate *)update andsex:(NSString *)sex{
    
    Person *Insertperson=[NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:kCoreDataContext];
    
    Insertperson.name=name;
    
    Insertperson.age= [NSNumber numberWithInteger:age];
    
    Insertperson.updatedate=update;
    
    Insertperson.sex=sex;

    //保存
    NSError *error;
    [kCoreDataContext save:&error];
    if (error == nil) {
        return YES;
    }
    return NO;
}

+ (NSArray *)selectWithType:(NSInteger)searchtype andpageSize:(NSInteger)pagesize andAge:(NSInteger)age andsex:(NSInteger)sex andascending:(BOOL)ascending{
    //创建查询请求对象
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];

    switch (searchtype) {
        case 1:{
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"updatedate" ascending:ascending];
            NSArray *sortDesciptors = [NSArray arrayWithObject:sort];
            [request setSortDescriptors:sortDesciptors];
            
            break;
        }
        case 2:{
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:ascending];
            NSArray *sortDesciptors = [NSArray arrayWithObject:sort];
            [request setSortDescriptors:sortDesciptors];
            break;
        }
        default:
            break;
    }
    if (pagesize != 0) {
        [request setFetchLimit:pagesize];
    }
    [request setFetchOffset:0];
    NSString *sexStr;
    if (sex == 1) {
        sexStr = @"男";
    }else{
        sexStr = @"女";
    }
    //根据年龄和性别
    if (age == 1) {
        request.predicate = [NSPredicate predicateWithFormat:@"sex=%@", sexStr];
    }else{
        request.predicate = [NSPredicate predicateWithFormat:@"sex=%@ AND age<=%d", sexStr, 20];
    }
    NSError *error;
    NSArray *arr = [kCoreDataContext executeFetchRequest:request error:&error];
    if (error == nil) {
        return  arr;
    }
    return nil;
}

+ (NSArray *)searchPerson{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    NSError *error;
    NSArray *arr = [kCoreDataContext executeFetchRequest:request error:&error];
    if (error == nil) {
        return arr;
    }
    return nil;
}

//更新数据
+ (void)updatePerson:(Person *)person andkey:(NSString *)key anddata:(NSString *)data{
    //先查出数据，然后再更新
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    //添加查询条件
    request.predicate = [NSPredicate predicateWithFormat:@"name=%@", person.name];
    //执行条件
    NSArray *arr = [kCoreDataContext executeFetchRequest:request error:nil];
    if ([key isEqualToString:@"name"]) {
        for (Person  *p in arr) {
            p.name = data;
        }
    }else if ([key isEqualToString:@"age"]){
        for (Person *p in arr) {
            p.age = @([data integerValue]);
        }
    }else{
        for (Person *p in arr) {
            p.sex = data;
        }
    }
    [kCoreDataContext save:nil];
}

//删除数据
+ (void)deleteWithPerson:(Person *)person{
    [kCoreDataContext deleteObject:person];
    [kCoreDataContext save:nil];
}

+ (void)deleteAllDatas{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    NSArray *arr = [kCoreDataContext executeFetchRequest:request error:nil];
//    for (<#initialization#>; <#condition#>; <#increment#>) {
//        <#statements#>
//    }
}

@end
