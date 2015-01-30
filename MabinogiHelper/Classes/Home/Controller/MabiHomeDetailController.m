//
//  MabiHomeDetailController.m
//  MabinogiHelper
//
//  Created by Joshua on 14/12/12.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import "MabiHomeDetailController.h"
#import "MabiHomeNewsItem.h"
#import "MabiTabBarViewController.h"
#import "MabiTabBar.h"

@interface MabiHomeDetailController ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation MabiHomeDetailController

- (void)setCurrentitem:(MabiHomeNewsItem *)currentitem
{
    _currentitem = currentitem;
}

- (void)awakeFromNib
{
    self.view.backgroundColor = SeraphColor(242, 242, 242);
    self.title = @"资讯";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
    NSString *title = [self.currentitem.title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *time = [self.currentitem.time stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *category = [self.currentitem.category stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    time = [time stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"[]"]];
    category = [category stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"【】"]];
    NSString *cate = [NSString stringWithFormat:@"分类: %@", category];
    self.titleLabel.text = title;
    self.timeLabel.text = time;
    self.categoryLabel.text = cate;
    [self.webView loadHTMLString:self.currentitem.rawContent baseURL:nil];
}

@end

