//
//  ViewController.m
//  LLDrawer
//
//  Created by 刘旭斌 on 2017/4/10.
//  Copyright © 2017年 kodbin. All rights reserved.
//

#import "ViewController.h"
#import "LLDrawer.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet LLDrawer *v2;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"he",@"hr",@"od",@"pj",@"asd",@"sda",@"ads",@"odngrnd", nil];
    
    
    //v1
    LLDrawer *v1 = [[LLDrawer alloc]initWithFrame:CGRectMake(50, 50, 120, 30) itemsArr:arr supView:self.view block:^(NSInteger index) {
        NSLog(@"您选中了第%ld行",index);
    }];
    [self.view addSubview:v1];
    
    //v2
    [_v2 setWithItemsArr:arr supView:self.view block:^(NSInteger index) {
        
        NSLog(@"您xib选中了第%ld行",index);
    }];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
