//
//  MabiHomeNewsDataTool.m
//  MabinogiHelper
//
//  Created by Joshua on 14/12/12.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//



#import "MabiHomeNewsDataTool.h"
#import "SeraphHTTPTool.h"
#import "SeraphHTMLParser.h"
#import "SeraphHTTPEncoding.h"
#import "MabiHomeNewsItem.h"
#import "SeraphDBTool.h"
#import "MabiCommon.h"

@interface MabiHomeNewsDataTool()
@property (nonatomic, strong) NSMutableArray *newsItems;
@end

@implementation MabiHomeNewsDataTool

- (NSMutableArray *)newsItems
{
    if (_newsItems == nil) {
        _newsItems = [NSMutableArray array];
    }
    return _newsItems;
}

+ (MabiHomeNewsDataTool *)sharedHomeNewsDataTool
{
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static MabiHomeNewsDataTool *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

- (NSMutableArray *)getHomeNewsData:(MabiHomeNewsDataType)dataType index:(int)index statusCode:(int *)statusCode
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    self.newsItems = nil;
    // 获取首页标题数据
    [self getHomeNewsDataFromWeb:dataType index:index];
    // 获取条目详细数据
    for (MabiHomeNewsItem *item in self.newsItems) {
        [self getHomeNewsDataDetailFromWeb:item];
    }
    NSString *type = @"";
    if (dataType == MabiHomeNewsDataTypeAll) {
        type = @"MabiHomeNewsDataTypeAll";
    } else if (dataType == MabiHomeNewsDataTypeGame) {
        type = @"MabiHomeNewsDataTypeGame";
    } else if (dataType == MabiHomeNewsDataTypeCampaign) {
        type = @"MabiHomeNewsDataTypeCampaign";
    } else if (dataType == MabiHomeNewsDataTypeSystem) {
        type = @"MabiHomeNewsDataTypeSystem";
    }
    if (index == 1) {
        *statusCode = [self saveToDatabase:[self.newsItems copy] type:type];
    }
    return self.newsItems;
}

- (void)getHomeNewsDataDetailFromWeb:(MabiHomeNewsItem *)item
{
    // 获取数据
    NSString *dataString = [SeraphHTTPTool getHTMLWithURL:item.href encoding:[SeraphHTTPEncoding SeraphHTTPStringEncodingGB2312]];
    
    // 解析开始
    NSError *error = nil;
    Parser *parser = [SeraphHTMLParser parserWithHTMLString:dataString error:&error];
    HTMLNode *bodyNode = [parser body];
    HTMLNode *ddNode = [bodyNode findChildWithAttribute:@"id" matchingName:@"newscontent" allowPartial:NO];
    NSString *content = @"";
    if (ddNode.rawContents) {
        item.rawContent = MabiWebViewCss;
        content = [content stringByAppendingString:ddNode.rawContents];
        item.rawContent = [item.rawContent stringByAppendingString:content];
    } else {
        item.rawContent = MabiWebViewErrorCss;
    }
    
}

#warning 待处理
- (NSArray *)getDataFromDBWithType:(MabiHomeNewsDataType)dataType
{
    NSString *type = @"";
    if (dataType == MabiHomeNewsDataTypeAll) {
        type = @"MabiHomeNewsDataTypeAll";
    } else if (dataType == MabiHomeNewsDataTypeGame) {
        type = @"MabiHomeNewsDataTypeGame";
    } else if (dataType == MabiHomeNewsDataTypeCampaign) {
        type = @"MabiHomeNewsDataTypeCampaign";
    } else if (dataType == MabiHomeNewsDataTypeSystem) {
        type = @"MabiHomeNewsDataTypeSystem";
    }
    
    NSString *dbName = @"MabiDB.sqlite";
    NSString *dbPath = [SeraphDBTool getDBPathWithName:dbName];
    SeraphDatabaseQueue *queue = [SeraphDBTool createDBQueueWithPath:dbPath];
    __block NSArray *newsItems = [NSArray array];
    [queue inDatabase:^(FMDatabase *db) {
        SeraphDatabaseQueryResultSet *result = (SeraphDatabaseQueryResultSet *)[db executeQuery: @"SELECT * FROM T_MABINEWS"];
        while (result.next) {
            NSString *temp = [result stringForColumn:@"NEWSDATATYPE"];
            if ([temp isEqualToString:type]) {
                NSData *data = [result dataForColumn:@"NEWSITEMARRAY"];
                newsItems = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            }
        }
    }];
    
    return newsItems;
}

