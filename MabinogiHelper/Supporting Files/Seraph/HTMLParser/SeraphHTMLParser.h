//
//  SeraphHTMLParser.h
//  天平成绩查询
//
//  Created by Joshua on 14/12/7.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//  HTML解析器 依赖于HTMLParser

#import <Foundation/Foundation.h>
#import "HTMLParser.h"
@class Parser;

@interface SeraphHTMLParser : NSObject

+ (Parser *)parserWithHTMLString:(NSString *)HTMLString error:(NSError **)error;

@end


@interface Parser : HTMLParser

@end