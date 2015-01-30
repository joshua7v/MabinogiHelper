//
//  MabiStrategyViewController.m
//  MabinogiHelper
//
//  Created by Joshua on 14/12/30.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import "MabiStrategyViewController.h"
#import "MabiSettingGroup.h"
#import "MabiSettingArrowItem.h"
#import "MabiMainTaskViewController.h"
#import "MabiSkillTaskViewController.h"
#import "MabiCampaignTaskViewController.h"
#import "MabiOtherTaskViewController.h"

@interface MabiStrategyViewController ()

@end

@implementation MabiStrategyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupGroup0];
}

- (void)setupGroup0
{
    MabiSettingGroup *group = [self addGroup];
    group.header = @"官方攻略";
    group.footer = @"来自官方网站的所有攻略";
    MabiSettingArrowItem *mainTask = [MabiSettingArrowItem itemWithTitle:@"主线任务" destVcClass:[MabiMainTaskViewController class]];
    MabiSettingArrowItem *skillTask = [MabiSettingArrowItem itemWithTitle:@"技能任务" destVcClass:[MabiSkillTaskViewController class]];
    MabiSettingArrowItem *campaignTask = [MabiSettingArrowItem itemWithTitle:@"活动任务" destVcClass:[MabiCampaignTaskViewController class]];
    MabiSettingArrowItem *otherTask = [MabiSettingArrowItem itemWithTitle:@"其他任务" destVcClass:[MabiOtherTaskViewController class]];
    group.items = @[mainTask, skillTask, campaignTask, otherTask];
}

@end
