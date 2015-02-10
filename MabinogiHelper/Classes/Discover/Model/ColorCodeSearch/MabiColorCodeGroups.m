//
//  MabiColorCodeGroups.m
//  MabinogiHelper
//
//  Created by Joshua on 15/2/10.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import "MabiColorCodeGroups.h"
#import "MabiColorCodeGroup.h"
#import "MabiColorCodeMap.h"
#import "MabiCommon.h"

@implementation MabiColorCodeGroups
static NSMutableArray *_colorCodeGroups;
static NSArray *_groups;
+ (NSArray *)groups
{
    if (!_groups) {
        _groups = @[ MabiColorCodeGroupTitleYellow, MabiColorCodeGroupTitleBlue, MabiColorCodeGroupTitleRed, MabiColorCodeGroupTitleGreen, MabiColorCodeGroupTitlePurple, MabiColorCodeGroupTitlePink ];
    }
    
    return _groups;
}

+ (NSArray *)getTitleGroups
{
    return self.groups;
}

+ (NSArray *)getColorCodeGroups
{
    _colorCodeGroups = [NSMutableArray array];
    MabiColorCodeGroup *group = nil;
    for (NSString *str in self.groups) {
        group = [[MabiColorCodeGroup alloc] init];
        group.title = str;
        group.colorCodes = [MabiColorCodeMap getGroupColorCodesWithGroupTitle:str];
        [_colorCodeGroups addObject:group];
    }
    
    return _colorCodeGroups;
}

@end
