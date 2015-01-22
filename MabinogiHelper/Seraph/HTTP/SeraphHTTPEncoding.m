//
//  SeraphHTTPEncoding.m
//  MabinogiHelper
//
//  Created by Joshua on 14/12/12.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import "SeraphHTTPEncoding.h"

@implementation SeraphHTTPEncoding

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

+ (SeraphHTTPStringEncoding)SeraphHTTPStringEncodingGB2312
{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
    return enc;
}

@end
