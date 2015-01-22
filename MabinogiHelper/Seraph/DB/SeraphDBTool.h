//
//  SeraphDBTool.h
//  Seraph
//
//  Created by Joshua on 14/12/6.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
@class SeraphDatabaseQueue, SeraphDatabase;

@interface SeraphDBTool : NSObject
/**
 *  用数据库名 例如"my.sqlite" 换取路径
 *
 *  @param name 数据库名
 *
 *  @return 数据库路径
 */
+ (NSString *)getDBPathWithName:(NSString *)name;
/**
 *  用路径创建数据库队列 线程安全
 *
 *  @param path 路径
 *
 *  @return 数据库队列
 */
+ (SeraphDatabaseQueue *)createDBQueueWithPath:(NSString *)path;

@end

@interface SeraphDatabaseQueue : FMDatabaseQueue

@end

@interface SeraphDatabase : FMDatabase

@end

@interface SeraphDatabaseQueryResultSet : FMResultSet

@end