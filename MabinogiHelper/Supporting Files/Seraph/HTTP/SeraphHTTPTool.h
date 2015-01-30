//
//  SeraphHTTPTool.h
//  Seraph
//
//  Created by Joshua on 14/12/6.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//  封装GET POST方法
//  依赖于AFNetworking

#import <Foundation/Foundation.h>

@interface SeraphHTTPTool : NSObject
/**
 *  获取一个页面的HTML 同步
 *
 *  @param requestURL 请求
 *
 *  @return 页面HTML
 */
+ (NSString *)getHTMLWithURL:(NSString *)requestURL;
/**
 *  获取一个页面的HTML 同步
 *
 *  @param requestURL 请求路径
 *  @param encoding   编码
 *
 *  @return 页面HTML
 */
+ (NSString *)getHTMLWithURL:(NSString *)requestURL encoding:(NSStringEncoding)encoding;
/**
 *  获取一个页面的HTML 异步
 *
 *  @param requestURL 请求路径
 *  @param success    请求成功后的回调
 *  @param failure    请求失败后的回调
 */
+ (void)getHTMLWithURL:(NSString *)requestURL success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
/**
 *  获取一个页面的HTML 异步
 *
 *  @param requestURL 请求路径
 *  @param encoding   编码
 *  @param success    请求成功后的回调
 *  @param failure    请求失败后的回调
 */
+ (void)getHTMLWithURL:(NSString *)requestURL encoding:(NSStringEncoding)encoding success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  发送一个GET请求 异步
 *
 *  @param requesturl   请求路径
 *  @param params       请求参数
 *  @param success      请求成功后的回调
 *  @param failure      请求失败后的回调
 */
+ (void)getWithURL:(NSString *)requestURL parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;


/**
 *  发送一个POST请求 异步
 *
 *  @param requestURL     请求路径
 *  @param params         请求参数
 *  @param success        请求成功后的回调
 *  @param failure        请求失败后的回调
 */
+ (void)postWithURL:(NSString *)requestURL parameters:(NSDictionary *)parameters success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

/**
 *  发送一个POST请求(上传文件数据) 异步
 *
 *  @param requestURL     请求路径
 *  @param filePath       上传的文件路径
 *  @param params         请求参数
 *  @param formData       文件参数
 *  @param success        请求成功后的回调
 *  @param failure        请求失败后的回调
 */
+ (void)postFileWithURL:(NSString *)requestURL parameters:(NSDictionary *)parameters formDataArray:(NSArray *)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure;
@end

/**
 *  用来封装文件数据的模型
 */
@interface SeraphFormData : NSObject
/**
 *  文件数据
 */
@property (nonatomic, strong) NSData *data;

/**
 *  参数名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  文件名
 */
@property (nonatomic, copy) NSString *filename;

/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mimeType;

@end
