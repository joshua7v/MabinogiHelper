//
//  MabiSettingCell.m
//  ItcastWeibo
//
//  Created by apple on 14-5-23.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#define MabiDividerInset 10

#import "MabiSettingCell.h"
#import "MabiSettingItem.h"
#import "MabiSettingArrowItem.h"
#import "MabiSettingSwitchItem.h"
#import "MabiSettingLabelItem.h"
#import "MabiBadgeButton.h"

@interface MabiSettingCell()
/**
 *  箭头
 */
@property (strong, nonatomic) UIImageView *arrowView;
/**
 *  开关
 */
@property (strong, nonatomic) UISwitch *switchView;
/**
 *  提醒数字
 */
@property (strong, nonatomic) MabiBadgeButton *badgeButton;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) UIImageView *bgView;
@property (nonatomic, weak) UIImageView *selectedBgView;
@end

@implementation MabiSettingCell
- (UISwitch *)switchView
{
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc] init];
    }
    return _switchView;
}

- (UIImageView *)arrowView
{
    if (_arrowView == nil) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
    }
    return _arrowView;
}

- (MabiBadgeButton *)badgeButton
{
    if (_badgeButton == nil) {
        _badgeButton = [[MabiBadgeButton alloc] init];
    }
    return _badgeButton;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"setting";
    MabiSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MabiSettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.tableView = tableView;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        // 标题
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor blackColor];
        self.textLabel.highlightedTextColor = self.textLabel.textColor;
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];
        
        // 创建背景
        UIImageView *bgView = [[UIImageView alloc] init];
        self.backgroundView = bgView;
        self.bgView = bgView;
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    if (iOS7) {
        frame.origin.x = 5;
        frame.size.width -= 10;
    }
    [super setFrame:frame];
}

- (void)setItem:(MabiSettingItem *)item
{
    _item = item;
    
    // 1.设置数据
    [self setupData];
    
    // 2.设置右边的控件
    [self setupRightView];
}

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    
    self.backgroundColor = [UIColor whiteColor];
    
    // 设置背景的图片
//    int totalRows = [self.tableView numberOfRowsInSection:indexPath.section];
//    NSString *bgName = nil;
//    NSString *selectedBgName = nil;
//    if (totalRows == 1) { // 这组就1行
//        bgName = @"common_setting_bg";
//        selectedBgName = @"common_setting_bg";
//    } else if (indexPath.row == 0) { // 首行
//        bgName = @"common_setting_bg";
//        selectedBgName = @"common_setting_bg";
//    } else if (indexPath.row == totalRows - 1) { // 尾行
//        bgName = @"common_setting_bg";
//        selectedBgName = @"common_setting_bg";
//    } else { // 中行
//        bgName = @"common_setting_bg";
//        selectedBgName = @"common_setting_bg";
//    }
//    self.bgView.image = [UIImage resizedImageWithName:bgName];
//    self.selectedBgView.image = [UIImage resizedImageWithName:selectedBgName];
}

/**
 *  设置数据
 */
- (void)setupData
{
    // 1.图标
    if (self.item.icon) {
        self.imageView.image = [UIImage imageNamed:self.item.icon];
    }
    
    // 2.标题
    self.textLabel.text = self.item.title;
}

/**
 *  设置右边的控件
 */
- (void)setupRightView
{
    if (self.item.badgeValue) {
        self.badgeButton.badgeValue = self.item.badgeValue;
        self.accessoryView = self.badgeButton;
    } else if ([self.item isKindOfClass:[MabiSettingSwitchItem class]])
    { // 右边是开关
        self.accessoryView = self.switchView;
    }
    else if ([self.item isKindOfClass:[MabiSettingArrowItem class]])
    { // 右边是箭头
        self.accessoryView = self.arrowView;
    }
    else { // 右边没有东西
        self.accessoryView = nil;
    }
}

@end
