//
//  MabiHomeDetailController.m
//  MabinogiHelper
//
//  Created by Joshua on 14/12/12.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import "MabiSettingViewController.h"
#import "MabiSettingViewController.h"
#import "MabiSettingGroup.h"
#import "MabiSettingCell.h"
#import "MabiSettingArrowItem.h"
#import "MabiAdBoardController.h"
#import "MabiAboutViewController.h"
#import "MabiColorCodeSearchController.h"
//#import "MabiSettingCheckItem.h"
//#import "MabiSettingCheckGroup.h"

@interface MabiSettingViewController ()
@property (nonatomic, strong) MabiAdBaseController *mabiAdBoardController;
@property (nonatomic, strong) MabiAboutViewController *mabiAboutVC;
@property (nonatomic, strong) MabiColorCodeSearchController *mabiColorCodeSearchController;
@end

@implementation MabiSettingViewController

- (MabiAdBaseController *)mabiAdBoardController
{
    if (!_mabiAdBoardController) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MabiAdBoardController *adBoardController = [storyboard instantiateViewControllerWithIdentifier:@"MabiAdBoardController"];
        _mabiAdBoardController = adBoardController;
    }
    return _mabiAdBoardController;
}

- (MabiColorCodeSearchController *)mabiColorCodeSearchController
{
    if (!_mabiColorCodeSearchController) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MabiColorCodeSearchController *colorCodeSearchController = [storyboard instantiateViewControllerWithIdentifier:@"MabiColorCodeSearchController"];
        _mabiColorCodeSearchController = colorCodeSearchController;
    }
    return _mabiColorCodeSearchController;
}

- (MabiAboutViewController *)mabiAboutVC
{
    if (!_mabiAboutVC) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MabiAboutViewController *aboutController = [storyboard instantiateViewControllerWithIdentifier:@"MabiAboutViewController"];
        _mabiAboutVC = aboutController;
    }
    return _mabiAboutVC;
}

- (NSMutableArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (MabiSettingGroup *)addGroup
{
    MabiSettingGroup *group = [MabiSettingGroup group];
    [self.groups addObject:group];
    return group;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (id)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = SeraphColor(226, 226, 226);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.sectionHeaderHeight = 5;
    self.tableView.sectionFooterHeight = 30;
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MabiSettingGroup *group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MabiSettingCell *cell = [MabiSettingCell cellWithTableView:tableView];
    MabiSettingGroup *group = self.groups[indexPath.section];
    cell.item = group.items[indexPath.row];
    cell.indexPath = indexPath;
    return cell;
}

#pragma mark - 代理
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    MabiSettingGroup *group = self.groups[section];
    return group.footer;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    MabiSettingGroup *group = self.groups[section];
    return group.header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 取出模型
    MabiSettingGroup *group = self.groups[indexPath.section];
    MabiSettingItem *item = group.items[indexPath.row];
    
    // 执行操作
    if (item.operation) {
        item.operation();
    }
    
    // 有箭头就跳转
    if ([item isKindOfClass:[MabiSettingArrowItem class]]) {
        MabiSettingArrowItem *arrowItem = (MabiSettingArrowItem *)item;
        if (arrowItem.destVcClass) {
            UIViewController *destVc = [[arrowItem.destVcClass alloc] init];
            
            if (arrowItem.destVcClass == [MabiAdBoardController class]) {
                destVc = self.mabiAdBoardController;
            }
            if (arrowItem.destVcClass == [MabiAboutViewController class]) {
                destVc = self.mabiAboutVC;
            }
            if (arrowItem.destVcClass == [MabiColorCodeSearchController class]) {
                destVc = self.mabiColorCodeSearchController;
                destVc.title = @"颜色代码";
            }
            [self.navigationController pushViewController:destVc animated:YES];
        }
    }
}

@end
