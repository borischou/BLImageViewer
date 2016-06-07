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
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 100, 30)];
    [button setTitle:@"网络图片" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *localButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 50+30+50, 100, 30)];
    [localButton setTitle:@"本地图片" forState:UIControlStateNormal];
    [localButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [localButton setBackgroundColor:[UIColor redColor]];
    [localButton addTarget:self action:@selector(localButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:localButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)buttonPressed:(UIButton *)sender
{
    NSArray *urls = @[
                      @"http://img1.gtimg.com/sports/pics/hv1/157/174/2080/135296527.jpg",
                      @"http://cms-origin-cn.battle.net/cms/blog_header/vm/VM2GBUX3YRDO1446721233284.jpg"
                      ];
    _iv = [[BLImageViewer alloc] initWithFrame:[UIScreen mainScreen].bounds URLs:urls index:0];
    [_iv present];
}

-(void)localButtonPressed:(UIButton *)sender
{
    NSArray *images = @[
                        [UIImage imageNamed:@"pic.jpg"],
                        [UIImage imageNamed:@"pic2.jpg"]
                        ];
    _iv = [[BLImageViewer alloc] initWithFrame:[UIScreen mainScreen].bounds images:images index:0];
    [_iv present];
}

@end
