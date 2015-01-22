//
//  MabiNavigationViewController.m
//  MabinogiHelper
//
//  Created by Joshua on 14/12/12.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import "MabiNavigationViewController.h"
#import "MabiCommon.h"

@interface MabiNavigationViewController ()

@end

@implementation MabiNavigationViewController
- (void)awakeFromNib
{
//    self.navigationBar.backgroundColor = [UIColor colorFromHexString:@"FC9D9A"];
//    self.navigationBar.tintColor = [UIColor colorFromHexString:@"FC9D9A"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *colorStr = [[NSUserDefaults standardUserDefaults] objectForKey:MabiPreferenceThemeColorKey];
    if (colorStr.length) {
        self.navigationBar.barTintColor = [UIColor colorFromHexString:colorStr];
    } else {
        self.navigationBar.barTintColor = [UIColor colorFromHexString:MabiThemeColorPink];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeColorChanged:) name:[MabiParamMap notificationWithThemeChanged] object:nil];
}

- (void)themeColorChanged:(NSNotification *)obj
{
    NSString *colorStr = [obj object];
    self.navigationBar.barTintColor = [UIColor colorWithHexString:colorStr];
    
    [self popToRootViewControllerAnimated:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[MabiParamMap notificationWithThemeChanged] object:nil];
}

+ (void)initialize
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // 设置导航栏主题
    [self setupNavBarTheme];
    
    // 设置导航栏按钮主题
    [self setupBarButtonItemTheme];
}

/**
 *  设置导航栏按钮主题
 */
+ (void)setupBarButtonItemTheme
{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // 设置背景
//    [item setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [item setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_pushed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
//    [item setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_disable"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
    
    
    // 设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    NSShadow *textShadow = [[NSShadow alloc] init];
    textShadow.shadowOffset = CGSizeZero;
    textAttrs[NSShadowAttributeName] = textShadow;
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateHighlighted];
    
}

/**
 *  设置导航栏主题
 */
+ (void)setupNavBarTheme
{
    // 取出appearence
    UINavigationBar *navgationBar = [UINavigationBar appearance];
    navgationBar.tintColor = [UIColor whiteColor];
    
    // 设置背景
//    [navgationBar setBackgroundImage:[UIImage imageNamed:@"home_nav_bg"] forBarMetrics:UIBarMetricsDefault];
    
    // 设置标题
    NSMutableDictionary *textAttributes = [NSMutableDictionary dictionary];
    textAttributes[NSFontAttributeName] = [UIFont boldSystemFontOfSize:19];
    textAttributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
    //    NSShadow *textShadow = [[NSShadow alloc] init];
    //    textShadow.shadowOffset = CGSizeZero;
    //    textAttributes[NSShadowAttributeName] = textShadow;
    [navgationBar setTitleTextAttributes:textAttributes];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
