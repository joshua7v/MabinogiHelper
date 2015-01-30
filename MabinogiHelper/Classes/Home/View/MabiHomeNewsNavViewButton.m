//
//  MabiHomeNewsNavViewButton.m
//  MabinogiHelper
//
//  Created by Joshua on 14/12/11.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import "MabiHomeNewsNavViewButton.h"

@implementation MabiHomeNewsNavViewButton

- (void)awakeFromNib
{
    // 初始化按钮设置
    self.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.imageView.contentMode = UIViewContentModeCenter;
    [self setTitleColor:SeraphColor(155, 155, 155) forState:UIControlStateNormal];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化按钮设置
        self.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:SeraphColor(155, 155, 155) forState:UIControlStateNormal];
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height - 15;
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleW = contentRect.size.width;
    CGFloat titleY = contentRect.size.height - 23;
    CGFloat titleH = 15;
    CGFloat titleX = 0;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (void)setHighlighted:(BOOL)highlighted {}

@end
