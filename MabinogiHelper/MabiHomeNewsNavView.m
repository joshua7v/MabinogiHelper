//
//  MabiHomeNewsNavView.m
//  MabinogiHelper
//
//  Created by Joshua on 14/12/11.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import "MabiHomeNewsNavView.h"
#import "MabiHomeNewsNavViewButton.h"

@interface MabiHomeNewsNavView()

@end

@implementation MabiHomeNewsNavView

- (void)awakeFromNib
{
    // 添加所有新闻按钮
    MabiHomeNewsNavViewButton *newsAllBtn = self.subviews[0];
    [newsAllBtn setImage:[UIImage imageNamed:@"home_news_nav_all"] forState:UIControlStateNormal];
    [newsAllBtn setTitle:@"所有" forState:UIControlStateNormal];
    // 添加游戏新闻按钮
    MabiHomeNewsNavViewButton *newsGameBtn = self.subviews[1];
    [newsGameBtn setImage:[UIImage imageNamed:@"home_news_nav_game"] forState:UIControlStateNormal];
    [newsGameBtn setTitle:@"游戏" forState:UIControlStateNormal];
    // 添加活动新闻按钮
    MabiHomeNewsNavViewButton *newsCampaignBtn = self.subviews[2];
    [newsCampaignBtn setImage:[UIImage imageNamed:@"home_news_nav_campaign"] forState:UIControlStateNormal];
    [newsCampaignBtn setTitle:@"活动" forState:UIControlStateNormal];
    // 添加系统新闻按钮
    MabiHomeNewsNavViewButton *newsSystemBtn = self.subviews[3];
    [newsSystemBtn setImage:[UIImage imageNamed:@"home_news_nav_system"] forState:UIControlStateNormal];
    [newsSystemBtn setTitle:@"系统" forState:UIControlStateNormal];
}

@end
