//
//  MabiMainTaskDetailController.m
//  MabinogiHelper
//
//  Created by Joshua on 14/12/21.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import "MabiMainTaskDetailController.h"
#import "MabiStrategy.h"
#import "MabiStrategyTool.h"

@interface MabiMainTaskDetailController()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation MabiMainTaskDetailController

- (void)setCurrentitem:(MabiStrategy *)currentitem
{
    _currentitem = currentitem;
    self.titleLabel.text = self.currentitem.title;
    self.timeLabel.text = self.currentitem.date;
    self.categoryLabel.text = @"主线任务";
    [self.webView loadHTMLString:self.currentitem.detailRawContent baseURL:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setCurrentitem:self.currentitem];
}

@end
