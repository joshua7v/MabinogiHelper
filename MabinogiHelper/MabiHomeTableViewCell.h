//
//  MabiHomeTableViewCell.h
//  MabinogiHelper
//
//  Created by Joshua on 14/12/12.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MabiHomeNewsItem;

@interface MabiHomeTableViewCell : UITableViewCell
@property (nonatomic, strong) MabiHomeNewsItem *item;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
