//
//  MabiAdMaryController.m
//  MabinogiHelper
//
//  Created by Joshua on 14/12/15.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//



#import "MabiAdBoardController.h"
#import "SeraphHTTPTool.h"
#import "MabiItem.h"
#import "MJExtension.h"
#import "MabiItemCell.h"
#import "MabiItemRequestParam.h"
#import "MabiItemImageRequestParam.h"
#import "SeraphDBTool.h"
#import "MJRefresh.h"
#import "SeraphHTTPEncoding.h"
#import "MabiCommon.h"
#import "MabiAdBoardTableView.h"
#import "MabiTabBar.h"
#import "MabiAdPanelView.h"

@interface MabiAdBoardController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet MabiAdPanelView *sortPanelView;
@property (weak, nonatomic) IBOutlet MabiAdBoardTableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *priceAscOrDescBtn;
@property (weak, nonatomic) IBOutlet UITextField *searchWordTextField;
@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet UIView *barView;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
- (IBAction)moreBtnDidClicked:(id)sender;
- (IBAction)priceAscOrDescBtnDidClicked:(UIButton *)sender;
- (IBAction)maryBtnDidClicked;
- (IBAction)lulaliBtnDidClicked;
- (IBAction)piailuoBtnDidClicked;
- (IBAction)samalaBtnDidClicked;
- (IBAction)yiwenBtnDidClicked;
- (IBAction)lunaBtnDidClicked;

@property (nonatomic, copy) NSString *sortType;
@property (nonatomic, copy) NSString *sortOption;
@property (nonatomic, copy) NSString *searchType;
@property (nonatomic, copy) NSString *searchWord;
@property (nonatomic, copy) NSString *nameServer;
@property (nonatomic, copy) NSString *row;
@property (nonatomic, copy) NSString *page;
@property (nonatomic, assign) int appCode;
@property (nonatomic, copy) NSString *suffix;
//@property (nonatomic, weak) MabiAdBoardTableView *tableView;

@end

@implementation MabiAdBoardController
- (NSString *)sortType
{
    if (!_sortType) {
        _sortType = [MabiParamMap MabiAdItemSortTypeDefault];
    }
    return _sortType;
}

- (NSString *)sortOption
{
    if (!_sortOption) {
        _sortOption = [MabiParamMap MabiAdItemSortOptionDefault];
    }
    return _sortOption;
}

- (NSString *)searchType
{
    if (!_searchType) {
        _searchType = [MabiParamMap MabiAdItemSearchTypeItemName];
    }
    return _searchType;
}

- (NSString *)searchWord
{
    if (!_searchWord) {
        _searchWord = @"";
    }
    return _searchWord;
}

- (NSString *)nameServer
{
    if (!_nameServer) {
        _nameServer = [MabiParamMap MabiAdItemNameServerMaryCN];
    }
    return _nameServer;
}

- (NSString *)row
{
    if (!_row) {
        _row = [[NSUserDefaults standardUserDefaults] objectForKey:MabiPreferenceNumberOfRowsKey];
        if (!_row) {
            _row = [MabiParamMap MabiAdItemRowDefault];
        }
    }
    return _row;
}

- (NSString *)page
{
    if (!_page) {
        _page = @"1";
    }
    return _page;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setThemeColor];
    
    self.tableView.backgroundColor = SeraphColor(242, 242, 242);
    self.title = [MabiParamMap getServerNameWithServerStr:self.nameServer];
    
    [self.tableView addHeaderWithTarget:self action:@selector(refreshViewHeaderViewBeginRefresh) label:@"可快速恢复到原始状态"];
    [self.tableView addFooterWithTarget:self action:@selector(refreshViewFooterViewBeginRefresh)];
    self.tableView.headerPullToRefreshText = @"下拉重置";
    self.tableView.headerReleaseToRefreshText = @"松开重置";
    self.tableView.headerRefreshingText = @"正在重置...";

    // 监听键盘的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    // tableView添加手势
    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTableView)];
    tap.delegate = self;
    [self.tableView addGestureRecognizer:tap];
    
    // textFiled代理
    self.searchWordTextField.delegate = self;
    
    // 初始价格升序
    self.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
    
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchTypeDidChangedToTypeSeller) name:[MabiParamMap notificationWithSearchTypeDidChangeToSeller] object:self.searchWordTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchTypeDidChangedToItemName) name:[MabiParamMap notificationWithSearchTypeDidChangeToItemName] object:self.searchWordTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(numberOfSearchRowsDidChanged:) name:[MabiParamMap notificationWithNumberOfSearchRowsDidChanged] object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jumpToPage:) name:[MabiParamMap notificationWithJumpToPage] object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sortTypeDidChangeToItemName:) name:[MabiParamMap notificationWithSortTypeDidChangeToItemName] object:nil];
    
    // 主题改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeColorChanged:) name:[MabiParamMap notificationWithThemeChanged] object:nil];
    
}

