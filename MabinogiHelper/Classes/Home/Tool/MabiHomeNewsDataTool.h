//
//  MabiHomeNewsDataTool.h
//  MabinogiHelper
//
//  Created by Joshua on 14/12/12.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MabiHomeNewsDataTypeAll,
    MabiHomeNewsDataTypeGame,
    MabiHomeNewsDataTypeCampaign,
    MabiHomeNewsDataTypeSystem
} MabiHomeNewsDataType;

@interface MabiHomeNewsDataTool : NSObject
+ (MabiHomeNewsDataTool *)sharedHomeNewsDataTool;
- (NSMutableArray *)getHomeNewsData:(MabiHomeNewsDataType)dataType index:(int)index statusCode:(int *)statusCode;
- (NSArray *)getDataFromDBWithType:(MabiHomeNewsDataType)dataType;
@end
