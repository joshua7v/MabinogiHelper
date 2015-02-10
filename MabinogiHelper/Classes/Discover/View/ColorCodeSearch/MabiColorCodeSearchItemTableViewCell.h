//
//  MabiColorCodeSearchItemTableViewCell.h
//  MabinogiHelper
//
//  Created by Joshua on 15/2/10.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MabiColorCodeItem;

@interface MabiColorCodeSearchItemTableViewCell : UITableViewCell
@property (nonatomic, strong) MabiColorCodeItem *colorCodeItem;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