#pragma mark - 通知处理方法
// 主题改变
- (void)themeColorChanged:(NSNotification *)obj
{
    NSString *colorStr = [obj object];
    [self setElementsWithColorStr:colorStr];
}

- (void)searchTypeDidChangedToTypeSeller
{
    self.searchType = [MabiParamMap MabiAdItemSearchTypeSeller];
    SeraphLog(@"%@", self.searchType);
}

- (void)searchTypeDidChangedToItemName
{
    self.searchType = [MabiParamMap MabiAdItemSearchTypeItemName];
    SeraphLog(@"%@", self.searchType);
}

- (void)numberOfSearchRowsDidChanged:(NSNotification *)notification
{
    NSString *number = [notification object];
    self.row = number;
    [[NSUserDefaults standardUserDefaults] setObject:self.row forKey:MabiPreferenceNumberOfRowsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self searchItem];
}

- (void)jumpToPage:(NSNotification *)notification
{
    NSString *number = [notification object];
    self.page = number;
    [self searchItem];
}

- (void)sortTypeDidChangeToItemName:(NSNotification *)notification
{
    // 清空数据数组
    [self.mabiItems removeAllObjects];
    [self.mabiItemsImages removeAllObjects];
    // 价格排序清空
    self.arrowImageView.image = [UIImage imageNamed:@"default"];
    self.sortType = [MabiParamMap MabiAdItemSortTypeItemName];
    // 物品名排序选项
    if (self.sortOption == [MabiParamMap MabiAdItemSortOptionAsc]) {
        self.sortOption = [MabiParamMap MabiAdItemSortOptionDesc];
        self.sortType = [MabiParamMap MabiAdItemSortTypeItemName];
    } else if (self.sortOption == [MabiParamMap MabiAdItemSortOptionDesc]) {
        self.sortOption = [MabiParamMap MabiAdItemSortOptionDefault];
        self.sortType = [MabiParamMap MabiAdItemSortTypeDefault];
    } else if (self.sortOption == [MabiParamMap MabiAdItemSortOptionDefault]) {
        self.sortOption = [MabiParamMap MabiAdItemSortOptionAsc];
        self.sortType = [MabiParamMap MabiAdItemSortTypeItemName];
    }
    // 载入数据
    [self getDataWithNameServer:self.nameServer page:self.page row:self.row sortType:self.sortType sortOption:self.sortOption searchType:self.searchType searchWord:self.searchWord appcode:self.appCode];
    
    if (self.sortType == [MabiParamMap MabiAdItemSortTypeItemName]
        && self.sortOption == [MabiParamMap MabiAdItemSortOptionAsc]) {
        [UIView animateWithDuration:0.3 animations:^{
            self.sortPanelView.arrowImageView.image = [UIImage imageNamed:@"arrow"];
            self.sortPanelView.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
        }];
    } else if (self.sortType == [MabiParamMap MabiAdItemSortTypeItemName]
               && self.sortOption == [MabiParamMap MabiAdItemSortOptionDesc]) {
        [UIView animateWithDuration:0.3 animations:^{
            self.sortPanelView.arrowImageView.image = [UIImage imageNamed:@"arrow"];
            self.sortPanelView.arrowImageView.transform = CGAffineTransformMakeRotation(0);
        }];
    } else if (self.sortType == [MabiParamMap MabiAdItemSortTypeDefault]
               && self.sortOption == [MabiParamMap MabiAdItemSortOptionDefault]) {
        self.sortPanelView.arrowImageView.image = [UIImage imageNamed:@"default"];
    }
}

