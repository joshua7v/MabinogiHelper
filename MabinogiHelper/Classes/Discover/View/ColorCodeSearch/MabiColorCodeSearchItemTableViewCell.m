//
//  MabiColorCodeSearchItemTableViewCell.m
//  MabinogiHelper
//
//  Created by Joshua on 15/2/10.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#define MabiColorCodeSearchItem @"MabiColorCodeSearchItem"
#define MabiColorCodeSearchItemCell @"MabiColorCodeSearchItemCell"

#import "MabiColorCodeSearchItemTableViewCell.h"
#import "MabiColorCodeItem.h"

@interface MabiColorCodeSearchItemTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *colorCodeTextField;
@property (weak, nonatomic) IBOutlet UILabel *colorRemarksTextField;

@end

@implementation MabiColorCodeSearchItemTableViewCell

- (void)setColorCodeItem:(MabiColorCodeItem *)colorCodeItem
{
    _colorCodeItem = colorCodeItem;
    _colorCodeTextField.text = colorCodeItem.colorCode;
    _colorRemarksTextField.text = colorCodeItem.remarks;
    _iconView.backgroundColor = [UIColor colorWithHexString:[colorCodeItem.colorCode substringFromIndex:2]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    MabiColorCodeSearchItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MabiColorCodeSearchItemCell];
    if (cell == nil) {
        // 从Xib加载 可重用
        UINib *nib = [UINib nibWithNibName:MabiColorCodeSearchItem bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:MabiColorCodeSearchItemCell];
        //        cell = [[[NSBundle mainBundle] loadNibNamed:@"SEDetailViewCell" owner:nil options:nil] lastObject];
        cell = [tableView dequeueReusableCellWithIdentifier:MabiColorCodeSearchItemCell];
    }
    
    
    
    return cell;
}

@end
