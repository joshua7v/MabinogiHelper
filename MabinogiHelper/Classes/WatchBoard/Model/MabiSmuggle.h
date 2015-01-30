//
//  MabiSmuggle.h
//  MabinogiHelper
//
//  Created by Joshua on 14/12/11.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MabiSmuggleDetail.h"

@interface MabiSmuggle : NSObject
@property (nonatomic, strong) MabiSmuggleDetail *smuggleDetailItem;
@property (nonatomic, strong) NSMutableArray *detailArray;
@property (nonatomic, copy) NSString *date;
@end
