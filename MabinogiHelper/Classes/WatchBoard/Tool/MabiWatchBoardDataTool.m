//
//  MabiWatchBoardDataTool.m
//  MabinogiHelper
//
//  Created by Joshua on 14/12/11.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import "MabiWatchBoardDataTool.h"
#import "SeraphHTMLParser.h"
#import "SeraphHTTPTool.h"
#import "MabiSmuggle.h"
#import "MabiSmuggleDetail.h"
#import "MabiWeather.h"
#import "MabiToday.h"
#import "MabiTime.h"
#import "MabiErinnTimeTool.h"

@interface MabiWatchBoardDataTool()
@property (nonatomic, strong) MabiSmuggle *smuggle;
@property (nonatomic, strong) NSMutableArray *weatherArray;
@property (nonatomic, strong) MabiToday *today;
@property (nonatomic, strong) MabiTime *currentGameTime;
@end

@implementation MabiWatchBoardDataTool

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static MabiWatchBoardDataTool *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

+ (instancetype)sharedWatchBoardDataTool
{
    return [[self alloc] init];
}

- (MabiSmuggle *)smuggle
{
    if (_smuggle == nil) {
        _smuggle = [[MabiSmuggle alloc] init];
        _smuggle.detailArray = [NSMutableArray array];
    }
    return _smuggle;
}

- (NSMutableArray *)weatherArray
{
    if (_weatherArray == nil) {
        _weatherArray = [NSMutableArray array];
    }
    return _weatherArray;
}

- (MabiToday *)today
{
    if (_today == nil) {
        _today = [[MabiToday alloc] init];
        _today.today = [[MabiTodayMission alloc] init];
        _today.vipToday = [[MabiTodayMission alloc] init];
    }
    return _today;
}

- (MabiSmuggle *)getSmuggleData
{
    [self getSmuggleDataFromWeb];
    return self.smuggle;
}

- (NSArray *)getWeatherData
{
    [self getWeatherDataFromWeb];
    return [self.weatherArray copy];
}

- (MabiToday *)getTodayData
{
    [self getTodayDataFromWeb];
    return self.today;
}

- (void)getSmuggleDataFromWeb
{
    NSString *url = @"http://weather.erinn.biz/smuggler.php";
    // 获取网页HTML
    NSString *stringData = [SeraphHTTPTool getHTMLWithURL:url];
    // 初始化解析器
    NSError *error = nil;
    Parser *parser = [SeraphHTMLParser parserWithHTMLString:stringData error:&error];
    if (error) {
        SeraphLog(@"Error %@", error);
    }
    // 解析开始
    
    HTMLNode *bodyNode = [parser body];
    NSArray *tableNodes = [bodyNode findChildTags:@"table"];
    HTMLNode *tableNode = nil;
    HTMLNode *timeNode = nil;
    HTMLNode *temp = tableNodes[13];
    if (temp.allContents.length > 60) {
        tableNode = tableNodes[13];
        timeNode = tableNodes[14];
    } else {
        tableNode = tableNodes[12];
        timeNode = tableNodes[13];
    }
    self.smuggle.date = [timeNode.allContents stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSArray *tdNodes = [tableNode findChildTags:@"td"];
    HTMLNode *tdNode = nil;
    MabiSmuggleDetail *smuggleDetail = nil;
    for (int i = 0; i < tdNodes.count; i++) {
        tdNode = tdNodes[i];
        if (i % 3 == 0) {
            smuggleDetail = [[MabiSmuggleDetail alloc] init];
            smuggleDetail.time = tdNode.allContents;
        } else if (i % 3 == 1) {
            smuggleDetail.location = tdNode.allContents;;
        } else {
            smuggleDetail.item = tdNode.allContents;
            [self.smuggle.detailArray addObject:smuggleDetail];
        }
    }
}

- (void)getWeatherDataFromWeb
{
    NSString *url = @"http://mabinogi.fws.tw/weather.php";
    // 获取网页HTML
    NSString *stringData = [SeraphHTTPTool getHTMLWithURL:url];
    // 初始化解析器
    NSError *error = nil;
    Parser *parser = [SeraphHTMLParser parserWithHTMLString:stringData error:&error];
    if (error) {
        SeraphLog(@"Error %@", error);
    }
    // 解析开始
    HTMLNode *bodyNode = [parser body];
    NSArray *weaNodes = [bodyNode findChildrenWithAttribute:@"class" matchingName:@"maintable" allowPartial:YES];
    HTMLNode *weaNode = weaNodes[1];
    NSArray *weatherNodes = [weaNode findChildTags:@"td"];
    HTMLNode *node = nil;
    MabiWeather *weather = nil;
    for (int i = 0; i < weatherNodes.count; i++) {
        node = weatherNodes[i];
        
        if ((i % 4 == 0 && i >= 4) || i == 0) {
            weather = [[MabiWeather alloc] init];
            weather.location = node.allContents;
        } else if (i % 4 == 1) {
            weather.time = node.allContents;;
        } else if (i % 4 == 2){
            weather.weather = node.allContents;
            [self.weatherArray addObject:weather];
        }
        
    }
}

- (void)getTodayDataFromWeb
{
    NSString *url = @"http://mabinogi.fws.tw/index.php";
    // 获取网页HTML
    NSString *stringData = [SeraphHTTPTool getHTMLWithURL:url];
    // 初始化解析器
    NSError *error = nil;
    Parser *parser = [SeraphHTMLParser parserWithHTMLString:stringData error:&error];
    if (error) {
        SeraphLog(@"Error %@", error);
    }
    // 解析开始
    HTMLNode *bodyNode = [parser body];
    HTMLNode *marqueeNode = [bodyNode findChildTag:@"marquee"];
    self.today.todayAddition = marqueeNode.allContents;
    NSArray *spanNodes = [bodyNode findChildrenWithAttribute:@"class" matchingName:@"today_quest" allowPartial:YES];
    for (int i = 0; i < spanNodes.count; i++) {
        HTMLNode *node = spanNodes[i];
        if (i == 0) {
            self.today.today.date = node.allContents;
        } else {
            self.today.vipToday.date = node.allContents;
        }
    }
    NSArray *missionNodes = [bodyNode findChildrenWithAttribute:@"class" matchingName:@"area_qst" allowPartial:YES];
    for (int i = 0; i < missionNodes.count; i++) {
        HTMLNode *node = missionNodes[i];
        switch (i) {
            case 0:
                self.today.today.tating = node.allContents;
                break;
            case 1:
                self.today.today.tara = node.allContents;
                break;
            case 2:
                self.today.vipToday.tating = node.allContents;
                break;
            case 3:
                self.today.vipToday.tara = node.allContents;
                break;
            default:
                break;
        }
    }
}

- (MabiTime *)currentGameTime
{
    if (!_currentGameTime) {
        _currentGameTime = [[MabiTime alloc] init];
    }
    _currentGameTime.currentTime = [MabiErinnTimeTool getCurrentErinnTime];
    return _currentGameTime;
}

- (MabiTime *)getCurrentGameTime
{
    return self.currentGameTime;
}

@end
