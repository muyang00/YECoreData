//
//  ViewController.m
//  YECoreData
//
//  Created by yongen on 17/3/10.
//  Copyright © 2017年 yongen. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "UserInfoModel.h"
#import "Test+CoreDataProperties.h"

@interface ViewController ()

@property (nonatomic,strong) AppDelegate *app_delegate;

@end

@implementation ViewController
{
      NSInteger curPage;
}

- (AppDelegate *)app_delegate{
    
    if (!_app_delegate) {
       _app_delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    return _app_delegate;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    curPage = 1;
    
    
    NSArray *Arrs = @[@"添加", @"删除", @"修改", @"获取"];
    
    [Arrs enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL *stop){
        [self createClickButtonTitle:obj x: (80 * index) + 20 tag:7777 + index];
    }];
}



- (void)createClickButtonTitle:(NSString *)title x:(CGFloat)x tag: (NSUInteger)tag {
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 160, 44)];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(ClickAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake( x , 120, 60, 30);
    btn.backgroundColor = [UIColor orangeColor];
    btn.tag = tag;
    [self.view addSubview:btn];
}



- (void)ClickAction:(UIButton *)sender{
    switch (sender.tag - 7777) {
        case 0:{
            [self addAction];
            break;
        }
        case 1:{
            [self deleteAction];
            
            break;
        }
        case 2:{
            [self changeAction];
            
            break;
        }
        case 3:{
            [self getAction];
            
            break;
        }
        default:
            break;
    }
}


- (void)addAction {
    
    Test *obj = [NSEntityDescription insertNewObjectForEntityForName:@"Test" inManagedObjectContext:self.app_delegate.managedObjectContext];
    UserInfoModel *model = [[UserInfoModel alloc]init];
    {
        model.age = arc4random() % 31;
        model.sex = arc4random_uniform(20);
        model.address = @"西安市雁塔区长安街88号";
    }
    obj.score = @60;
    obj.username = @"大大";
    obj.userinfo = model;
    [self.app_delegate saveContext];
}

//delete

- (void)deleteAction {
    NSFetchRequest *req = [[NSFetchRequest alloc]initWithEntityName:@"Test"];
    NSArray *objs = [self.app_delegate.managedObjectContext executeFetchRequest:req error:nil];
    
    if (objs.count == 0) {
        NSLog(@"无数据");
        return;
    }
    Test *obj = [objs objectAtIndex:arc4random_uniform((u_int32_t)objs.count)];
    [self.app_delegate.managedObjectContext deleteObject:obj];
    NSLog(@"删除成功");
    [self.app_delegate saveContext];
    
}

- (void)changeAction {
    
    NSFetchRequest *req = [[NSFetchRequest alloc]initWithEntityName:@"Test"];
    
    NSArray *objs = [self.app_delegate.managedObjectContext executeFetchRequest:req error:nil];
    
    if (objs.count == 0) {
        NSLog(@"修改失败 ---> 无数据");
        return;
    }
    
    Test *obj = [objs objectAtIndex:arc4random_uniform((u_int32_t)objs.count)];
    
    obj.username = @"修改数据";      //! < 拿到数据对象后直接赋值操作并保存即可
    UserInfoModel *mod = [obj.userinfo copy];
    mod.address = @"南京市鼓楼区鼓楼地铁站🚇";
    obj.userinfo = mod;
    NSLog(@"修改成功");
    
    [self.app_delegate saveContext];    //! < 持久化到本地
}

//query
- (void)getAction {
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:@"Test"];
    NSSortDescriptor *desc = [NSSortDescriptor sortDescriptorWithKey:@"score" ascending:NO];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"score < %ld", 70];
    
    req.predicate = predicate;
    
    
    /*
     // 分页用到  查找的数量与偏移量
     req.fetchLimit = 4;    //! < 数量                                |      结论:无论查找的数量设置多少,NSFetchRequest
     //                                       | --->   都会遍历所有数据,并且按照事先约定的条件进行
     req.fetchOffset = req.fetchLimit * (curPage - 1); //! < 偏移量   |        处理后输出
     NSLog(@"**********************第%ld页*************************",curPage);
     */
    
    
    req.sortDescriptors = @[desc];
    NSArray *array = [self.app_delegate.managedObjectContext executeFetchRequest:req error:nil];
    
#pragma 模型内的数据可以采用数组的条件过滤操作， 然而当进行此步骤的操作时，分页效果完全乱了
    NSPredicate *array_predicate = [NSPredicate predicateWithFormat:@"userinfo.age < %ld", 20];
    array = [array filteredArrayUsingPredicate:array_predicate];
    
    if (array.count == 0) {
        NSLog(@"无数据**************************");
        return;
    }
    
    curPage ++;
    
    
    for (Test *obj in array) {
        UserInfoModel *model = obj.userinfo;
        NSLog(@"obj.username : %@ | model.age : %ld | score : %ld | sex : %@ | %@", obj.username, (long)model.age, [obj.score integerValue], model.sex ? @"男" : @"女", model.address);
        
    }
}

@end