/**
 *  移除系统tabbar
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)awakeFromNib
{
    
    // 读取设置
    self.nameServer = [[NSUserDefaults standardUserDefaults] objectForKey:MabiPreferenceServerNameKey];
    self.appCode = (int)[[NSUserDefaults standardUserDefaults] integerForKey:MabiPreferenceAppCodeKey];
    if (self.appCode == 0) {
        self.appCode = 1;
    }
    
    
    [self getDataWithNameServer:self.nameServer page:self.page row:self.row sortType:[MabiParamMap MabiAdItemSortTypeDefault] sortOption:[MabiParamMap MabiAdItemSortOptionDefault] searchType:self.searchType searchWord:self.searchWord appcode:self.appCode];
    
//    self.navigationController.hidesBarsOnTap = YES;
}

- (void)afterDataParsed
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        [self.tableView reloadData];
    });
}

#pragma mark - tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mabiItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MabiItemCell *cell = [MabiItemCell cellWithTableView:tableView];
    if (!self.mabiItems.count)  return cell;
    MabiItem *item = self.mabiItems[indexPath.row];
    MabiItemImageRequestParam *imageParam = self.mabiItemsImages[indexPath.row];
    cell.item = item;
    cell.imageRequestURL = imageParam.requestURL;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 142;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    CGAffineTransform transform = self.sortPanelView.transform;
    if (transform.ty != 0 || self.searchWordTextField.isFirstResponder) {
        [self removeMorePanel];
    }
}

/**
 *  键盘即将显示的时候调用
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    self.coverView.alpha = 0.5;
}

/**
 *  键盘即将退出的时候调用
 */
- (void)keyboardWillHide:(NSNotification *)note
{
    self.coverView.alpha = 0;
}

#pragma mark - 手势代理方法
/**
 *  当点击view的时候 会先调用这个方法
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return YES;
}

- (void)tapTableView
{
    [self removeMorePanel];
}


#pragma mark - 刷新控件
/**
 *  刷新控件进入开始刷新状态时调用
 */
- (void)refreshViewHeaderViewBeginRefresh
{
    [self.mabiItems removeAllObjects];
    [self.mabiItemsImages removeAllObjects];
    self.page = @"1";
    self.searchWordTextField.text = nil;
    // 重置按钮
    self.sortType = [MabiParamMap MabiAdItemSortTypeDefault];
    self.sortOption = [MabiParamMap MabiAdItemSortOptionDefault];
    self.arrowImageView.image = [UIImage imageNamed:@"default"];
    // 重置panel里按钮
    self.sortPanelView.arrowImageView.image = [UIImage imageNamed:@"default"];
    [self getDataWithNameServer:self.nameServer page:self.page row:self.row sortType:[MabiParamMap MabiAdItemSortTypeDefault] sortOption:[MabiParamMap MabiAdItemSortOptionDefault] searchType:[MabiParamMap MabiAdItemSearchTypeDefault] searchWord:nil appcode:self.appCode];
    [self.tableView headerEndRefreshing];
}

- (void)refreshViewFooterViewBeginRefresh
{
    self.page = [NSString stringWithFormat:@"%d", [self.page intValue] + 1];
    [self getDataWithNameServer:self.nameServer page:self.page row:self.row sortType:self.sortType sortOption:self.sortOption searchType:self.searchType searchWord:self.searchWord appcode:self.appCode];
    [self.tableView footerEndRefreshing];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[MabiParamMap notificationWithSearchTypeDidChangeToSeller] object:self.searchType];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[MabiParamMap notificationWithSearchTypeDidChangeToItemName] object:self.searchType];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[MabiParamMap notificationWithNumberOfSearchRowsDidChanged] object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[MabiParamMap notificationWithJumpToPage] object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[MabiParamMap notificationWithSortTypeDidChangeToItemName] object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[MabiParamMap notificationWithThemeChanged] object:nil];
}

#pragma mark - textField代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.searchWordTextField.isFirstResponder) {
        [self.searchWordTextField resignFirstResponder];
    }
    [self searchItem];
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [self searchItem];
    
    return YES;
}


// 搜索物品 默认价格升序
- (void)searchItem {
    if (self.searchWordTextField.text.length>0 || self.sortPanelView.transform.ty) {
        self.searchWord = [self.searchWordTextField.text stringByAddingPercentEscapesUsingEncoding:[SeraphHTTPEncoding SeraphHTTPStringEncodingGB2312]];
        [self.mabiItems removeAllObjects];
        [self.mabiItemsImages removeAllObjects];
        [self getDataWithNameServer:self.nameServer page:self.page row:self.row sortType:self.sortType sortOption:self.sortOption searchType:self.searchType searchWord:self.searchWord appcode:self.appCode];
        [self.tableView reloadData];
    }
}

