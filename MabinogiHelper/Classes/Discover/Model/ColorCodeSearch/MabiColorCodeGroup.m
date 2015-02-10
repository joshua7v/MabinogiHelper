//
//  MabiColorCodeGroup.m
//  MabinogiHelper
//
//  Created by Joshua on 15/2/10.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import "MabiColorCodeGroup.h"
#import "MabiColorCodeItem.h"
#import "MabiColorCodeMap.h"

@implementation MabiColorCodeGroup
- (void)setColorCodes:(NSArray *)colorCodes
{
    _colorCodes = colorCodes;
}

- (NSArray *)getColorCodeItems
{
    NSMutableArray *items = [NSMutableArray array];
    
    MabiColorCodeItem *item = nil;
    
    for (NSString *str in self.colorCodes) {
        item = [[MabiColorCodeItem alloc] init];
        item.colorCode = str;
        item.remarks = [MabiColorCodeMap getRemarksWithColorCode:str];
        
        [items addObject:item];
    }
    
    return items;
}
@end
