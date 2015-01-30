//
//  MabiParamMap.m
//  MabinogiHelper
//
//  Created by Joshua on 14/12/16.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import "MabiParamMap.h"

@implementation MabiParamMap
/**
 *  存放服务器字典
 */
static NSDictionary *_servers;
static NSDictionary *_appCode;
+ (NSDictionary *)servers
{
    if (!_servers) {
        _servers = @{@"mabicn16" : @"玛丽",
                     @"mabicn17" : @"鲁拉里",
                     @"mabicn31" : @"皮埃罗",
                     @"mabicn32" : @"萨马拉",
                     @"mabicn33" : @"露娜",
                     @"mabicn28" : @"伊文"};
    }
    return _servers;
}

+ (NSDictionary *)appCode
{
    if (!_appCode) {
        _appCode = @{@"mabicn16" : @1,
                     @"mabicn17" : @1,
                     @"mabicn31" : @4,
                     @"mabicn32" : @9,
                     @"mabicn33" : @10,
                     @"mabicn28" : @3};
    }
    return _appCode;
}

+ (NSString *)MabiAdItemSortTypeDefault
{
    return @"0";
}

+ (NSString *)MabiAdItemSortTypeSeller
{
    return @"1";
}

+ (NSString *)MabiAdItemSortTypeItemName
{
    return @"4";
}

+ (NSString *)MabiAdItemSortTypePrice
{
    return @"5";
}



+ (NSString *)MabiAdItemSortOptionDefault
{
    return @"0";
}

+ (NSString *)MabiAdItemSortOptionAsc
{
    return @"1";
}
+ (NSString *)MabiAdItemSortOptionDesc
{
    return @"2";
}



+ (NSString *)MabiAdItemSearchTypeDefault
{
    return @"0";
}

+ (NSString *)MabiAdItemSearchTypeSeller
{
    return @"1";
}

+ (NSString *)MabiAdItemSearchTypeItemName
{
    return @"4";
}

+ (NSString *)MabiAdItemSearchTypePrice
{
    return @"5";
}


+ (NSString *)MabiAdItemNameServerMaryCN
{
    return @"mabicn16";
}

+ (NSString *)MabiAdItemNameServerLulaliCN
{
    return @"mabicn17";
}

+ (NSString *)MabiAdItemNameServerYiwenCN
{
    return @"mabicn28";
}

+ (NSString *)MabiAdItemNameServerPiailuoCN
{
    return @"mabicn31";
}
+ (NSString *)MabiAdItemNameServerSamalaCN
{
    return @"mabicn32";
}
+ (NSString *)MabiAdItemNameServerLunaCN
{
    return @"mabicn33";
}

+ (NSString *)MabiAdItemRowDefault
{
    return @"10";
}

+ (NSString *)getServerNameWithServerStr:(NSString *)serverStr
{
    return self.servers[serverStr];
}


+ (NSString *)notificationWithSearchTypeDidChangeToSeller
{
    return @"SearchTypeDidChangeToSeller";
}
+ (NSString *)notificationWithSearchTypeDidChangeToItemName
{
    return @"SearchTypeDidChangeToItemName";
}
+ (NSString *)notificationWithNumberOfSearchRowsDidChanged
{
    return @"NumberOfSearchRowsDidChanged";
}
+ (NSString *)notificationWithJumpToPage
{
    return @"JumpToPage";
}
+ (NSString *)notificationWithSortTypeDidChangeToItemName
{
    return @"SortTypeDidChangeToItemName";
}

+ (NSString *)notificationWithThemeChanged
{
    return @"ThemeChanged";
}

+ (int)getAppCodeWithServerStr:(NSString *)serverStr
{
    return [[self.appCode objectForKey:serverStr] intValue];
}

@end
