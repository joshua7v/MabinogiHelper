//
//  UIImage+MabiTheme.h
//  MabinogiHelper
//
//  Created by Joshua on 15/1/5.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MabiTheme)
/**
 *  返回带主题色后缀的图片
 */
+ (UIImage *)imageNamed:(NSString *)name withThemeSuffix:(NSString *)suffix;
@end
