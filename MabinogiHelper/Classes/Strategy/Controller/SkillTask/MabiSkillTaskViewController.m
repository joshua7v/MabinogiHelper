//
//  MabiSkillTaskViewController.m
//  MabinogiHelper
//
//  Created by Joshua on 14/12/21.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import "MabiSkillTaskViewController.h"
#import "MabiStrategy.h"
#import "MabiStrategyTool.h"

@implementation MabiSkillTaskViewController

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"技能任务";
    
    if ([self dataInDB:MabiStrategyTypeSkillTask]) {
        [self getDataWithType:MabiStrategyTypeSkillTask];
    }
}

#pragma mark - 数据
- (void)getDataWithType:(MabiStrategyType)type
{
    [super getDataWithType:type];
}

- (void)refresh
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示(=・ω・=)" message:@"加载数据可能花费较多时间 务必保持耐心_(:3」∠)_" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *btnStr = [alertView buttonTitleAtIndex:buttonIndex];
    if ([btnStr isEqualToString:@"确定"]) {
        [self deleteDataFromDBWithType:MabiStrategyTypeSkillTask];
        [self getDataWithType:MabiStrategyTypeSkillTask];
    } else if ([btnStr isEqualToString:@"取消"]) {
        
    }
}


@end
