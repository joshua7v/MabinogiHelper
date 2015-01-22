//
//  MabiSmuggleDetail.h
//  MabinogiHelper
//
//  Created by Joshua on 14/12/11.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MabiSmuggleDetail : NSObject
/**
 *  走私时间
 */
@property (nonatomic, copy) NSString *time;
/**
 *  走私位置
 */
@property (nonatomic, copy) NSString *location;
/**
 *  走私物品
 */
@property (nonatomic, copy) NSString *item;
@end
