//
//  MabiTrainslateTool.h
//  MabinogiHelper
//
//  Created by Joshua on 14/12/11.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MabiTrainslateTool : NSObject
@property (nonatomic, strong) NSDictionary *wordsDict;
+ (MabiTrainslateTool *)trainslateTool;
@end
