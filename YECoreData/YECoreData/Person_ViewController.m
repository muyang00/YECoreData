//
//  Person_ViewController.m
//  YECoreData
//
//  Created by yongen on 2017/6/7.
//  Copyright © 2017年 yongen. All rights reserved.
//

#import "Person_ViewController.h"
#import "AddViewController.h"
#import "Person+CoreDataProperties.h"
#import "Person+CoreDataClass.h"
#import "PerTableViewCell.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface Person_ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView*perinforTableView;
@property(nonatomic,strong)NSMutableArray *persArr;
@property(nonatomic,strong)UISegmentedControl *sortType;//排序选择
@property(nonatomic,strong)UISegmentedControl*acsendingType;//升序还是降序
@property(nonatomic,strong)UISegmentedControl *ageType;//条件
@property(nonatomic,strong)UISegmentedControl *sexType;//性别
@property(nonatomic,assign)NSInteger searchType;//1.按年龄   2.按更新时间
@property(nonatomic,assign)NSInteger searchAge;//不限，小于为0
@property(nonatomic,assign)NSInteger searchSex;//男为1，女为0
@property(nonatomic,assign)BOOL searchascending;//1为升序， 0为降序

@end

@implementation Person_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"人员信息";
    
    self.searchType=1;
    
    self.searchAge=1;
    
    self.searchSex=1;
    
    self.searchascending=YES;
    
    [self creatNavBar];
    
    [self.view addSubview:self.perinforTableView];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self requestData];//读取数据
}


#pragma-mark-设置导航栏
-(void)creatNavBar {
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addperson:)];
    
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithTitle:@"清空" style:UIBarButtonItemStyleDone target:self action:@selector(ClearAll:)];
    
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    [self.navigationItem setLeftBarButtonItem:leftButton];
    
}

#pragma mark-查询数据
-(void)requestData
{
    //排序规则   1.按钮时间，2按年龄 3.默认
    // 升序，降序,查询个数
    //年龄条件 ,性别要求
    
    [self.persArr removeAllObjects];
    
    NSArray *arr =  [Person selectWithType:self.searchType andpageSize:10 andAge:self.searchAge andSex:self.searchSex andascending:self.searchascending];
    
    [self.persArr addObjectsFromArray:arr];
    
    [self.perinforTableView reloadData];
}

#pragma mark-增加人员
-(void)addperson:(UIButton*)sender
{
    AddViewController *add=[AddViewController new];
    
    add.type= addType;
    
    [self.navigationController pushViewController:add animated:YES];
    
}

#pragma mark-清除所有数据

-(void)ClearAll:(UIButton*)sender
{
    [Person deleteAllDatas];
    
    [self requestData];
    
}

#pragma mark-懒加载


-(UITableView*)perinforTableView
{
    if (!_perinforTableView) {
        
        _perinforTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth , kScreenHeight) style:UITableViewStylePlain];
        
        _perinforTableView.delegate=self;
        
        _perinforTableView.dataSource=self;
        
        [_perinforTableView registerNib:[UINib nibWithNibName:@"PerTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        
        _perinforTableView.backgroundColor = [UIColor whiteColor];
        
        UIView *tableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        
        _perinforTableView.tableHeaderView=tableHeadView;
        
        tableHeadView.backgroundColor=[UIColor groupTableViewBackgroundColor];
        //创建4个seg
        NSArray *sortArr=[NSArray arrayWithObjects:@"时间排序",@"年龄排序", nil];
        
        self.sortType=[[UISegmentedControl alloc]initWithItems:sortArr];
        
        self.sortType.frame = CGRectMake(10, 10, kScreenWidth/2.0-20, 30);
        
        self.sortType.tag=1000;
        
        self.sortType.selectedSegmentIndex=0;
        
        [self.sortType addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventValueChanged];
        
        [tableHeadView addSubview:self.sortType];
        
        NSArray *ascArr=[NSArray arrayWithObjects:@"升序",@"降序", nil];
        
        self.acsendingType = [[UISegmentedControl alloc]initWithItems:ascArr];
        
        self.acsendingType.frame = CGRectMake(kScreenWidth/2.0+10, 10, kScreenWidth/2.0-20, 30);
        
        self.acsendingType.selectedSegmentIndex=0;
        
        self.acsendingType.tag=1001;
        
        [self.acsendingType addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventValueChanged];
        
        [tableHeadView addSubview:self.acsendingType];
        
        NSArray *ageArr=[NSArray arrayWithObjects:@"年龄不限",@"年龄<=20", nil];
        
        self.ageType=[[UISegmentedControl alloc]initWithItems:ageArr];
        
        self.ageType.frame=CGRectMake(10, 50, kScreenWidth/2.0-20, 30);
        
        self.ageType.selectedSegmentIndex=0;
        
        self.ageType.tag=1002;
        
        [self.ageType addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventValueChanged];
        
        [tableHeadView addSubview:self.ageType];
        
        
        NSArray *sexArr=[NSArray arrayWithObjects:@"男",@"女", nil];
        
        
        self.sexType=[[UISegmentedControl alloc]initWithItems:sexArr];
        
        self.sexType.tag=1003;
        
        self.sexType.frame=CGRectMake(kScreenWidth/2.0+10, 50, kScreenWidth/2.0-20, 30);
        
        [self.sexType addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventValueChanged];
        
        self.sexType.selectedSegmentIndex = 0;
        
        [tableHeadView addSubview:self.sexType];
        
    }
    
    return _perinforTableView;
    
}


- (NSMutableArray *)persArr {
    if (!_persArr) {
        
        _persArr=[NSMutableArray array];
    }
    return _persArr;
}


#pragma mark --- UITableViewDelegate, UITableViewDataSource


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.persArr.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PerTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    Person *person = self.persArr[indexPath.row];
    
    
   cell.infoLabel.text=[NSString stringWithFormat:@"%@  %@  %@",person.name,person.age,person.sex];
    
    __block Person_ViewController *weakself = self;
    cell.deleteblock = ^(UITableViewCell*delcell){
        
        NSIndexPath *index=[weakself.perinforTableView indexPathForCell:delcell];
        
        [weakself delPersonWithrow:index.row];
        
    };
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AddViewController *add = [AddViewController new];
    
    Person *pe = self.persArr[indexPath.row];
    
    add.name = pe.name;
    
    add.age = [pe.age integerValue];
    
    add.sexType = pe.sex;
    
    add.type = updateType;
    
    [self.navigationController pushViewController:add animated:YES];
    
}


#pragma mark-删除

-(void)delPersonWithrow:(NSInteger)row {
    
    Person *per = self.persArr[row];
    
    [Person deleteWithPerson:per];
    
    [self requestData];
    
}


#pragma mark-seg点击事件


-(void)selectAction:(UISegmentedControl*)seg
{
    NSInteger index=seg.selectedSegmentIndex;
    switch (seg.tag) {
        case 1000:
            
        {
            if (index==0) {
                
                self.searchType=1;
                
            }else{
                
                self.searchType=2;
                
            }
            
        }
            
            break;
        case 1001:
            
            if (index==0) {
                
                self.searchascending=YES;
                
                
            }else{
                
                self.searchascending=NO;
                
            }
            
            break;
            
        case 1002:
            
            if (index==0) {
                
                
                self.searchAge=1;
                
            }else{
                
                self.searchAge=0;
                
            }
            
            break;
            
        case 1003:
            
            if (index==0) {
                
                self.searchSex=1;
                
                
            }else{
                
                self.searchSex=0;
                
            }
            
            break;
            
        default:
            break;
    }
    [self requestData];
    
}

@end
