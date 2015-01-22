//
//  MabiDiscoverController.m
//  MabinogiHelper
//
//  Created by Joshua on 14/12/15.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import "MabiDiscoverController.h"
#import "MabiSettingArrowItem.h"
#import "MabiSettingGroup.h"
#import "MabiAdBoardController.h"

@interface MabiDiscoverController ()

@end

@implementation MabiDiscoverController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupGroup0];
}

- (void)setupGroup0
{
    MabiSettingGroup *group = [self addGroup];
    group.header = @"实用功能";
    group.footer = @"搜索游戏广告版";
    MabiSettingArrowItem *adBoard = [MabiSettingArrowItem itemWithTitle:@"房屋广告版搜索" destVcClass:[MabiAdBoardController class]];
    group.items = @[adBoard];
}

@end
