//
//  MabiTrainslateTool.m
//  MabinogiHelper
//
//  Created by Joshua on 14/12/11.
//  Copyright  (c)2014年 SigmaStudio. All rights reserved.
//

#import "MabiTrainslateTool.h"

@interface MabiTrainslateTool ()

@end

@implementation MabiTrainslateTool

- (NSDictionary *)wordsDict
{
    if (_wordsDict == nil) {
        _wordsDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"map.plist" ofType:nil]];
    }
    return _wordsDict;
}

+ (MabiTrainslateTool *)trainslateTool
{
    return [[self alloc] init];
}

@end
