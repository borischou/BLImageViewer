//
//  BBImageBrowserView.h
//  Bobo
//
//  Created by Zhouboli on 15/6/25.
//  Copyright (c) 2015年 Zhouboli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLImageViewer : UIView

-(instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images index:(NSInteger)index;

-(instancetype)initWithFrame:(CGRect)frame URLs:(NSArray *)urls index:(NSInteger)index;

-(void)present;

@end
