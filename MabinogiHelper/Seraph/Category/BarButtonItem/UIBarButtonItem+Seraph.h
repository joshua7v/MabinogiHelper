//
//  UIBarButtonItem+Seraph.h
//  天平成绩查询
//
//  Created by Joshua on 14/12/9.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Seraph)
/**
 *  快速创建一个显示图片的item
 *
 *  @param action   监听方法
 */
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action;
@end
