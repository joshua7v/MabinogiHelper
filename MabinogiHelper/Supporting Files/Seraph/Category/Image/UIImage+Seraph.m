//
//  UIImage+Seraph.m
//  MabinogiHelper
//
//  Created by Joshua on 14/12/12.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import "UIImage+Seraph.h"

@implementation UIImage (Seraph)
+ (UIImage *)resizedImageWithName:(NSString *)name
{
    return [self resizedImageWithName:name top:0.5 left:0.5];
}

+ (UIImage *)resizedImageWithName:(NSString *)name top:(float)top left:(float)left
{
    UIImage *image = [self imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}
@end
