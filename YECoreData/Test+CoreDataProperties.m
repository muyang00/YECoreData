//
//  Test+CoreDataProperties.m
//  YECoreData
//
//  Created by yongen on 2017/6/7.
//  Copyright © 2017年 yongen. All rights reserved.
//

#import "Test+CoreDataProperties.h"

@implementation Test (CoreDataProperties)

+ (NSFetchRequest<Test *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Test"];
}

@dynamic score;
@dynamic userinfo;
@dynamic username;

@end
