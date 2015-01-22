//
//  SeraphDBTool.m
//  Seraph
//
//  Created by Joshua on 14/12/6.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import "SeraphDBTool.h"
#import "FMDB.h"

@implementation SeraphDBTool

+ (NSString *)getDBPathWithName:(NSString *)name
{
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:name];
    
    return filePath;
}

+ (SeraphDatabaseQueue *)createDBQueueWithPath:(NSString *)path
{
    return (SeraphDatabaseQueue *)[FMDatabaseQueue databaseQueueWithPath:path];
}


@end
