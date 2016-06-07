//
//  Utils.m
//  BankwelLiuxue
//
//  Created by Zhouboli on 15/12/11.
//  Copyright © 2015年 bankwel. All rights reserved.
//

#import "BLPopNote.h"
#import "AppDelegate.h"
#import <UIKit/UIKit.h>

#define dispatch_async_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

#define bWidth [UIScreen mainScreen].bounds.size.width
#define statusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height
#define KbackBlue [UIColor colorWithRed:0/255.0 green:147/255.0 blue:232/255.0 alpha:1]
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kNavigationBarHeight 64

@interface BLPopView : UIView

@property (strong, nonatomic) UILabel *noteLabel;

@property (strong, nonatomic) UIColor *txtColor;
@property (strong, nonatomic) UIColor *bgColor;

-(instancetype)initWithNote:(NSString *)text;
+(instancetype)sharedViewWithNote:(NSString *)note;

@end

@implementation BLPopView

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setFrame:CGRectMake(0, -statusBarHeight*2, bWidth, statusBarHeight*2)];
        [self setupShadow];
        [self setupPopView];
    }
    return self;
}

-(instancetype)initWithNote:(NSString *)text
{
    self = [super init];
    if (self)
    {
        [self setFrame:CGRectMake(0, -statusBarHeight*2, bWidth, statusBarHeight*2)];
        [self setupShadow];
        [self setupNote:text];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popViewTapped) name:@"removeNotificationAnimations" object:nil];
    }
    return self;
}

+(instancetype)sharedViewWithNote:(NSString *)note
{
    static dispatch_once_t onceToken;
    static BLPopView *popView;
    dispatch_once(&onceToken, ^{
        popView = [[BLPopView alloc] initWithNote:note];
    });
    return popView;
}

-(void)setupShadow
{
    self.alpha = 0.75;
    self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 1.0);
    self.layer.shadowRadius = 2.0;
    self.layer.shadowOpacity = 0.9;
}

-(void)setupPopView
{
    self.backgroundColor = _bgColor ? _bgColor : KbackBlue;
    
    _noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, statusBarHeight, bWidth, statusBarHeight)];
    _noteLabel.textAlignment = NSTextAlignmentCenter;
    _noteLabel.numberOfLines = 1;
    _noteLabel.font = [UIFont systemFontOfSize:12.0];
    _noteLabel.textColor = _txtColor ? _txtColor : [UIColor whiteColor];
    _noteLabel.userInteractionEnabled=YES;
    [self addSubview:_noteLabel];
}

-(void)setupNote:(NSString *)text
{
    [self setupPopView];
    _noteLabel.text = text;
}
-(void)popViewTapped
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^{
        self.frame = CGRectMake(0, -2*statusBarHeight, kScreenWidth, 0);
        _noteLabel.frame = CGRectMake(0, -2*statusBarHeight, kScreenWidth, 0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end

@implementation BLPopNote

+(void)popNoteOnMainThread:(NSString *)text
{
    dispatch_async_main_safe(^{
        [self popNote:text];
    });
}

+(void)popNote:(NSString *)text
{
    BLPopView *popView = [[BLPopView alloc] initWithNote:text];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:popView];
    [window bringSubviewToFront:popView];
  
    UIView *gestureReceiveView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavigationBarHeight+20)];
    gestureReceiveView.backgroundColor = [UIColor clearColor];
    [window addSubview:gestureReceiveView];
    [window bringSubviewToFront:gestureReceiveView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popViewTapped:)];
    [gestureReceiveView addGestureRecognizer:tap];
    
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [popView setFrame:CGRectMake(0, 0, kScreenWidth, 2*statusBarHeight)];
    }
    completion:^(BOOL finished)
    {
        [UIView animateWithDuration:0.2 delay:2.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [popView setFrame:CGRectMake(0, -2*statusBarHeight, kScreenWidth, 2*statusBarHeight)];
        }
        completion:^(BOOL finished)
        {
            [popView removeFromSuperview];
            [gestureReceiveView removeFromSuperview];
        }];
    }];
  
}

+(void)popViewTapped:(UITapGestureRecognizer *)tap
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"removeNotificationAnimations" object:nil];
}

@end
