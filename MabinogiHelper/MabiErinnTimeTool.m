//
//  MabiErinnTimeTool.m
//  MabinogiHelper
//
//  Created by Joshua on 14/12/30.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import "MabiErinnTimeTool.h"

@implementation MabiErinnTimeTool


+ (NSString *)getCurrentErinnTime
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday |NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:now];
    
    int totoalSeconds = (comps.hour * 60 * 60 + comps.minute * 60 + comps.second) * 40;
    int mNumber = totoalSeconds / 60;
    int sNumberFix = totoalSeconds % 60;
    int hNumber = mNumber / 60;
    int mNumberFix = mNumber % 60;
    int dNumber = hNumber / 24;
    int hNumberFix = hNumber % 24;
    NSString *currentTime = [NSString stringWithFormat:@"%02d : %02d", hNumberFix, mNumberFix];
    return currentTime;
}

@end
