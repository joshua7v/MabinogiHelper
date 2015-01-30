//
//  MabiThemeController.m
//  MabinogiHelper
//
//  Created by Joshua on 15/1/5.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import "MabiThemeController.h"
#import "MabiSettingGroup.h"
#import "MabiSettingArrowItem.h"
#import "MabiCommon.h"

@interface MabiThemeController ()

@end

@implementation MabiThemeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"主题设置";
    
    [self setupGroup0];
}

- (void)setupGroup0
{
    MabiSettingGroup *group = [self addGroup];
    group.header = @"主题颜色";
//    group.footer = @"根据喜好调整显示";
    MabiSettingArrowItem *pink = [MabiSettingArrowItem itemWithTitle:@"粉色" destVcClass:nil];
    MabiSettingArrowItem *blue = [MabiSettingArrowItem itemWithTitle:@"蓝色" destVcClass:nil];
    
    pink.operation = ^() {
        [[NSNotificationCenter defaultCenter] postNotificationName:[MabiParamMap notificationWithThemeChanged] object:MabiThemeColorPink];
        [[NSUserDefaults standardUserDefaults] setObject:MabiThemeColorPink forKey:MabiPreferenceThemeColorKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    };
    
    blue.operation = ^() {
        [[NSNotificationCenter defaultCenter] postNotificationName:[MabiParamMap notificationWithThemeChanged] object:MabiThemeColorBlue];
        [[NSUserDefaults standardUserDefaults] setObject:MabiThemeColorBlue forKey:MabiPreferenceThemeColorKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    };
    
    group.items = @[pink, blue];
}

@end