#pragma mark - 点击事件
- (IBAction)moreBtnDidClicked:(id)sender {
    
    UIButton *btn = sender;
    if (btn.tag == 0) { // 弹出面板
        btn.tag = 1;
        self.sortPanelView.searchWordTextField = self.searchWordTextField;
        self.sortPanelView.coverView = self.coverView;
        self.sortPanelView.currentPage = self.page;
        self.sortPanelView.currentNumberOfRows = self.row;
        [self displayMorePanel];
        
    } else { // 收起面板
        btn.tag = 0;
        [self removeMorePanel];
    }
}

- (IBAction)priceAscOrDescBtnDidClicked:(UIButton *)sender {
    // 清空数据数组
    [self.mabiItems removeAllObjects];
    [self.mabiItemsImages removeAllObjects];
    // 物品名称排序清空
    self.sortPanelView.arrowImageView.image = [UIImage imageNamed:@"default"];
    self.sortType = [MabiParamMap MabiAdItemSortTypePrice];
    // 价格排序选项
    if (self.sortOption == [MabiParamMap MabiAdItemSortOptionAsc]) {
        self.sortOption = [MabiParamMap MabiAdItemSortOptionDesc];
        self.sortType = [MabiParamMap MabiAdItemSortTypePrice];
    } else if (self.sortOption == [MabiParamMap MabiAdItemSortOptionDesc]) {
        self.sortOption = [MabiParamMap MabiAdItemSortOptionDefault];
        self.sortType = [MabiParamMap MabiAdItemSortTypeDefault];
    } else if (self.sortOption == [MabiParamMap MabiAdItemSortOptionDefault]) {
        self.sortOption = [MabiParamMap MabiAdItemSortOptionAsc];
        self.sortType = [MabiParamMap MabiAdItemSortTypePrice];
    }
    // 载入数据
    [self getDataWithNameServer:self.nameServer page:self.page row:self.row sortType:self.sortType sortOption:self.sortOption searchType:self.searchType searchWord:self.searchWord appcode:self.appCode];
    
    if (self.sortType == [MabiParamMap MabiAdItemSortTypePrice]
        && self.sortOption == [MabiParamMap MabiAdItemSortOptionAsc]) {
        [UIView animateWithDuration:0.3 animations:^{
            self.arrowImageView.image = [UIImage imageNamed:@"arrow" withThemeSuffix:self.suffix];
            self.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
        }];
    } else if (self.sortType == [MabiParamMap MabiAdItemSortTypePrice]
               && self.sortOption == [MabiParamMap MabiAdItemSortOptionDesc]) {
        [UIView animateWithDuration:0.3 animations:^{
            self.arrowImageView.image = [UIImage imageNamed:@"arrow" withThemeSuffix:self.suffix];
            self.arrowImageView.transform = CGAffineTransformMakeRotation(0);
        }];
    } else if (self.sortType == [MabiParamMap MabiAdItemSortTypeDefault]
               && self.sortOption == [MabiParamMap MabiAdItemSortOptionDefault]) {
        self.arrowImageView.image = [UIImage imageNamed:@"default" withThemeSuffix:self.suffix];
    }
}


#pragma mark - 服务器切换
- (IBAction)maryBtnDidClicked {
    [self changeServerWithServerStr:[MabiParamMap MabiAdItemNameServerMaryCN]];
}

- (IBAction)lulaliBtnDidClicked {
    [self changeServerWithServerStr:[MabiParamMap MabiAdItemNameServerLulaliCN]];
}

- (IBAction)piailuoBtnDidClicked {
    [self changeServerWithServerStr:[MabiParamMap MabiAdItemNameServerPiailuoCN]];
}

- (IBAction)samalaBtnDidClicked {    [self changeServerWithServerStr:[MabiParamMap MabiAdItemNameServerSamalaCN]];
}

- (IBAction)yiwenBtnDidClicked {
    [self changeServerWithServerStr:[MabiParamMap MabiAdItemNameServerYiwenCN]];
}

- (IBAction)lunaBtnDidClicked {
    [self changeServerWithServerStr:[MabiParamMap MabiAdItemNameServerLunaCN]];
}

