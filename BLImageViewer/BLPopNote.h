//
//  Utils.h
//  BankwelLiuxue
//
//  Created by Zhouboli on 15/12/11.
//  Copyright © 2015年 bankwel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BLPopNote : NSObject

+(void)popNote:(NSString *)text;
+(void)popNoteOnMainThread:(NSString *)text;

@property (strong, nonatomic) UIColor *txtColor;
@property (strong, nonatomic) UIColor *bgColor;

@end
