//
//  MabiColorCodeGroup.h
//  MabinogiHelper
//
//  Created by Joshua on 15/2/10.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MabiColorCodeGroup : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *colorCodes;
- (NSArray *)getColorCodeItems;
@end
