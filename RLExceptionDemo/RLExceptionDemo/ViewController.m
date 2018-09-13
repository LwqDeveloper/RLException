//
//  ViewController.m
//  RLException
//
//  Created by 李韦琼(Weiqiong Li)-顺丰科技 on 2018/9/13.
//  Copyright © 2018年 李韦琼(Weiqiong Li)-顺丰科技. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 100);
    [button setTitle:@"click" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonTap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonTap
{
    NSObject *object = nil;
    NSArray *array = @[@"0", @"1", @"2"];
    NSLog(@"%@",array[0]);
    NSLog(@"%@",array[1]);
    NSLog(@"%@",array[2]);
    NSLog(@"%@",array[3]);
    
    //    NSMutableArray *mulArray = [NSMutableArray arrayWithArray:array];
    //    NSArray *mulArray0 = [[NSArray alloc] init];
    //    NSMutableArray *mulArray1 = [[NSMutableArray alloc] init];
    ////    [mulArray removeObjectAtIndex:2];
    //    [mulArray removeObjectAtIndex:2];
    //    [mulArray replaceObjectAtIndex:3 withObject:object];
    //    NSLog(@"%@",mulArray);
    
    //    NSObject *object = nil;
    //    NSArray *array0 = [[NSArray alloc] init];
    //    NSLog(@"%@",array0[1]);
    //    NSArray *array = @[@"0"];
    //    NSInteger index = [array indexOfObject:object];
    //    NSMutableArray *mulArray = [[NSMutableArray alloc] initWithObjects:nil count:2];
    //    NSLog(@"%@", mulArray);
    //    [mulArray replaceObjectAtIndex:1 withObject:object];
    //    [mulArray addObject:object];
    //    NSMutableArray *mulArray0 = [[NSMutableArray alloc] initWithObjects:@"0", nil];
    //    [mulArray addObjectsFromArray:mulArray0];
    //    NSLog(@"%@",mulArray[3]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
