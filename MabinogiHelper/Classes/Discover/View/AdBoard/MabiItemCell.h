//
//  MabiItemCell.h
//  MabinogiHelper
//
//  Created by Joshua on 14/12/15.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MabiItem;

@interface MabiItemCell : UITableViewCell
@property (nonatomic, strong) MabiItem *item;
@property (nonatomic, copy) NSString *imageRequestURL;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
