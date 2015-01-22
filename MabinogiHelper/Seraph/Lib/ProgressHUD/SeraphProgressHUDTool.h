//
//  SeraphProgressHUD.h
//  Seraph
//
//  Created by Joshua on 14/12/8.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//  依赖于MBProgressHUD

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
@class SeraphProgressHUD;

@interface SeraphProgressHUDTool : NSObject
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (SeraphProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

+ (void)hideHUDForView:(UIView *)view;


@end

@interface SeraphProgressHUD : MBProgressHUD

@end
