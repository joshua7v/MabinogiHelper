//
//  MabiTabBarButton.m
//  MabinogiHelper
//
//  Created by Joshua on 14/12/12.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//


#define MabiTabBarButtonImageRatio 0.6

#import "MabiTabBarButton.h"
#import "MabiBadgeButton.h"

@interface MabiTabBarButton()
@property (nonatomic, weak) MabiBadgeButton *badgeButton;
@end

@implementation MabiTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        // 添加提醒按钮
        MabiBadgeButton *badgeButton = [[MabiBadgeButton alloc] init];
        [self addSubview:badgeButton];
        badgeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        self.badgeButton = badgeButton;
        
    }
    return self;
}

- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    // 监听属性改变
    [self addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [self addObserver:self forKeyPath:@"title" options:0 context:nil];
    [self addObserver:self forKeyPath:@"image" options:0 context:nil];
    [self addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}

/**
 *  监听到某个对象属性改变会调用
 *
 *  @param keyPath 属性名
 *  @param object  对象
 *  @param change  属性发生的改变
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setTitle:self.item.title forState:UIControlStateNormal];
    [self setTitle:self.item.title forState:UIControlStateSelected];
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    
    // 设置按钮提醒
    self.badgeButton.badgeValue = self.item.badgeValue;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"badgeValue"];
    [self removeObserver:self forKeyPath:@"title"];
    [self removeObserver:self forKeyPath:@"image"];
    [self removeObserver:self forKeyPath:@"selectedImage"];
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * MabiTabBarButtonImageRatio;
    CGFloat imageX = 0;
    CGFloat iamgeY = 0;
    
    return CGRectMake(imageX, iamgeY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleW = contentRect.size.width;
    CGFloat titleY = contentRect.size.height * MabiTabBarButtonImageRatio;
    CGFloat titleH = contentRect.size.height - titleY;
    CGFloat titleX = 0;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (void)setHighlighted:(BOOL)highlighted {}

@end