- (int)saveToDatabase:(NSArray *)newsItems type:(NSString *)dataType
{
    if (!newsItems.count) {
        MabiHomeNewsDataType type = 0;
        if ([dataType isEqualToString:@"MabiHomeNewsDataTypeAll"]) {
            type = MabiHomeNewsDataTypeAll;
        } else if ([dataType isEqualToString:@"MabiHomeNewsDataTypeGame"]) {
            type = MabiHomeNewsDataTypeGame;
        } else if ([dataType isEqualToString:@"MabiHomeNewsDataTypeCampaign"]) {
            type = MabiHomeNewsDataTypeCampaign;
        } else if ([dataType isEqualToString:@"MabiHomeNewsDataTypeSystem"]) {
            type = MabiHomeNewsDataTypeSystem;
        }
        self.newsItems = [[self getDataFromDBWithType:type] mutableCopy];
        return 1; // 1 -> 无网络
    }
    NSString *dbName = @"MabiDB.sqlite";
    NSString *dbPath = [SeraphDBTool getDBPathWithName:dbName];
    SeraphDatabaseQueue *queue = [SeraphDBTool createDBQueueWithPath:dbPath];
    // 删除旧数据
    [queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"DELETE FROM T_MABINEWS WHERE NEWSDATATYPE=?", dataType];
    }];
    
    [queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"CREATE TABLE IF NOT EXISTS T_MABINEWS(ID INTEGER PRIMARY KEY AUTOINCREMENT, NEWSDATATYPE TEXT NOT NULL DEFAULT '', NEWSITEMARRAY BLOB);"];
    }];
    [self insertData:newsItems type:dataType];
    return 0; // 0 -> 正常刷新
    
//    if (!strategyArray) return false;
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:strategyArray];
//    NSString *dbName = @"MabiDB.sqlite";
//    NSString *path = [SeraphDBTool getDBPathWithName:dbName];
//    SeraphDatabaseQueue *queue = [SeraphDBTool createDBQueueWithPath:path];
//    [queue inDatabase:^(FMDatabase *db) {
//        [db executeUpdate:@"CREATE TABLE IF NOT EXISTS T_STRATEGY(ID INTEGER PRIMARY KEY AUTOINCREMENT, TASKSTR TEXT NOT NULL DEFAULT '', STRAGETYARRAY BLOB);"];
//    }];
//    [self insertData:data type:type];
//    return true;
}

- (void)insertData:(NSArray *)newsItemArray type:(NSString *)dataType
{
    NSString *dbName = @"MabiDB.sqlite";
    NSString *dbPath = [SeraphDBTool getDBPathWithName:dbName];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:newsItemArray];
    SeraphDatabaseQueue *queue = [SeraphDBTool createDBQueueWithPath:dbPath];
    [queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"INSERT INTO T_MABINEWS (NEWSDATATYPE, NEWSITEMARRAY) VALUES (?, ?)", dataType, data];
    }];
}

/**
 *  根据数据类型返回所需URL
 */
- (NSString *)getURLWithDataType:(MabiHomeNewsDataType)dataType index:(int)index
{
    NSString *url = nil;
    int data = 255;
    
    if (dataType == MabiHomeNewsDataTypeAll) {
        data = 255;
    } else if (dataType == MabiHomeNewsDataTypeGame) {
        data = 224;
    } else if (dataType == MabiHomeNewsDataTypeCampaign) {
        data = 232;
    } else if (dataType == MabiHomeNewsDataTypeSystem) {
        data = 231;
    }
    
    url = [NSString stringWithFormat:@"http://luoqi.tiancity.com/homepage/article/Class_%d_Time_%d.html", data, index];
    
    return url;
}

/**
 *  获取页面标题数据
 *
 *  @param dataType 数据类型
 *  @param index    数据页码
 *
 *  @return 数据单元模型
 */
- (void)getHomeNewsDataFromWeb:(MabiHomeNewsDataType)dataType index:(int)index
{
    // 获取数据
    NSString *url = [self getURLWithDataType:dataType index:index];
    NSString *dataString = [SeraphHTTPTool getHTMLWithURL:url encoding:[SeraphHTTPEncoding SeraphHTTPStringEncodingGB2312]];
    if (!dataString) {
        return;
    }
    
    // 解析开始
    NSError *error = nil;
    Parser *parser = [SeraphHTMLParser parserWithHTMLString:dataString error:&error];
    HTMLNode *bodyNode = [parser body];
    HTMLNode *ulNode = [bodyNode findChildWithAttribute:@"class" matchingName:@"newsList" allowPartial:NO];
    NSArray *liNodes = [ulNode findChildTags:@"li"];
    for (HTMLNode *node in liNodes) {
        HTMLNode *aNode = [node findChildTag:@"a"];
        NSString *href = [aNode getAttributeNamed:@"href"];
        NSString *newsString = node.allContents;
        NSRange categoryRange = [newsString rangeOfString:@"["];
        NSString *category = [newsString substringToIndex:categoryRange.location];
        NSRange tempRange = [newsString rangeOfString:@"]"];
        NSRange timeRage;
        timeRage.location = categoryRange.location;
        timeRage.length = tempRange.location - categoryRange.location + 1;
        NSString *time = [newsString substringWithRange:timeRage];
        tempRange.location = timeRage.location + timeRage.length;
        NSString *title = [newsString substringFromIndex:tempRange.location];
        MabiHomeNewsItem *item = [[MabiHomeNewsItem alloc] init];
        item.href = href;
        item.time = time;
        item.category = category;
        item.title = title;
        [self.newsItems addObject:item];
    }
}

@end
