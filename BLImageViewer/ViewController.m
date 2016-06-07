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
    _iv = [[BLImageViewer alloc] initWithFrame:[UIScreen mainScreen].bounds images:@[[UIImage imageNamed:@"pic.jpg"], [UIImage imageNamed:@"pic2.jpg"]] index:0];
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
