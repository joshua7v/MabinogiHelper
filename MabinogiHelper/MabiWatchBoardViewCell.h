//
//  MabiWatchBoardViewCell.h
//  MabinogiHelper
//
//  Created by Joshua on 14/12/11.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MabiToday, MabiSmuggle, MabiSmuggleDetail;

@interface MabiWatchBoardViewCell : UITableViewCell
@property (nonatomic, strong) MabiToday *today;
@property (nonatomic, strong) MabiSmuggle *smuggle;
@property (nonatomic, strong) MabiSmuggleDetail *smuggleDetailItem;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
