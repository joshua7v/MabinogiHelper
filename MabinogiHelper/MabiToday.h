//
//  MabiToday.h
//  MabinogiHelper
//
//  Created by Joshua on 14/12/11.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MabiTodayMission.h"

@interface MabiToday : NSObject
/**
 *  今日加成
 */
@property (nonatomic, copy) NSString *todayAddition;
/**
 *  今日任务
 */
@property (nonatomic, strong) MabiTodayMission *today;
/**
 *  今日任务 vip
 */
@property (nonatomic, strong) MabiTodayMission *vipToday;

@end
