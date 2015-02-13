//
//  MabiColorCodeSearchController.m
//  MabinogiHelper
//
//  Created by Joshua on 15/2/10.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//


#define MabiColorCodeSearchItem @"MabiColorCodeSearchItem"
#define MabiColorCodeSearchItemCell @"MabiColorCodeSearchItemCell"

#import "MabiColorCodeSearchController.h"
#import "MabiColorCodeSearchItemTableViewCell.h"
#import "MabiColorCodeItem.h"
#import "MabiColorCodeGroups.h"
#import "MabiColorCodeGroup.h"
#import "MabiCommon.h"

@interface MabiColorCodeSearchController() <UISearchBarDelegate, UITabBarDelegate, UITableViewDataSource, UIScrollViewDelegate>
//@property (weak, nonatomic) IBOutlet UISearchBar *colorSearchBar;
@property (weak, nonatomic) IBOutlet UITableView *colorTableView;

@property (nonatomic, strong) MabiColorCodeItem *colorCodeItem;
@property (nonatomic, strong) NSArray *colorCodeItems;
@property (nonatomic, strong) NSArray *colorCodeGroups;
@end

@implementation MabiColorCodeSearchController

- (NSArray *)colorCodeItems
{
    if (!_colorCodeItems) {
        _colorCodeItems = [NSArray array];
    }
    return _colorCodeItems;
}

- (NSArray *)colorCodeGroups
{
    if (!_colorCodeGroups) {
        _colorCodeGroups = [MabiColorCodeGroups getColorCodeGroups];
    }
    return _colorCodeGroups;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.colorTableView.backgroundColor = [UIColor colorWithHexString:@"F2F2F2"];
    
//    self.colorSearchBar.tintColor = [UIColor colorWithHexString:MabiThemeColorPink];
//    self.colorSearchBar.barTintColor = [UIColor colorWithHexString:MabiThemeColorPink];
//    self.colorSearchBar.hidden = YES;
   
    [self.colorTableView registerNib:[UINib nibWithNibName:MabiColorCodeSearchItem bundle:nil] forCellReuseIdentifier:MabiColorCodeSearchItemCell];
    
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    self.navigationController.navigationBar.hidden = YES;
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    
//    self.navigationController.navigationBar.hidden = NO;
//}
//
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    
//    [self.colorSearchBar becomeFirstResponder];
//}

#pragma mark - tableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.colorCodeGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MabiColorCodeGroup *group = self.colorCodeGroups[section];
    self.colorCodeItems = [group getColorCodeItems];
    return self.colorCodeItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MabiColorCodeSearchItemTableViewCell *cell = [MabiColorCodeSearchItemTableViewCell cellWithTableView:tableView];
    MabiColorCodeGroup *group = self.colorCodeGroups[indexPath.section];
    self.colorCodeItems = [group getColorCodeItems];
    MabiColorCodeItem *item = self.colorCodeItems[indexPath.row];
    cell.colorCodeItem = item;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    MabiColorCodeGroup *group = self.colorCodeGroups[section];
    return group.title;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSArray *titleIndexes = [MabiColorCodeGroups getTitleGroups];
    NSMutableArray *needed = [NSMutableArray array];
    for (NSString *str in titleIndexes) {
        [needed addObject:[str substringToIndex:1]];
    }
    return needed;
}

//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    [self.colorSearchBar resignFirstResponder];
//}

//- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar
//{
//    return UIBarPositionTopAttached;
//}

@end
