//
//  SeraphHTTPTool.m
//  Seraph
//
//  Created by Joshua on 14/12/6.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SeraphHTTPTool.h"
#import "AFNetworking.h"

@implementation SeraphHTTPTool

+ (NSString *)getHTMLWithURL:(NSString *)requestURL
{
    return [self getHTMLWithURL:requestURL encoding:NSUTF8StringEncoding];
}

+ (NSString *)getHTMLWithURL:(NSString *)requestURL encoding:(NSStringEncoding)encoding
{
    NSURL *url = [NSURL URLWithString:requestURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSError *error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    NSString *result = [[NSString alloc] initWithData:data encoding:encoding];
    return result;
}

+ (void)getHTMLWithURL:(NSString *)requestURL success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSURL *url = [NSURL URLWithString:requestURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            if (failure) {
                failure(connectionError);
            }
        } else {
            if (success) {
                NSString *res = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                
                success(res);
            }
        }
    }];
}

+ (void)getHTMLWithURL:(NSString *)requestURL encoding:(NSStringEncoding)encoding success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSURL *url = [NSURL URLWithString:requestURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            if (failure) {
                failure(connectionError);
            }
        } else {
            if (success) {
                NSString *res = [[NSString alloc] initWithData:data encoding:encoding];
                
                success(res);
            }
        }
    }];
}

+ (void)getWithURL:(NSString *)requestURL parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 发送请求
    [mgr GET:requestURL parameters:parameters
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         if (success) {
             success(responseObject);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failure) {
             failure(error);
         }
     }];
}

+ (void)postWithURL:(NSString *)requestURL parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 发送请求
    [mgr POST:requestURL parameters:parameters
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          if (success) {
              success(responseObject);
          }
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if (failure) {
              failure(error);
          }
      }];
}

+ (void)postFileWithURL:(NSString *)requestURL parameters:(NSDictionary *)parameters formDataArray:(NSArray *)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    [mgr POST:requestURL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> totalFormData) {
        for (SeraphFormData *formData in formDataArray) {
            [totalFormData appendPartWithFileData:formData.data name:formData.name fileName:formData.filename mimeType:formData.mimeType];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}




@end

/**
 *  用来封装文件数据的模型
 */
@implementation SeraphFormData

@end

