//
//  ViewController.m
//  LoopsSrollView
//
//  Created by pingsheng on 15/4/30.
//  Copyright (c) 2015年 pingsheng.zhao. All rights reserved.
//

#import "ViewController.h"
#import "PSScrollView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"轮播图";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:[PSScrollView psScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 150) imagesGroup:@[@"h1", @"h2", @"h3", @"h4"] timeInterval:5 completion:^(NSInteger index) {
        NSLog(@"你点击了弟%ld张图片...    ", index);
    }]];
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
