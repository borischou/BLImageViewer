//
//  ViewController.m
//  BLImageViewer
//
//  Created by Zhouboli on 16/6/7.
//  Copyright © 2016年 boris. All rights reserved.
//

#import "ViewController.h"
#import "BLImageViewer.h"

@interface ViewController ()

@property (strong, nonnull) BLImageViewer *iv;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blueColor];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 100, 30)];
    [button setBackgroundColor:[UIColor redColor]];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    NSArray *urls = @[
                      @"http://img1.gtimg.com/sports/pics/hv1/157/174/2080/135296527.jpg",
                      @"http://cms-origin-cn.battle.net/cms/blog_header/vm/VM2GBUX3YRDO1446721233284.jpg"
                      ];
    
    _iv = [[BLImageViewer alloc] initWithFrame:[UIScreen mainScreen].bounds URLs:urls index:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)buttonPressed:(UIButton *)sender
{
    [_iv present];
}

@end
