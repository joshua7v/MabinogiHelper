//
//  MabiHomeViewController.h
//  MabinogiHelper
//
//  Created by Joshua on 14/12/11.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MabiSettingGroup : NSObject
@property (copy, nonatomic) NSString *header;
@property (copy, nonatomic) NSString *footer;
@property (strong, nonatomic) NSArray *items;

+ (instancetype)group;
@end
