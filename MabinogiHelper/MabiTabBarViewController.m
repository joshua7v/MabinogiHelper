//
//  MabiTabBarViewController.m
//  MabinogiHelper
//
//  Created by Joshua on 14/12/12.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import "MabiTabBarViewController.h"
#import "MabiHomeViewController.h"
#import "MabiNavigationViewController.h"
#import "MabiDiscoverController.h"
#import "MabiTabBar.h"
#import "MabiStrategyViewController.h"

@interface MabiTabBarViewController() <MabiTabBarDelegate>
@end

@implementation MabiTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初始化TabBar
    [self setupTabBar];
    
    // 初始化子控制器
    [self setupAllChildViewControllers];
    
}

/**
 *  移除系统tabbar
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

/**
 *  初始化TabBar
 */
- (void)setupTabBar
{
    MabiTabBar *tabBar = [[MabiTabBar alloc] init];
    tabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:tabBar];
    
    self.customTabBar = tabBar;
    
    // 设置TabBar代理
    tabBar.delegate = self;
}

/**
 *  初始化子控制器
 */
- (void)setupAllChildViewControllers
{
    MabiHomeViewController *tab1 = [[MabiHomeViewController alloc] init];
//    tab1.tabBarItem.badgeValue = @"new";
    [self setupChildViewController:tab1 title:@"资讯" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_heighted"];
    
    UIViewController *tab2 = [[UIViewController alloc] init];
//    tab2.tabBarItem.badgeValue = @"999";
    [self setupChildViewController:tab2 title:@"看板" imageName:@"tabbar_watchboard" selectedImageName:@"tabbar_watchboard_heighted"];
    
    MabiDiscoverController *tab3 = [[MabiDiscoverController alloc] init];
//    tab3.tabBarItem.badgeValue = @"999";
    [self setupChildViewController:tab3 title:@"发现" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_heighted"];
    
    MabiStrategyViewController *tab4 = [[MabiStrategyViewController alloc] init];
//    tab4.tabBarItem.badgeValue = @"999";
    [self setupChildViewController:tab4 title:@"攻略" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    
}

/**
 *  初始化一个子控制器
 */
- (void)setupChildViewController:(UIViewController *)childViewController title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 设置子控制器
    childViewController.title = title;
    childViewController.tabBarItem.image = [UIImage imageNamed:imageName];
    childViewController.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    
    // 包装NavigationController
    MabiNavigationViewController *nav = [[MabiNavigationViewController alloc] initWithRootViewController:childViewController];
    
    // 添加到TabBar
    [self addChildViewController:nav];
    
    // 添加按钮到自定义TabBar
    [self.customTabBar addTabBarButtonWithItem:childViewController.tabBarItem];
    
}

#pragma mark - MabiTabBar代理方法
- (void)tabBar:(MabiTabBar *)tabBar didSelectButtonFrom:(NSInteger)from to:(NSInteger)to
{
    self.selectedIndex = to;
}

@end
