//
//  UIBarButtonItem+Seraph.m
//  天平成绩查询
//
//  Created by Joshua on 14/12/9.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import "UIBarButtonItem+Seraph.h"

@implementation UIBarButtonItem (Seraph)
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
    button.frame = (CGRect){CGPointZero, button.currentBackgroundImage.size};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
@end
