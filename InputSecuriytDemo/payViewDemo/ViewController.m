//
//  ViewController.m
//  payViewDemo
//
//  Created by Alex cai on 15/5/12.
//  Copyright (c) 2015年 Alex cai. All rights reserved.
//

#import "ViewController.h"
#import "InputSecurityView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect rect = CGRectMake(30, 100, 200, 40);
    InputSecurityView *input = [[InputSecurityView alloc]initWithFrame:rect];
    [self.view addSubview:input];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