- (void)changeServerWithServerStr:(NSString *)serverStr
{
    self.searchWordTextField.text = nil;
    self.title = [MabiParamMap getServerNameWithServerStr:serverStr];
    self.nameServer = serverStr;
    self.appCode = [MabiParamMap getAppCodeWithServerStr:self.nameServer];
    // 恢复默认
//    self.searchType = [MabiParamMap MabiAdItemSearchTypeDefault];
    self.sortType = [MabiParamMap MabiAdItemSortTypeDefault];
    self.sortOption = [MabiParamMap MabiAdItemSortOptionDefault];
    [self searchItem];
    [self removeMorePanel];
    // 存储服务器名
    [[NSUserDefaults standardUserDefaults] setObject:self.nameServer forKey:MabiPreferenceServerNameKey];
    [[NSUserDefaults standardUserDefaults] setInteger:self.appCode forKey:MabiPreferenceAppCodeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - 事件处理方法
- (void)removeMorePanel
{
    [self.view endEditing:YES];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.sortPanelView.transform = CGAffineTransformMakeTranslation(0, 0);
        self.moreBtn.transform = CGAffineTransformMakeRotation(0);
        self.coverView.alpha = 0;
    }];
    self.moreBtn.tag = 0;
}

- (void)displayMorePanel
{
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.3 animations:^{
        self.sortPanelView.transform = CGAffineTransformMakeTranslation(0, self.sortPanelView.frame.size.height);
        self.moreBtn.transform = CGAffineTransformMakeRotation(-M_PI_4);
        self.coverView.alpha = 0.5;
    }];
}

/**
 *  设置主题颜色
 */
- (void)setThemeColor
{
    NSString *colorStr = [[NSUserDefaults standardUserDefaults] objectForKey:MabiPreferenceThemeColorKey];
    [self setElementsWithColorStr:colorStr];
    
}

- (void)setElementsWithColorStr:(NSString *)colorStr
{
    self.suffix = @"";
    if ([colorStr isEqualToString:MabiThemeColorBlue]) {
        self.suffix = @"_blue";
    } else if ([colorStr isEqualToString:MabiThemeColorPink]) {
        self.suffix = @"_pink";
    }
    
    [self.moreBtn setImage:[UIImage imageNamed:@"adboard_more" withThemeSuffix:self.suffix] forState:UIControlStateNormal];
    self.arrowImageView.image = [UIImage imageNamed:@"default" withThemeSuffix:self.suffix];
    self.sortPanelView.arrowImageView.image = [UIImage imageNamed:@"default" withThemeSuffix:self.suffix];
    self.sortPanelView.settingImageView.image = [UIImage imageNamed:@"settingLabel" withThemeSuffix:self.suffix];
    self.sortPanelView.serverImageView.image = [UIImage imageNamed:@"serverLabel" withThemeSuffix:self.suffix];
    
    [self.sortPanelView.maryBtn setImage:[UIImage imageNamed:@"cn_mary" withThemeSuffix:self.suffix] forState:UIControlStateNormal];
    [self.sortPanelView.lulaliBtn setImage:[UIImage imageNamed:@"cn_lulali" withThemeSuffix:self.suffix] forState:UIControlStateNormal];
    [self.sortPanelView.piailuoBtn setImage:[UIImage imageNamed:@"cn_piailuo" withThemeSuffix:self.suffix] forState:UIControlStateNormal];
    [self.sortPanelView.samalaBtn setImage:[UIImage imageNamed:@"cn_samala" withThemeSuffix:self.suffix] forState:UIControlStateNormal];
    [self.sortPanelView.yiwenBtn setImage:[UIImage imageNamed:@"cn_yiwen" withThemeSuffix:self.suffix] forState:UIControlStateNormal];
    [self.sortPanelView.lunaBtn setImage:[UIImage imageNamed:@"cn_luna" withThemeSuffix:self.suffix] forState:UIControlStateNormal];
    
    
    [self.priceAscOrDescBtn setTitleColor:[UIColor colorFromHexString:colorStr] forState:UIControlStateNormal];
    self.sortPanelView.rowLabel.textColor = [UIColor colorFromHexString:colorStr];
    self.sortPanelView.pageLabel.textColor = [UIColor colorFromHexString:colorStr];
    self.sortPanelView.everyTimeLabel.textColor = [UIColor colorFromHexString:colorStr];
    self.sortPanelView.jumpToLabel.textColor = [UIColor colorFromHexString:colorStr];
    self.arrowImageView.tintColor = [UIColor colorFromHexString:colorStr];
    [self.sortPanelView.changeSearchTypeBtn setTitleColor:[UIColor colorFromHexString:colorStr] forState:UIControlStateNormal];
    [self.sortPanelView.itemNameAscOrDescBtn setTitleColor:[UIColor colorFromHexString:colorStr] forState:UIControlStateNormal];
}

@end
