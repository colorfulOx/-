//
//  ViewController.m
//  全屏右滑手势
//
//  Created by lirenqiang on 16/7/6.
//  Copyright © 2016年 lirenqiang. All rights reserved.
//

#import "ViewController.h"
#import "MSLObjcEx.h"
#import "Person.h"
#import <objc/runtime.h>
#import "UINavigationController+MSLEx.h"

@interface ViewController () <UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Person * p = [[Person alloc] init];
    
    [p run];
    [p eat];
//    [MSLObjcEx msl_logIvars:[UIGestureRecognizer class]];
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
