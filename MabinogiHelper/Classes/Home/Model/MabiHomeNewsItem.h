//
//  MabiHomeNews.h
//  MabinogiHelper
//
//  Created by Joshua on 14/12/12.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MabiHomeNewsItem : NSObject
/**
 *  新闻时间
 */
@property (nonatomic, copy) NSString *time;
/**
 *  新闻标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  新闻分类
 */
@property (nonatomic, copy) NSString *category;
/**
 *  新闻链接
 */
@property (nonatomic, copy) NSString *href;
/**
 *  新闻数据(含HTML信息)
 */
@property (nonatomic, copy) NSString *rawContent;
@end
