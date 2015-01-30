//
//  MabiStrategyTool.m
//  MabinogiHelper
//
//  Created by Joshua on 14/12/19.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import "MabiStrategyTool.h"
#import "MabiStrategy.h"
#import "SeraphHTTPTool.h"
#import "SeraphHTTPEncoding.h"
#import "SeraphHTMLParser.h"
#import "SeraphDBTool.h"
#import "MabiCommon.h"

@implementation MabiStrategyTool
static NSMutableArray *_strategyArray;
static MabiStrategy *_strategyItem;
//+ (MabiStrategy *)stragetyItem
//{
//    
//}
+ (NSMutableArray *)strategyArray
{
    if (!_strategyArray) {
        _strategyArray = [NSMutableArray array];
    }
    return _strategyArray;
}

+ (NSString *)getURLWithType:(MabiStrategyType)type page:(int)page
{
    if (!type || !page) {
        return nil;
    }
    int taskID = 0;
    if (type == MabiStrategyTypeMainTask) {
        taskID = 245;
    } else if (type == MabiStrategyTypeSkillTask) {
        taskID = 251;
    } else if (type == MabiStrategyTypeCampaignTask) {
        taskID = 244;
    } else if (type == MabiStrategyTypeOtherTask) {
        taskID = 240;
    }
    if (!taskID) return nil;
    NSString *url = [NSString stringWithFormat:@"http://luoqi.tiancity.com/homepage/article/Class_%d_Time_%d.html", taskID, page];
    
    return url;
}

+ (NSArray *)getStrategyArrayWithType:(MabiStrategyType)type page:(int)page
{
//    NSString *url = @"http://luoqi.tiancity.com/homepage/article/Class_245_Time_6.html";
    NSString *url = [self getURLWithType:type page:page];
    NSString *dataStr = [SeraphHTTPTool getHTMLWithURL:url encoding:[SeraphHTTPEncoding SeraphHTTPStringEncodingGB2312]];
    NSError *error = nil;
    HTMLParser *parser = [SeraphHTMLParser parserWithHTMLString:dataStr error:&error];
    if (error) {
        SeraphLog(@"error %@", error);
        return nil;
    }
    HTMLNode *body = [parser body];
    HTMLNode *missidonDiv = [body findChildWithAttribute:@"class" matchingName:@"mission" allowPartial:NO];
    if (!missidonDiv) return nil;
    NSArray *ddNodes = [missidonDiv findChildTags:@"dd"];
    HTMLNode *img = nil;
    HTMLNode *span = nil;
    HTMLNode *h2 = nil;
    HTMLNode *a = nil;
    NSRange range;
    _strategyArray = nil;
    for (HTMLNode *node in ddNodes) {
        MabiStrategy *item = [[MabiStrategy alloc] init];
        img = [node findChildTag:@"img"];
        item.iconURL = [img getAttributeNamed:@"src"];
        span = [node findChildTag:@"span"];
        item.date = span.allContents;
        h2 = [node findChildTag:@"h2"];
        range = [h2.allContents rangeOfString:@"【"];
        range.length = [h2.allContents rangeOfString:@"】"].location - range.location - 1;
        range.location++;
        item.title = [h2.allContents substringWithRange:range];
        a = [node findChildTag:@"a"];
        item.detailURL = [a getAttributeNamed:@"href"];
        item.detailRawContent = [self getRawContentWithURL:item.detailURL];
        [self.strategyArray addObject:item];
    }
    if (_strategyArray == nil) return nil;
    return [_strategyArray copy];
}

+ (NSString *)getRawContentWithURL:(NSString *)URL
{
    NSString *dataStr = [SeraphHTTPTool getHTMLWithURL:URL encoding:[SeraphHTTPEncoding SeraphHTTPStringEncodingGB2312]];
    NSError *error = nil;
    HTMLParser *parser = [SeraphHTMLParser parserWithHTMLString:dataStr error:&error];
    if (error) {
        SeraphLog(@"error %@", error);
        return nil;
    }
    HTMLNode *body = [parser body];
    HTMLNode *ddNode = [body findChildWithAttribute:@"id" matchingName:@"newscontent" allowPartial:NO];
    NSString *content = @"";
    if (ddNode.rawContents) {
        content = ddNode.rawContents;
        content = [content stringByAppendingString:MabiWebViewCss];
        content = [content stringByReplacingOccurrencesOfString:@"font-size:9pt" withString:@""];
        content = [content stringByReplacingOccurrencesOfString:@"font-size:14pt" withString:@""];
    } else {
        content= MabiWebViewErrorCss;
    }
    return content;
}

