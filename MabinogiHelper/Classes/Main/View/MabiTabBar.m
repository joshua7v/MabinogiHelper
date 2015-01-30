//
//  MabiTabBar.m
//  MabinogiHelper
//
//  Created by Joshua on 14/12/12.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//


#import "MabiTabBar.h"
#import "MabiTabBarButton.h"
#import "UIColor+Seraph.h"

@interface MabiTabBar()
@property (nonatomic, weak) MabiTabBarButton *selectedButton;

@end

@implementation MabiTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    // 新建按钮
    MabiTabBarButton *tabBarButton = [[MabiTabBarButton alloc] init];
    [self addSubview:tabBarButton];
    
    // 设置按钮
    tabBarButton.item = item;
    
    // 监听按钮
    [tabBarButton addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchDown];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat buttonW = self.frame.size.width / self.subviews.count;
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    
    for (int index = 0; index < self.subviews.count; index++) {
        // 取出按钮
        MabiTabBarButton *button = self.subviews[index];
        
        // 设置frame
        buttonX = buttonW * index;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 绑定Tag
        button.tag = index;
    }
}

- (void)tabBarButtonClicked:(MabiTabBarButton *)tabBarButton
{
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectButtonFrom:self.selectedButton.tag to:tabBarButton.tag];
    }
    
    // 设置按钮状态
    self.selectedButton.selected = NO;
    tabBarButton.selected = YES;
    self.selectedButton = tabBarButton;
}
@end
