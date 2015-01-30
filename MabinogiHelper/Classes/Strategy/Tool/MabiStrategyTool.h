//
//  MabiStrategyTool.h
//  MabinogiHelper
//
//  Created by Joshua on 14/12/19.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MabiStrategy;

typedef enum {
    MabiStrategyTypeMainTask = 1,
    MabiStrategyTypeSkillTask,
    MabiStrategyTypeCampaignTask,
    MabiStrategyTypeOtherTask
} MabiStrategyType;

@interface MabiStrategyTool : NSObject

+ (NSArray *)getStrategyArrayWithType:(MabiStrategyType)type page:(int)page;
+ (NSString *)getRawContentWithURL:(NSString *)URL;

+ (BOOL)saveToDatabase:(NSArray *)strategyArray type:(MabiStrategyType)type;
+ (NSArray *)getDataFromDatabaseWithType:(MabiStrategyType)type;
+ (void)deleteDataFromDatabaseWithType:(MabiStrategyType)type;
@end
