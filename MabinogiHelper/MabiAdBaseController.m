//
//  MabiAdBaseController.m
//  MabinogiHelper
//
//  Created by Joshua on 14/12/16.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import "MabiAdBaseController.h"
#import "MabiItemRequestParam.h"
#import "MabiItemImageRequestParam.h"
#import "MabiItem.h"
#import "MabiCommon.h"
#import "MJExtension.h"
#import "SeraphDBTool.h"

@interface MabiAdBaseController() <NSXMLParserDelegate>

@end

@implementation MabiAdBaseController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (MabiItemImageRequestParam *)imageRequestParam
{
    if (!_imageRequestParam) {
        _imageRequestParam = [[MabiItemImageRequestParam alloc] init];
    }
    return _imageRequestParam;
}

- (NSMutableArray *)mabiItems
{
    if (!_mabiItems) {
        _mabiItems = [NSMutableArray array];
    }
    return _mabiItems;
}

- (NSMutableArray *)mabiItemsImages
{
    if (!_mabiItemsImages) {
        _mabiItemsImages = [NSMutableArray array];
    }
    return _mabiItemsImages;
}

- (MabiItemRequestParam *)requestParam
{
    if (!_requestParam) {
        _requestParam = [[MabiItemRequestParam alloc] init];
    }
    return _requestParam;
}

- (void)getDataWithNameServer:(NSString *)nameServer page:(NSString *)page row:(NSString *)row sortType:(NSString *)sortType sortOption:(NSString *)sortOption searchType:(NSString *)searchType searchWord:(NSString *)searchWord appcode:(int)appcode
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    self.requestParam.Name_Server = nameServer;
    self.requestParam.page = page;
    self.requestParam.Name_Server = nameServer;
    self.requestParam.page = page;
    self.requestParam.row = row;
    self.requestParam.sortType = sortType;
    self.requestParam.sortOption = sortOption;
    self.requestParam.appCode = appcode;
    if (searchWord.length>0) {
        self.requestParam.searchWord = searchWord;
    } else {
        self.requestParam.searchWord = @"";
    }
    self.requestParam.searchType = searchType;
    NSString *urlString = [NSString stringWithFormat:@"http://app%02d.luoqi.com.cn/shopAdvertise/ShopAdvertise.asp?Name_Server=%@&page=%@&row=%@&sortType=%@&sortOption=%@&searchType=%@&searchWord=%@",self.requestParam.appCode, self.requestParam.Name_Server, self.requestParam.page, self.requestParam.row, self.requestParam.sortType, self.requestParam.sortOption, self.requestParam.searchType, self.requestParam.searchWord];
//    SeraphLog(@"%@", urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:10.0f];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
        
        parser.delegate = self;
        
        [parser parse];
    }];
}


#pragma mark - XML解析
/**
 *  开始解析
 */
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    
}

/**
 *  解析数据
 */
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    MabiItem *item = [[MabiItem alloc] init];
    MabiItemImageRequestParam *imageParam = [[MabiItemImageRequestParam alloc] init];
    
    [item setKeyValues:attributeDict];
    
    if (item.Item_Name.length) {
        NSString *hexColor1 = [NSString stringWithFormat:@"%08x", item.Item_Color1.intValue];
        NSString *hexColor2 = [NSString stringWithFormat:@"%08x", item.Item_Color2.intValue];
        NSString *hexColor3 = [NSString stringWithFormat:@"%08x", item.Item_Color3.intValue];
        
        imageParam.itemstr = [self getItemStrFromDBWithItemCode:item.Item_ClassId];
        imageParam.color1 = [hexColor1 substringFromIndex:2];
        imageParam.color2 = [hexColor2 substringFromIndex:2];
        imageParam.color3 = [hexColor3 substringFromIndex:2];
        imageParam.requestURL = [NSString stringWithFormat:@"http://rua.erinn.biz/itemimage2/files/%@/%@_%@_%@.gif", imageParam.itemstr, imageParam.color1, imageParam.color2, imageParam.color3];
        
        [self.mabiItems addObject:item];
        [self.mabiItemsImages addObject:imageParam];
    }
    
    //    SeraphLog(@"--- 开始节点 %@ %@", elementName, attributeDict);
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    //    SeraphLog(@"%@", string);
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    //    SeraphLog(@"----- end %@", elementName);
}

/**
 *  解析结束
 */
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    
    
    //    SeraphLog(@"解析结束------");
    [self afterDataParsed];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    //    SeraphLog(@"%@ 出错-----", parseError);
}

/**
 *  从数据库获取itemString
 */
- (NSString *)getItemStrFromDBWithItemCode:(NSString *)itemCode
{
    NSString *dbName = @"items.sqlite";
    NSString *dbPath = [[NSBundle mainBundle] pathForResource:dbName ofType:nil];
    SeraphDatabaseQueue *queue = [SeraphDBTool createDBQueueWithPath:dbPath];
    __block NSString *itemStr = @"";
    [queue inDatabase:^(FMDatabase *db) {
        SeraphDatabaseQueryResultSet *result = (SeraphDatabaseQueryResultSet *)[db executeQuery:@"SELECT ITEMSTR FROM T_ITEMS WHERE ITEMCODE=?", itemCode];
        while (result.next) {
            itemStr = [result stringForColumn:@"ITEMSTR"];
        }
    }];
    return itemStr;
}

- (void)afterDataParsed
{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.tableView reloadData];
//    });
}


@end
