//
//  MabiSettingController.m
//  MabinogiHelper
//
//  Created by Joshua on 14/12/30.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import "MabiSettingController.h"
#import "MabiSettingGroup.h"
#import "MabiSettingArrowItem.h"
#import "MabiSettingViewController.h"
#import "MabiThemeController.h"
#import "MabiAboutViewController.h"

@interface MabiSettingController ()
@end


@implementation MabiSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
//    self.tableView.contentInset = UIEdgeInsetsMake(SeraphTableViewEdgeMargin, 0, 0, 0);
    
    [self setupGroup0];
    [self setupGroup1];
}

- (void)setupGroup0
{
    MabiSettingGroup *group = [self addGroup];
    group.header = @"偏好设置";
//    group.footer = @"根据喜好调整显示";
    MabiSettingArrowItem *theme = [MabiSettingArrowItem itemWithTitle:@"主题颜色" destVcClass:[MabiThemeController class]];
    group.items = @[theme];
}

- (void)setupGroup1
{
    MabiSettingGroup *group = [self addGroup];
//    group.header = @"数据相关";
//    group.footer = @"清除数据缓存 包括资讯、攻略的缓存数据";
//    MabiSettingArrowItem *cache = [MabiSettingArrowItem itemWithTitle:@"清除缓存" destVcClass:[MabiSettingViewController class]];
    group.header = @"关于";
    MabiSettingArrowItem *about = [MabiSettingArrowItem itemWithTitle:@"关于洛奇助手" destVcClass:[MabiAboutViewController class]];
    group.items = @[about];
}

@end
