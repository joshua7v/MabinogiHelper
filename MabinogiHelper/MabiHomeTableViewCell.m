//
//  MabiHomeTableViewCell.m
//  MabinogiHelper
//
//  Created by Joshua on 14/12/12.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import "MabiHomeTableViewCell.h"
#import "MabiHomeNewsItem.h"

@interface MabiHomeTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

@end

@implementation MabiHomeTableViewCell

/**
 *  拦截frame的设置
 */
- (void)setFrame:(CGRect)frame
{
    frame.origin.y += SeraphTableViewEdgeMargin;
    frame.origin.x = SeraphTableViewEdgeMargin;
    frame.size.width -= 2 * SeraphTableViewEdgeMargin;
    frame.size.height -= SeraphTableViewEdgeMargin;
    [super setFrame:frame];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"newsCell";
    MabiHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        // 从Xib加载 可重用
        UINib *nib = [UINib nibWithNibName:@"MabiHomeTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:ID];
        //        cell = [[[NSBundle mainBundle] loadNibNamed:@"SEDetailViewCell" owner:nil options:nil] lastObject];
        cell = [tableView dequeueReusableCellWithIdentifier:ID];
    }
    return cell;
}

- (void)displayItems:(MabiHomeNewsItem *)newsItem
{
    self.categoryLabel.text = newsItem.category;
    self.titleLabel.text = newsItem.title;
    self.timeLabel.text = newsItem.time;
}

- (void)setItem:(MabiHomeNewsItem *)item
{
    _item = item;
    [self displayItems:item];
}


@end
