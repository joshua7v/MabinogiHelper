//
//  SeraphHTMLParser.m
//  天平成绩查询
//
//  Created by Joshua on 14/12/7.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import "SeraphHTMLParser.h"
#import "HTMLParser.h"

@implementation SeraphHTMLParser

+ (Parser *)parserWithHTMLString:(NSString *)HTMLString error:(NSError *__autoreleasing *)error
{
    return (Parser *)[[HTMLParser alloc] initWithString:HTMLString error:error];
}

@end
