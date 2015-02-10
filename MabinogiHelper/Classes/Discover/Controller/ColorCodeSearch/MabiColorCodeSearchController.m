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

@interface MabiColorCodeSearchController() <UISearchBarDelegate, UITabBarDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UISearchBar *colorSearchBar;
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
    
    [self.colorSearchBar becomeFirstResponder];
   
    [self.colorTableView registerNib:[UINib nibWithNibName:MabiColorCodeSearchItem bundle:nil] forCellReuseIdentifier:MabiColorCodeSearchItemCell];
    
}


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

@end
