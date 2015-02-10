//
//  MabiColorCodeMap.h
//  MabinogiHelper
//
//  Created by Joshua on 15/2/10.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MabiColorCodeMap : NSObject
+ (NSString *)getRemarksWithColorCode:(NSString *)colorCode;
+ (NSArray *)getGroupColorCodesWithGroupTitle:(NSString *)groupTitle;
@end
