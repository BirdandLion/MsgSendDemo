//
//  ViewController.m
//  MsgSendDemo
//
//  Created by Kelvin on 2017/6/10.
//  Copyright © 2017年 Kelvin. All rights reserved.
//

#import "ViewController.h"
#import "Teacher.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    Teacher *p = [[Teacher alloc] init];
    
    [p playPiano];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
