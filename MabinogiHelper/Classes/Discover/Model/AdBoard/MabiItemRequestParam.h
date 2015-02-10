//
//  MabiItemRequestParam.h
//  MabinogiHelper
//
//  Created by Joshua on 14/12/15.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MabiItemRequestParam : NSObject
@property (nonatomic, copy) NSString *Name_Server;
@property (nonatomic, copy) NSString *page;
@property (nonatomic, copy) NSString *row;
@property (nonatomic, copy) NSString *sortType;
@property (nonatomic, copy) NSString *searchWord;
@property (nonatomic, copy) NSString *searchType;
@property (nonatomic, copy) NSString *sortOption;
@property (nonatomic, assign) int appCode;
@end



//[NSURL URLWithString:@"http://app01.luoqi.com.cn/shopAdvertise/ShopAdvertise.asp?Name_Server=mabicn16&page=1&Row=10&SortType=0"]