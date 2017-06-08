//
//  AddViewController.m
//  YECoreData
//
//  Created by yongen on 2017/6/8.
//  Copyright © 2017年 yongen. All rights reserved.
//

#import "AddViewController.h"
#import "Person+CoreDataProperties.h"

@interface AddViewController ()
{
    __weak IBOutlet UITextField *nameTF;
    __weak IBOutlet UITextField *ageTF;
    __weak IBOutlet UISegmentedControl *segment;
    NSString *sex;
}

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [segment addTarget:self action:@selector(segmentAction:)forControlEvents:UIControlEventValueChanged];
    
    if (self.type == addType) {
        
        sex = @"男";
        
    }else{
        
        sex = self.sexType;
        
        if ([self.sexType isEqualToString:@"男"]) {
            
            [segment setSelectedSegmentIndex:0];
        }else{
            
            
            [segment setSelectedSegmentIndex:1];
            
        }
        
        nameTF.text = self.name;
        
        ageTF.text = [NSString stringWithFormat:@"%ld",self.age];
        
    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
    
}


-(void)segmentAction:(UISegmentedControl *)Seg
{
    NSInteger index=Seg.selectedSegmentIndex;
    
    
    switch (index) {
        case 0:
        {
            
            sex = @"男";
        }
            
            break;
        case 1:
        {
            
            sex = @"女";
            
        }
            break;
            
        default:
            break;
    }
    
}


- (IBAction)saveAction:(UIButton *)sender {
    
    if (nameTF.text.length==0||ageTF.text.length==0) {
        
        
        return;
        
    }
    
    NSDate *today = [NSDate date];
    
    //插入数据库
    [Person insertPersonname:nameTF.text andage:[ageTF.text integerValue] andupdate:today andsex:sex];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
