//
//  MabiAdBaseController.h
//  MabinogiHelper
//
//  Created by Joshua on 14/12/16.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MabiItemRequestParam, MabiItemImageRequestParam, MJRefreshFooterView, MJRefreshHeaderView;

@interface MabiAdBaseController : UIViewController
/**
 *  请求参数模型
 */
@property (nonatomic, strong) MabiItemRequestParam *requestParam;
/**
 *  图片请求参数模型
 */
@property (nonatomic, strong) MabiItemImageRequestParam *imageRequestParam;
@property (nonatomic, strong) NSMutableArray *mabiItems;
@property (nonatomic, strong) NSMutableArray *mabiItemsImages;

/**
 *  请求服务器数据
 *
 *  @param nameServer 服务器名
 *  @param page       请求页面
 *  @param row        请求行数
 *  @param sortType   排序类型
 *  @param sortOption 排序选项
 *  @param searchType 查询类型
 *  @param searchWord 查询关键字
 *  @param appCode    服务器编号
 */
- (void)getDataWithNameServer:(NSString *)nameServer page:(NSString *)page row:(NSString *)row sortType:(NSString *)sortType sortOption:(NSString *)sortOption searchType:(NSString *)searchType searchWord:(NSString *)searchWord appcode:(int)appcode;

- (void)afterDataParsed;
@end
