//
//  MabiWeather.h
//  MabinogiHelper
//
//  Created by Joshua on 14/12/11.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MabiWeather : NSObject
/**
 *  地点
 */
@property (nonatomic, copy) NSString *location;
/**
 *  天气
 */
@property (nonatomic, copy) NSString *weather;
/**
 *  时间
 */
@property (nonatomic, copy) NSString *time;
@end
