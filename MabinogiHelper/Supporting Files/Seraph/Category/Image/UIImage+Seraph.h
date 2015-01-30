//
//  UIImage+Seraph.h
//  MabinogiHelper
//
//  Created by Joshua on 14/12/12.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Seraph)
/**
 *  返回可自由拉伸图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;
+ (UIImage *)resizedImageWithName:(NSString *)name top:(float)top left:(float)left;
@end
