//
//  MabiHomeViewController.m
//  MabinogiHelper
//
//  Created by Joshua on 14/12/11.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#define MabiHomeNewsErrorMessage @"网络好像连不上呢"

#import "MabiHomeViewController.h"
#import "MabiHomeNewsNavView.h"
#import "MabiHomeNewsNavViewButton.h"
#import "MabiHomeNewsDataTool.h"
#import "MabiHomeNewsItem.h"
#import "MabiHomeTableViewCell.h"
#import "MJRefresh.h"
#import "MabiHomeDetailController.h"
#import "SeraphProgressHUDTool.h"
#import "MabiSettingController.h"

@interface MabiHomeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *newsAllItems;
@property (nonatomic, strong) NSMutableArray *newsGameItems;
@property (nonatomic, strong) NSMutableArray *newsCampaignItems;
@property (nonatomic, strong) NSMutableArray *newsSystemItems;
@property (nonatomic, strong) NSMutableArray *newsItems;
@property (weak, nonatomic) IBOutlet MabiHomeNewsNavView *newsNavView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet MabiHomeNewsNavViewButton *newsAllBtn;
@property (weak, nonatomic) IBOutlet MabiHomeNewsNavViewButton *newsGameBtn;
@property (weak, nonatomic) IBOutlet MabiHomeNewsNavViewButton *newsCampaignBtn;
@property (weak, nonatomic) IBOutlet MabiHomeNewsNavViewButton *newsSystemBtn;
//@property (nonatomic, weak) MJRefreshFooterView *footer;
//@property (nonatomic, weak) MJRefreshHeaderView *header;
@property (nonatomic, assign) MabiHomeNewsDataType newsDataType;
@property (nonatomic, assign) int dataPageIndex;

- (IBAction)newsAllBtnDidClicked;
- (IBAction)newsGameBtnDidClicked;
- (IBAction)newsCampaignBtnClicked;
- (IBAction)newsSystemBtnDidClicked;

@end

@implementation MabiHomeViewController
- (MabiHomeNewsDataType)newsDataType
{
    if (!_newsDataType) {
        _newsDataType = MabiHomeNewsDataTypeAll;
    }
    return _newsDataType;
}

- (NSMutableArray *)newsAllItems
{
    if (!_newsAllItems) {
        _newsAllItems = [[[MabiHomeNewsDataTool sharedHomeNewsDataTool] getDataFromDBWithType:MabiHomeNewsDataTypeAll] mutableCopy];
    }
    return _newsAllItems;
}

- (NSMutableArray *)newsGameItems
{
    if (!_newsGameItems) {
        _newsGameItems = [[[MabiHomeNewsDataTool sharedHomeNewsDataTool] getDataFromDBWithType:MabiHomeNewsDataTypeGame] mutableCopy];
    }
    return _newsGameItems;
}

- (NSMutableArray *)newsCampaignItems
{
    if (!_newsCampaignItems) {
        _newsCampaignItems = [[[MabiHomeNewsDataTool sharedHomeNewsDataTool] getDataFromDBWithType:MabiHomeNewsDataTypeCampaign] mutableCopy];
    }
    return _newsCampaignItems;
}

- (NSMutableArray *)newsSystemItems
{
    if (!_newsSystemItems) {
        _newsSystemItems = [[[MabiHomeNewsDataTool sharedHomeNewsDataTool] getDataFromDBWithType:MabiHomeNewsDataTypeSystem] mutableCopy];
    }
    return _newsSystemItems;
}

- (NSMutableArray *)newsItems
{
    if (!_newsItems) {
        _newsItems = [NSMutableArray array];
    }
    return _newsItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始设定
    [self setup];
    
    // 进入刷新
    if (!self.newsAllItems.count) {
        [self.tableView headerBeginRefreshing];
    }
}

/**
 *  初始设定
 */
- (void)setup
{
    self.dataPageIndex = 1;
    
    [self.tableView addHeaderWithTarget:self action:@selector(refreshViewHeaderViewBeginRefresh)];
    [self.tableView addFooterWithTarget:self action:@selector(refreshViewFooterViewBeginRefresh)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"setting"] style:UIBarButtonItemStylePlain target:self action:@selector(setting)];
    
}

- (void)setting
{
    [self.navigationController pushViewController:[[MabiSettingController alloc] init] animated:YES];
}

/**
 *  刷新控件进入开始刷新状态时调用
 */
- (void)refreshViewHeaderViewBeginRefresh
{
    [self.tableView reloadData];
    __block int statusCode = 0;
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    __block BOOL haveData = YES;
    NSBlockOperation *getNewData = [NSBlockOperation blockOperationWithBlock:^{
        // 下拉刷新
        if (self.newsDataType == MabiHomeNewsDataTypeAll) {
            self.newsAllItems = [[MabiHomeNewsDataTool sharedHomeNewsDataTool] getHomeNewsData:MabiHomeNewsDataTypeAll index:1 statusCode:&statusCode];
            if (!self.newsAllItems.count) {
                haveData = NO;
            }
        } else if (self.newsDataType == MabiHomeNewsDataTypeGame) {
            self.newsGameItems = [[MabiHomeNewsDataTool sharedHomeNewsDataTool] getHomeNewsData:MabiHomeNewsDataTypeGame index:1 statusCode:&statusCode];
            if (!self.newsGameItems.count) {
                haveData = NO;
            }
        } else if (self.newsDataType == MabiHomeNewsDataTypeCampaign) {
            self.newsCampaignItems = [[MabiHomeNewsDataTool sharedHomeNewsDataTool] getHomeNewsData:MabiHomeNewsDataTypeCampaign index:1 statusCode:&statusCode];
            if (!self.newsCampaignItems.count) {
                haveData = NO;
            }
        } else if (self.newsDataType == MabiHomeNewsDataTypeSystem) {
            self.newsSystemItems = [[MabiHomeNewsDataTool sharedHomeNewsDataTool] getHomeNewsData:MabiHomeNewsDataTypeSystem index:1 statusCode:&statusCode];
            if (!self.newsSystemItems.count) {
                haveData = NO;
            }
        }
    }];
    
    NSBlockOperation *getNewDataFinished = [NSBlockOperation blockOperationWithBlock:^{
        if (!haveData || statusCode) {
            [SeraphProgressHUDTool showError:MabiHomeNewsErrorMessage toView:self.navigationController.view];
        }
        self.dataPageIndex = 1;
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        [self.tableView headerEndRefreshing];
        [self.tableView reloadData];
    }];
    
    [getNewDataFinished addDependency:getNewData];
    [queue addOperation:getNewData];
    [[NSOperationQueue mainQueue] addOperation:getNewDataFinished];
}

