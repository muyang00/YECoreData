//
//  Test+CoreDataProperties.h
//  YECoreData
//
//  Created by yongen on 2017/6/7.
//  Copyright © 2017年 yongen. All rights reserved.
//

#import "Test+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Test (CoreDataProperties)

+ (NSFetchRequest<Test *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *score;
@property (nullable, nonatomic, retain) NSObject *userinfo;
@property (nullable, nonatomic, copy) NSString *username;

@end

NS_ASSUME_NONNULL_END
