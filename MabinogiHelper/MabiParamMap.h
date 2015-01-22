//
//  MabiParamMap.h
//  MabinogiHelper
//
//  Created by Joshua on 14/12/16.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MabiParamMap : NSObject

+ (NSString *)MabiAdItemSortTypeDefault;
+ (NSString *)MabiAdItemSortTypeSeller;
+ (NSString *)MabiAdItemSortTypeItemName;
+ (NSString *)MabiAdItemSortTypePrice;


+ (NSString *)MabiAdItemSortOptionDefault;
+ (NSString *)MabiAdItemSortOptionAsc;
+ (NSString *)MabiAdItemSortOptionDesc;

+ (NSString *)MabiAdItemRowDefault;

+ (NSString *)MabiAdItemSearchTypeDefault;
+ (NSString *)MabiAdItemSearchTypeSeller;
+ (NSString *)MabiAdItemSearchTypeItemName;
+ (NSString *)MabiAdItemSearchTypePrice;

+ (NSString *)MabiAdItemNameServerMaryCN;
+ (NSString *)MabiAdItemNameServerLulaliCN;
+ (NSString *)MabiAdItemNameServerPiailuoCN;
+ (NSString *)MabiAdItemNameServerSamalaCN;
+ (NSString *)MabiAdItemNameServerYiwenCN;
+ (NSString *)MabiAdItemNameServerLunaCN;

+ (NSString *)getServerNameWithServerStr:(NSString *)serverStr;

+ (NSString *)notificationWithSearchTypeDidChangeToSeller;
+ (NSString *)notificationWithSearchTypeDidChangeToItemName;
+ (NSString *)notificationWithNumberOfSearchRowsDidChanged;
+ (NSString *)notificationWithJumpToPage;
+ (NSString *)notificationWithSortTypeDidChangeToItemName;
+ (NSString *)notificationWithThemeChanged;

+ (int)getAppCodeWithServerStr:(NSString *)serverStr;
@end