//
//  MabiWatchBoardDataTool.h
//  MabinogiHelper
//
//  Created by Joshua on 14/12/11.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MabiSmuggle, MabiWeather, MabiToday, MabiTime;

@interface MabiWatchBoardDataTool : NSObject
+ (instancetype)sharedWatchBoardDataTool;
/**
 *  获得走私数据
 */
- (MabiSmuggle *)getSmuggleData;
/**
 *  获得天气数据
 */
- (NSArray *)getWeatherData;
/**
 *  获得每日数据
 */
- (MabiToday *)getTodayData;
/**
 *  获得当前游戏时间
 */
- (MabiTime *)getCurrentGameTime;
@end