+ (BOOL)saveToDatabase:(NSArray *)strategyArray type:(MabiStrategyType)type
{
    if (!strategyArray) return false;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:strategyArray];
    NSString *dbName = @"MabiDB.sqlite";
    NSString *path = [SeraphDBTool getDBPathWithName:dbName];
    SeraphDatabaseQueue *queue = [SeraphDBTool createDBQueueWithPath:path];
    [queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"CREATE TABLE IF NOT EXISTS T_STRATEGY(ID INTEGER PRIMARY KEY AUTOINCREMENT, TASKSTR TEXT NOT NULL DEFAULT '', STRAGETYARRAY BLOB);"];
    }];
    [self insertData:data type:type];
    return true;
}

+ (void)insertData:(NSData *)data type:(MabiStrategyType)type
{
    NSString *t = @"";
    if (type == MabiStrategyTypeMainTask) {
        t = @"MabiStrategyTypeMainTask";
    } else if (type == MabiStrategyTypeSkillTask) {
        t = @"MabiStrategyTypeSkillTask";
    } else if (type == MabiStrategyTypeCampaignTask) {
        t = @"MabiStrategyTypeCampaignTask";
    } else if (type == MabiStrategyTypeOtherTask) {
        t = @"MabiStrategyTypeOtherTask";
    }
    NSString *dbName = @"MabiDB.sqlite";
    NSString *path = [SeraphDBTool getDBPathWithName:dbName];
    SeraphDatabaseQueue *queue = [SeraphDBTool createDBQueueWithPath:path];
    [queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"INSERT INTO T_STRATEGY(TASKSTR, STRAGETYARRAY) VALUES (?, ?);",t, data];
    }];
}

+ (NSArray *)getDataFromDatabaseWithType:(MabiStrategyType)type
{
    NSString *t = @"";
    if (type == MabiStrategyTypeMainTask) {
        t = @"MabiStrategyTypeMainTask";
    } else if (type == MabiStrategyTypeSkillTask) {
        t = @"MabiStrategyTypeSkillTask";
    } else if (type == MabiStrategyTypeCampaignTask) {
        t = @"MabiStrategyTypeCampaignTask";
    } else if (type == MabiStrategyTypeOtherTask) {
        t = @"MabiStrategyTypeOtherTask";
    }
    NSString *dbName = @"MabiDB.sqlite";
    NSString *path = [SeraphDBTool getDBPathWithName:dbName];
    __block NSArray *dataArray = [NSArray array];
    SeraphDatabaseQueue *queue = [SeraphDBTool createDBQueueWithPath:path];
    [queue inDatabase:^(FMDatabase *db) {
        SeraphDatabaseQueryResultSet *result = (SeraphDatabaseQueryResultSet *)[db executeQuery:@"SELECT * FROM T_STRATEGY;"];
        while (result.next) {
            NSString *typeStr = [result stringForColumn:@"TASKSTR"];
            if ([typeStr isEqualToString:t]) {
                NSData *data = [result dataForColumn:@"STRAGETYARRAY"];
                dataArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                break;
            }
        }
        [result close];
    }];
    if (!dataArray) return nil;
    return dataArray;
        
}

+ (void)deleteDataFromDatabaseWithType:(MabiStrategyType)type
{
    NSString *t = @"";
    if (type == MabiStrategyTypeMainTask) {
        t = @"MabiStrategyTypeMainTask";
    } else if (type == MabiStrategyTypeSkillTask) {
        t = @"MabiStrategyTypeSkillTask";
    } else if (type == MabiStrategyTypeCampaignTask) {
        t = @"MabiStrategyTypeCampaignTask";
    } else if (type == MabiStrategyTypeOtherTask) {
        t = @"MabiStrategyTypeOtherTask";
    }
    NSString *dbName = @"MabiDB.sqlite";
    NSString *path = [SeraphDBTool getDBPathWithName:dbName];
    SeraphDatabaseQueue *queue = [SeraphDBTool createDBQueueWithPath:path];
    [queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"DELETE FROM T_STRATEGY WHERE TASKSTR=?", t];
    }];
    
}

@end