- (void)refreshViewFooterViewBeginRefresh
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    // 上拉刷新
    __block NSArray *array = nil;
    NSBlockOperation *getMoreData = [NSBlockOperation blockOperationWithBlock:^{
        self.dataPageIndex++;
        if (self.newsDataType == MabiHomeNewsDataTypeAll) {
            array = [[MabiHomeNewsDataTool sharedHomeNewsDataTool] getHomeNewsData:MabiHomeNewsDataTypeAll index:self.dataPageIndex statusCode:0];
            [self.newsAllItems addObjectsFromArray:array];
        } else if (self.newsDataType == MabiHomeNewsDataTypeGame) {
            array = [[MabiHomeNewsDataTool sharedHomeNewsDataTool] getHomeNewsData:MabiHomeNewsDataTypeGame index:self.dataPageIndex statusCode:0];
            [self.newsGameItems addObjectsFromArray:array];
        } else if (self.newsDataType == MabiHomeNewsDataTypeCampaign) {
            array = [[MabiHomeNewsDataTool sharedHomeNewsDataTool] getHomeNewsData:MabiHomeNewsDataTypeCampaign index:self.dataPageIndex statusCode:0];
            [self.newsCampaignItems addObjectsFromArray:array];
        } else if (self.newsDataType == MabiHomeNewsDataTypeSystem) {
            array = [[MabiHomeNewsDataTool sharedHomeNewsDataTool] getHomeNewsData:MabiHomeNewsDataTypeSystem index:self.dataPageIndex statusCode:0];
            [self.newsSystemItems addObjectsFromArray:array];
        }
    }];
    
    NSBlockOperation *getMoreDataFinished = [NSBlockOperation blockOperationWithBlock:^{
        if (!array.count) {
            [SeraphProgressHUDTool showError:MabiHomeNewsErrorMessage toView:self.navigationController.view];
        }
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        [self.tableView footerEndRefreshing];
        [self.tableView reloadData];
    }];
    
    [getMoreDataFinished addDependency:getMoreData];
    [queue addOperation:getMoreData];
    [[NSOperationQueue mainQueue] addOperation:getMoreDataFinished];
    [self.tableView reloadData];
}


- (IBAction)newsAllBtnDidClicked {
    self.newsDataType = MabiHomeNewsDataTypeAll;
    if (self.newsAllItems.count) {
        [self.tableView reloadData];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [self.tableView setScrollsToTop:YES];
    } else {
        [self.tableView headerBeginRefreshing];
    }
}

- (IBAction)newsGameBtnDidClicked {
    self.newsDataType = MabiHomeNewsDataTypeGame;
    if (self.newsGameItems.count) {
        [self.tableView reloadData];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [self.tableView setScrollsToTop:YES];
    } else {
        [self.tableView headerBeginRefreshing];
    }
}

- (IBAction)newsCampaignBtnClicked {
    self.newsDataType = MabiHomeNewsDataTypeCampaign;
    if (self.newsCampaignItems.count) {
        [self.tableView reloadData];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [self.tableView setScrollsToTop:YES];
    } else {
        [self.tableView headerBeginRefreshing];
    }
}

- (IBAction)newsSystemBtnDidClicked {
    self.newsDataType = MabiHomeNewsDataTypeSystem;
    if (self.newsSystemItems.count) {
        [self.tableView reloadData];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [self.tableView setScrollsToTop:YES];
    } else {
        [self.tableView headerBeginRefreshing];
    }
}

- (void)setupNewsItemsWithType
{
    if (self.newsDataType == MabiHomeNewsDataTypeAll) {
        self.newsItems = self.newsAllItems;
    } else if (self.newsDataType == MabiHomeNewsDataTypeGame) {
        self.newsItems = self.newsGameItems;
    } else if (self.newsDataType == MabiHomeNewsDataTypeCampaign) {
        self.newsItems = self.newsCampaignItems;
    } else if (self.newsDataType == MabiHomeNewsDataTypeSystem) {
        self.newsItems = self.newsSystemItems;
    }
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self setupNewsItemsWithType];
    if (!self.newsItems.count) return 0;
    return self.newsItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self setupNewsItemsWithType];
    MabiHomeTableViewCell *cell = [MabiHomeTableViewCell cellWithTableView:tableView];
    if (!self.newsItems.count) return cell;
    cell.item = self.newsItems[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

/**
 *  选择tableview的cell
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 取出当前那条数据
    MabiHomeNewsItem *currentItem = self.newsItems[indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MabiHomeDetailController *detailController = [storyboard instantiateViewControllerWithIdentifier:@"MabiHomeDetailController"];
    detailController.currentitem = currentItem;
    [self.navigationController pushViewController:detailController animated:YES];
    
    // 选中cell的背景恢复
    MabiHomeTableViewCell *cell = (MabiHomeTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
}

@end
