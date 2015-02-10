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
#import "MabiColorCodeSearchController.h"

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
//    group.footer = @"搜索游戏广告版";
    MabiSettingArrowItem *adBoard = [MabiSettingArrowItem itemWithTitle:@"房屋广告版搜索" destVcClass:[MabiAdBoardController class]];
    MabiSettingArrowItem *colorCodeSearch = [MabiSettingArrowItem itemWithTitle:@"颜色代码搜索" destVcClass:[MabiColorCodeSearchController class]];
    group.items = @[adBoard, colorCodeSearch];
}

@end
