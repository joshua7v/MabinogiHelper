//
//  MabiColorCodeItem.h
//  MabinogiHelper
//
//  Created by Joshua on 15/2/10.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MabiColorCodeItem : NSObject
/**
 *  颜色
 */
@property (nonatomic, strong) NSString *colorString;
/**
 *  颜色代码
 */
@property (nonatomic, strong) NSString *colorCode;
/**
 *  备注
 */
@property (nonatomic, strong) NSString *remarks;
@end
