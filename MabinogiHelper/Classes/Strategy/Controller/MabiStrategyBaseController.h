//
//  MabiStrategyBaseController.h
//  MabinogiHelper
//
//  Created by Joshua on 14/12/21.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MabiStrategyTool.h"
@class MabiMainTaskDetailController;
@interface MabiStrategyBaseController : UICollectionViewController
@property (nonatomic, strong) NSMutableArray *strategyArray;
@property (nonatomic, strong) MabiMainTaskDetailController *detailVC;

- (void)getDataWithType:(MabiStrategyType)type;
/**
 * 从网络获取数据
 */
- (void)getDataFromWebWithType:(MabiStrategyType)type;

- (void)refresh;
- (BOOL)dataInDB:(MabiStrategyType)type;
- (void)deleteDataFromDBWithType:(MabiStrategyType)type;
@end
