//
//  MabiTaskCell.m
//  MabinogiHelper
//
//  Created by Joshua on 14/12/19.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import "MabiTaskCell.h"
#import "MabiStrategy.h"
#import "UIImageView+WebCache.h"

@interface MabiTaskCell()
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation MabiTaskCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
}

- (void)setStrategyItem:(MabiStrategy *)strategyItem
{
    _strategyItem = strategyItem;
    
    self.dateLabel.text = strategyItem.date;
    self.titleLabel.text = strategyItem.title;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:strategyItem.iconURL]];
}

@end
