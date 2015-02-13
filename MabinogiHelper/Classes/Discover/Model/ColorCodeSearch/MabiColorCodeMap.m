//
//  MabiColorCodeMap.m
//  MabinogiHelper
//
//  Created by Joshua on 15/2/10.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import "MabiColorCodeMap.h"
#import "MabiCommon.h"

@implementation MabiColorCodeMap

static NSDictionary *_mabiColorCodeDict;
static NSArray *_groupYellow;
static NSArray *_groupBlue;
static NSArray *_groupRed;
static NSArray *_groupPurple;
static NSArray *_groupPink;
static NSArray *_groupGreen;

+ (NSDictionary *)mabiColorCodeDict
{
    if (!_mabiColorCodeDict) {
        _mabiColorCodeDict = @{
                               @"00FFCC00" : @"C黄 宠黄",
                               @"00FFFFFF" : @"纯白",
                               @"00000049" : @"手染藏蓝",
                               @"00FFF502" : @"手染柠檬黄",
                               @"003A0729" : @"手染深紫",
                               @"00720000" : @"手染暗红",
                               @"0004F6F6" : @"手染水蓝",
                               @"00BEEAFB" : @"手染冰蓝",
                               @"00FECFC8" : @"手染淡粉",
                               @"0040B64A" : @"手染绿",
                               @"0062C453" : @"手染绿 较浅",
                               @"0095E09B" : @"手染翠绿",
                               @"00FAAADD" : @"手染淡粉紫",
                               @"00FF70CE" : @"手染粉紫",
                               @"00D41313" : @"蛋红",
                               @"00FF0000" : @"C红 宠红",
                               @"003333FF" : @"礼蓝",
                               @"0099CCFF" : @"冰蓝",
                               @"000033CC" : @"暗蓝",
                               @"000033FF" : @"亮蓝",
                               @"000685DB" : @"水蓝",
                               @"00067EDB" : @"天蓝",
                               @"00FF66CC" : @"C粉色 宠粉",
                               @"00FFCFE9" : @"奥运粉",
                               @"0000FF00" : @"翠绿",
                               @"00067EDB" : @"天蓝",
                               @"00067EDB" : @"天蓝",
                               @"00000000" : @"纯黑"
                              };
    }
    return _mabiColorCodeDict;
}

+ (NSArray *)groupYellow
{
    if (!_groupYellow) {
        _groupYellow = @[
                         @"00FFCC00",
                         @"00FFF502"
                         ];
    }
    return _groupYellow;
}

+ (NSArray *)groupBlue
{
    if (!_groupBlue) {
        _groupBlue = @[
                         @"003333FF",
                         @"0099CCFF",
                         @"000033CC",
                         @"000033FF",
                         @"000685DB",
                         @"00067EDB",
                         @"00000049",
                         @"0004F6F6",
                         @"00BEEAFB"
                         ];
    }
    return _groupBlue;
}

+ (NSArray *)groupRed
{
    if (!_groupRed) {
        _groupRed = @[
                       @"00FF0000",
                       @"00D41313",
                       @"00720000"
                       ];
    }
    return _groupRed;
}

+ (NSArray *)groupPurple
{
    if (!_groupPurple) {
        _groupPurple = @[
                      @"003A0729"
                      ];
    }
    return _groupPurple;
}

+ (NSArray *)groupPink
{
    if (!_groupPink) {
        _groupPink = @[
                         @"00FF66CC",
                         @"00FFCFE9",
                         @"00FECFC8",
                         @"00FAAADD"
                         ];
    }
    return _groupPink;
}

+ (NSArray *)groupGreen
{
    if (!_groupGreen) {
        _groupGreen = @[
                       @"0000FF00",
                       @"0095E09B",
                       @"0040B64A",
                       @"0062C453"
                       ];
    }
    return _groupGreen;
}


+ (NSString *)getRemarksWithColorCode:(NSString *)colorCode
{
    return self.mabiColorCodeDict[colorCode];
}

+ (NSArray *)getGroupColorCodesWithGroupTitle:(NSString *)groupTitle
{
    if (!groupTitle.length) return nil;
    if ([groupTitle isEqualToString:MabiColorCodeGroupTitleYellow]) {
        return self.groupYellow;
    } else if ([groupTitle isEqualToString:MabiColorCodeGroupTitleBlue]) {
        return self.groupBlue;
    } else if ([groupTitle isEqualToString:MabiColorCodeGroupTitleRed]) {
        return self.groupRed;
    } else if ([groupTitle isEqualToString:MabiColorCodeGroupTitlePurple]) {
        return self.groupPurple;
    } else if ([groupTitle isEqualToString:MabiColorCodeGroupTitleGreen]) {
        return self.groupGreen;
    } else if ([groupTitle isEqualToString:MabiColorCodeGroupTitlePink]) {
        return self.groupPink;
    } else {
        return nil;
    }
    
}

@end
