//
//  MabiTabBarController.m
//  MabinogiHelper
//
//  Created by Joshua on 14/12/29.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import "MabiTabBarController.h"
#import "MabiCommon.h"

@interface MabiTabBarController ()

@end

@implementation MabiTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSUserDefaults standardUserDefaults] setObject:MabiAdItemDefaultRow forKey:MabiPreferenceNumberOfRowsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSString *colorStr = [[NSUserDefaults standardUserDefaults] objectForKey:MabiPreferenceThemeColorKey];
    if (colorStr.length) {
        self.tabBar.tintColor = [UIColor colorFromHexString:colorStr];
    } else {
        self.tabBar.tintColor = [UIColor colorFromHexString:MabiThemeColorPink];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeColorChanged:) name:[MabiParamMap notificationWithThemeChanged] object:nil];
    
}

- (void)themeColorChanged:(NSNotification *)obj
{
    NSString *colorStr = [obj object];
    self.tabBar.tintColor = [UIColor colorWithHexString:colorStr];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[MabiParamMap notificationWithThemeChanged] object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

@end
