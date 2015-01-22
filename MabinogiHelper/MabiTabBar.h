//
//  MabiTabBar.h
//  MabinogiHelper
//
//  Created by Joshua on 14/12/12.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MabiTabBar;

@protocol MabiTabBarDelegate <NSObject>

@optional
- (void)tabBar:(MabiTabBar *)tabBar didSelectButtonFrom:(NSInteger)from to:(NSInteger)to;

@end

@interface MabiTabBar : UIView
@property (nonatomic, weak) id<MabiTabBarDelegate> delegate;

- (void)addTabBarButtonWithItem:(UITabBarItem *)item;
@end
