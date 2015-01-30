//
//  MabiMainTaskViewController.m
//  MabinogiHelper
//
//  Created by Joshua on 14/12/19.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//


#import "MabiMainTaskViewController.h"
#import "MabiTaskCell.h"
#import "MabiStrategyTool.h"
#import "MabiStrategy.h"
#import "MabiMainTaskDetailController.h"

@interface MabiMainTaskViewController() <UIAlertViewDelegate>
@end

@implementation MabiMainTaskViewController
- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self dataInDB:MabiStrategyTypeMainTask]) {
        [self getDataWithType:MabiStrategyTypeMainTask];
    }
}

- (void)refresh
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示(=・ω・=)" message:@"加载数据可能花费较多时间 务必保持耐心_(:3」∠)_" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

#pragma mark - 数据
- (void)getDataWithType:(MabiStrategyType)type
{
    [super getDataWithType:type];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *btnStr = [alertView buttonTitleAtIndex:buttonIndex];
    if ([btnStr isEqualToString:@"确定"]) {
        [self deleteDataFromDBWithType:MabiStrategyTypeMainTask];
        [self getDataWithType:MabiStrategyTypeMainTask];
    } else if ([btnStr isEqualToString:@"取消"]) {
        
    }
}

@end
