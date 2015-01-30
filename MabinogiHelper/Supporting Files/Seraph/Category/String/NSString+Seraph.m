//
//  NSString+Seraph.m
//  MabinogiHelper
//
//  Created by Joshua on 14/12/16.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import "NSString+Seraph.h"

@implementation NSString (Seraph)
+ (NSString *)moneyFormatStringWithString:(NSString *)srcString
{
    int money = [srcString intValue];
    int wan = money / 10000;
    int belowWan = money - wan * 10000;
    if (wan) {
        if (belowWan) {
            return [NSString stringWithFormat:@"%d万%d", wan, belowWan];
        } else {
            return [NSString stringWithFormat:@"%d万", wan];
        }
    } else {
        return [NSString stringWithFormat:@"%d", belowWan];
    }
    
}
@end
