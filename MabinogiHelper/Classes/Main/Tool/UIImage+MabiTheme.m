//
//  UIImage+MabiTheme.m
//  MabinogiHelper
//
//  Created by Joshua on 15/1/5.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import "UIImage+MabiTheme.h"

@implementation UIImage (MabiTheme)

+ (UIImage *)imageNamed:(NSString *)name withThemeSuffix:(NSString *)suffix
{
    name = [name stringByAppendingString:suffix];
    return [self imageNamed:name];
}

@end
