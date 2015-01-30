//
//  MabiHomeDetailController.m
//  MabinogiHelper
//
//  Created by Joshua on 14/12/12.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MabiSettingGroup;

@interface MabiSettingViewController : UITableViewController
@property (strong, nonatomic) NSMutableArray *groups;

- (MabiSettingGroup *)addGroup;
@end
