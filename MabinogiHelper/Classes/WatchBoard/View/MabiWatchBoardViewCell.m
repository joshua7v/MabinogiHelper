//
//  MabiWatchBoardViewCell.m
//  MabinogiHelper
//
//  Created by Joshua on 14/12/11.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import "MabiWatchBoardViewCell.h"
#import "MabiToday.h"
#import "MabiSmuggle.h"
#import "MabiTrainslateTool.h"

@interface MabiWatchBoardViewCell()
@property (weak, nonatomic) IBOutlet UILabel *smuggleTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *smuggleLocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *smuggleItemLabel;
@property (nonatomic, strong) MabiTrainslateTool *trainslateTool;
@end

@implementation MabiWatchBoardViewCell
- (MabiTrainslateTool *)trainslateTool
{
    if (_trainslateTool == nil) {
        _trainslateTool = [[MabiTrainslateTool alloc] init];
    }
    return _trainslateTool;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"watchBoardCell";
    MabiWatchBoardViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        // 从Xib加载 可重用
        UINib *nib = [UINib nibWithNibName:@"MabiWatchBoardViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:ID];
        cell = [tableView dequeueReusableCellWithIdentifier:ID];
    }
    return cell;
}

//- (void)displayTodayItem:(MabiToday *)today
//{
//    self.todayTatingLabel.text = today.today.tating;
//    self.todayTaraLabel.text = today.today.tara;
//    self.vipTodayTatingLabel.text = today.vipToday.tating;
//    self.vipTodayTaraLabel.text = today.vipToday.tara;
//}
//
//- (void)displaySmuggleItem:(MabiSmuggleDetail *)smuggle
//{
//    self.smuggleTimeLabel1.text = smuggle.time;
//    self.smuggleLocationLabel1.text = [self.trainslateTool.wordsDict valueForKey:smuggle.location];
//    self.smuggleItemLabel1.text = [self.trainslateTool.wordsDict valueForKey:smuggle.item];
//}

- (void)displaySmuggleDetailItem:(MabiSmuggleDetail *)detailItem
{
    self.smuggleTimeLabel.text = detailItem.time;
    self.smuggleItemLabel.text = [self.trainslateTool.wordsDict valueForKey:detailItem.item];
    self.smuggleLocationLabel.text = [self.trainslateTool.wordsDict valueForKey:detailItem.location];
}

- (void)setToday:(MabiToday *)today
{
    _today = today;
    if (_today) {
//        [self displayTodayItem:_today];
    }
}

- (void)setSmuggle:(MabiSmuggle *)smuggle
{
    _smuggle = smuggle;
    MabiSmuggleDetail *item = _smuggle.detailArray[0];
    if (item) {
//        [self displaySmuggleItem:item];
    }
}

- (void)setSmuggleDetailItem:(MabiSmuggleDetail *)smuggleDetailItem
{
    _smuggleDetailItem = smuggleDetailItem;
    if (_smuggleDetailItem) {
        [self displaySmuggleDetailItem:_smuggleDetailItem];
    }
}

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

@end
