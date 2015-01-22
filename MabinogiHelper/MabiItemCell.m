//
//  MabiItemCell.m
//  MabinogiHelper
//
//  Created by Joshua on 14/12/15.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import "MabiItemCell.h"
#import "MabiItem.h"
#import "UIColor+Seraph.h"
#import "UIImageView+WebCache.h"
#import "NSString+Seraph.h"

@interface MabiItemCell()
@property (weak, nonatomic) IBOutlet UILabel *sellerLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIView *color1VIew;
@property (weak, nonatomic) IBOutlet UIView *color2VIew;
@property (weak, nonatomic) IBOutlet UIView *color3View;
@property (weak, nonatomic) IBOutlet UILabel *color1Label;
@property (weak, nonatomic) IBOutlet UILabel *color2Label;
@property (weak, nonatomic) IBOutlet UILabel *color3Label;
@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;

@end

@implementation MabiItemCell

- (void)awakeFromNib
{
    self.color1Label.font = [UIFont fontWithName:@"MONACO" size:10];
    self.color2Label.font = [UIFont fontWithName:@"MONACO" size:10];
    self.color3Label.font = [UIFont fontWithName:@"MONACO" size:10];
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

/**
 *  拦截frame的设置
 */
- (void)setFrame:(CGRect)frame
{
//    frame.origin.y += SeraphTableViewEdgeMargin;
    frame.origin.x = SeraphTableViewEdgeMargin;
    frame.size.width -= 2 * SeraphTableViewEdgeMargin;
    frame.size.height -= SeraphTableViewEdgeMargin;
    [super setFrame:frame];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"MabiItemCell";
    MabiItemCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        // 从Xib加载 可重用
        UINib *nib = [UINib nibWithNibName:@"MabiItemCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:ID];
        //        cell = [[[NSBundle mainBundle] loadNibNamed:@"SEDetailViewCell" owner:nil options:nil] lastObject];
        cell = [tableView dequeueReusableCellWithIdentifier:ID];
    }
    return cell;
}

- (void)displayItems:(MabiItem *)item
{
    NSString *hexColor1 = [NSString stringWithFormat:@"%08x", item.Item_Color1.intValue];
    NSString *hexColor2 = [NSString stringWithFormat:@"%08x", item.Item_Color2.intValue];
    NSString *hexColor3 = [NSString stringWithFormat:@"%08x", item.Item_Color3.intValue];
    NSString *money = [NSString moneyFormatStringWithString:item.Item_Price];
    
    self.sellerLabel.text = item.Char_Name;
    self.priceLabel.text = money;
    self.color1Label.text = hexColor1.uppercaseString;
    self.color2Label.text = hexColor2.uppercaseString;
    self.color3Label.text = hexColor3.uppercaseString;
    self.color1VIew.backgroundColor = [UIColor colorWithHexString:[hexColor1 substringFromIndex:2]];
    self.color2VIew.backgroundColor = [UIColor colorWithHexString:[hexColor2 substringFromIndex:2]];
    self.color3View.backgroundColor = [UIColor colorWithHexString:[hexColor3 substringFromIndex:2]];
    self.itemNameLabel.text = item.Item_Name;
    self.countLabel.text = item.Count;
}

- (void)setItem:(MabiItem *)item
{
    _item = item;
    [self displayItems:item];
}

- (void)setImageRequestURL:(NSString *)imageRequestURL
{
    _imageRequestURL = imageRequestURL;
    
    [self.itemImageView sd_setImageWithURL:[NSURL URLWithString:_imageRequestURL]];
}

@end
