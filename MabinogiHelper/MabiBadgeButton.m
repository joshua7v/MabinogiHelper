//
//  MabiBadgeButton.m
//  MabinogiHelper
//
//  Created by Joshua on 14/11/30.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import "MabiBadgeButton.h"
#import "UIImage+Seraph.h"

@implementation MabiBadgeButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        [self setBackgroundImage:[UIImage resizedImageWithName:@"main_badge"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:11];
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = badgeValue;
    
    if (badgeValue) {
        self.hidden = NO;
        // 设置文字
        [self setTitle:badgeValue forState:UIControlStateNormal];
        // 设置frame
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        CGFloat badgeY = 0;
        
        if (badgeValue.length > 1) {
            CGSize badgeSize = [badgeValue sizeWithFont:self.titleLabel.font];
            badgeW = badgeSize.width + 10;
        }
        CGFloat badgeX = self.frame.size.width - badgeW - 7;
        self.frame = CGRectMake(badgeX, badgeY, badgeW, badgeH);
    } else {
        self.hidden = YES;
    }
}


@end
