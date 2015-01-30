//
//  MabiWatchBoardController.m
//  MabinogiHelper
//
//  Created by Joshua on 14/12/12.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#define MabiHomeNewsErrorMessage @"网络好像连不上呢"

#import "MabiWatchBoardController.h"
#import "SeraphHTTPTool.h"
#import "SeraphHTMLParser.h"
#import "MabiTrainslateTool.h"
#import "MabiToday.h"
#import "MabiWeather.h"
#import "MabiWatchBoardDataTool.h"
#import "MabiSmuggle.h"
#import "SeraphProgressHUDTool.h"
#import "MabiWatchBoardViewCell.h"
#import "MabiTrainslateTool.h"
#import "MabiTime.h"
#import "MabiCommon.h"

@interface MabiWatchBoardController ()<UITabBarDelegate, UITableViewDataSource>
@property (nonatomic, assign) BOOL noSmuggleData;
@property (nonatomic, strong) MabiSmuggle *smuggle;
@property (nonatomic, strong) MabiToday *today;
@property (nonatomic, strong) MabiTime *time;
@property (nonatomic, strong) NSArray *weatherArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *tadayTatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *todayTaraLabel;
@property (weak, nonatomic) IBOutlet UILabel *viptodayTatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *viptodayTaraLabel;
@property (weak, nonatomic) IBOutlet UITextView *weatherTextView;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshBarBtn;
- (IBAction)refreshBtnDidClicked:(UIBarButtonItem *)sender;

@end

@implementation MabiWatchBoardController

- (MabiTime *)time
{
    if (!_time) {
        _time = [[MabiTime alloc] init];
    }
    _time = [[MabiWatchBoardDataTool sharedWatchBoardDataTool] getCurrentGameTime];
    return _time;
}

- (void)awakeFromNib
{
    self.refreshBarBtn.tintColor = [UIColor whiteColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.noSmuggleData = NO;
    
    self.tableView.backgroundColor = SeraphColor(242, 242, 242);
    self.tableView.showsVerticalScrollIndicator = NO;
    self.weatherTextView.showsVerticalScrollIndicator = NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MabiSmuggleLoadingCell" bundle:nil] forCellReuseIdentifier:@"MabiSmuggleLoadingCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MabiSmuggleNoDataCell" bundle:nil] forCellReuseIdentifier:@"MabiSmuggleNoDataCell"];
    
    
    // 多线程加载数据
    [self getData];
    
    // 设置时间
    self.currentTimeLabel.text = self.time.currentTime;
//    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(getErinnTime)];
    [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(getErinnTime) userInfo:nil repeats:YES];
//    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)getErinnTime
{
    if ([[self.time.currentTime substringFromIndex:6] isEqualToString:@"0"]
        || [[self.time.currentTime substringFromIndex:6] isEqualToString:@"5"]) {
        self.currentTimeLabel.text = self.time.currentTime;
    }
}

/**
 *  多线程加载数据
 */
- (void)getData
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self startLoadingIndicator];
//    [SeraphProgressHUDTool showMessage:@"正在努力加载看板数据..." toView:self.navigationController.view];
    NSOperationQueue *q = [[NSOperationQueue alloc] init];
    NSBlockOperation *getSmuggleData = [NSBlockOperation blockOperationWithBlock:^{
        self.smuggle.detailArray = nil;
        self.smuggle = [[MabiWatchBoardDataTool sharedWatchBoardDataTool] getSmuggleData];
    }];
    NSBlockOperation *getTodayData = [NSBlockOperation blockOperationWithBlock:^{
        self.today = [[MabiWatchBoardDataTool sharedWatchBoardDataTool] getTodayData];
    }];
    NSBlockOperation *getWeatherData = [NSBlockOperation blockOperationWithBlock:^{
        self.weatherArray = [[MabiWatchBoardDataTool sharedWatchBoardDataTool]getWeatherData];
    }];
    
    [q addOperation:getSmuggleData];
    [q addOperation:getTodayData];
    [q addOperation:getWeatherData];
    
    NSBlockOperation *updateUI = [NSBlockOperation blockOperationWithBlock:^{
        [self.tableView reloadData];
//        [SeraphProgressHUDTool hideHUDForView:self.navigationController.view];
        if (!self.today.today.tara.length) {
            [SeraphProgressHUDTool showError:MabiHomeNewsErrorMessage toView:self.navigationController.view];
            [self setIfNoNetworking];
            self.noSmuggleData = YES;
            [self.tableView reloadData];
            return ;
        }
        
        self.noSmuggleData = NO;
        MabiTrainslateTool *trainslateTool = [MabiTrainslateTool trainslateTool];
        
        self.tadayTatingLabel.text = [trainslateTool.wordsDict valueForKey:self.today.today.tating];
        self.todayTaraLabel.text = [trainslateTool.wordsDict valueForKey:self.today.today.tara];
        self.viptodayTatingLabel.text = [trainslateTool.wordsDict valueForKey:self.today.vipToday.tating];
        self.viptodayTaraLabel.text = [trainslateTool.wordsDict valueForKey:self.today.vipToday.tara];
        self.tadayTatingLabel.textColor = [UIColor blackColor];
        self.todayTaraLabel.textColor = [UIColor blackColor];
        self.viptodayTatingLabel.textColor = [UIColor blackColor];
        self.viptodayTaraLabel.textColor = [UIColor blackColor];
        
        self.weatherTextView.textAlignment = NSTextAlignmentRight;
        NSString *weatherStr = @"";
        for (MabiWeather *weather in self.weatherArray) {
            NSString *time = [weather.time substringFromIndex:11];
            weatherStr = [weatherStr stringByAppendingString:[NSString stringWithFormat:@"%@\n%@\n%@\n", time, weather.location, weather.weather]];
        }
        self.weatherTextView.text = weatherStr;
        
        if ([[self.weatherTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
            self.weatherTextView.text = @"暂时没有数据哟";
            self.weatherTextView.textColor = [UIColor blackColor];
        }
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        [self stopLoadingIndicator];
    }];
    [updateUI addDependency:getWeatherData];
    [updateUI addDependency:getSmuggleData];
    [updateUI addDependency:getTodayData];
    [[NSOperationQueue mainQueue] addOperation:updateUI];
}

/**
 *  按照走私数据条数返回cell数量
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!self.smuggle.detailArray.count) {
        return 1;
    }
    return self.smuggle.detailArray.count;
}

#pragma mark - tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.smuggle.detailArray.count && self.noSmuggleData) {
        return [tableView dequeueReusableCellWithIdentifier:@"MabiSmuggleNoDataCell"];
    }
    
    if (!self.smuggle.detailArray.count && !self.noSmuggleData) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MabiSmuggleLoadingCell"];
        UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)[cell viewWithTag:1];
        [indicator startAnimating];
        return cell;
    }
    MabiWatchBoardViewCell *cell = [MabiWatchBoardViewCell cellWithTableView:tableView];
    
    MabiSmuggleDetail *item = self.smuggle.detailArray[indexPath.row];
    cell.smuggleDetailItem = item;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.smuggle.detailArray.count) {
        return 80;
    }
    return 55;
}

/**
 *  刷新按钮事件
 */
- (IBAction)refreshBtnDidClicked:(UIBarButtonItem *)sender {
    [self getData];
    self.noSmuggleData = NO;
    [self.tableView reloadData];
}

#pragma mark - 事物处理方法
- (void)startLoadingIndicator
{
    // view tag : 1 2 3 4 5 -> loading indicatorView
    UIActivityIndicatorView *loading1 = (UIActivityIndicatorView *)[self.view viewWithTag:1];
    UIActivityIndicatorView *loading2 = (UIActivityIndicatorView *)[self.view viewWithTag:2];
    UIActivityIndicatorView *loading3 = (UIActivityIndicatorView *)[self.view viewWithTag:3];
    UIActivityIndicatorView *loading4 = (UIActivityIndicatorView *)[self.view viewWithTag:4];
    UIActivityIndicatorView *loading5 = (UIActivityIndicatorView *)[self.view viewWithTag:5];
    loading1.hidesWhenStopped = YES;
    loading2.hidesWhenStopped = YES;
    loading3.hidesWhenStopped = YES;
    loading4.hidesWhenStopped = YES;
    loading5.hidesWhenStopped = YES;
    [loading1 startAnimating];
    [loading2 startAnimating];
    [loading3 startAnimating];
    [loading4 startAnimating];
    [loading5 startAnimating];
    
    self.todayTaraLabel.text = MabiGettingDataInfo;
    self.tadayTatingLabel.text = MabiGettingDataInfo;
    self.viptodayTatingLabel.text = MabiGettingDataInfo;
    self.viptodayTaraLabel.text = MabiGettingDataInfo;
    self.todayTaraLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.tadayTatingLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.viptodayTatingLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.viptodayTaraLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    self.weatherTextView.text = MabiGettingDataInfo;
    self.weatherTextView.textAlignment = NSTextAlignmentCenter;
    self.weatherTextView.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
}

- (void)stopLoadingIndicator
{
    // view tag : 1 2 3 4 5 -> loading indicatorView
    UIActivityIndicatorView *loading1 = (UIActivityIndicatorView *)[self.view viewWithTag:1];
    UIActivityIndicatorView *loading2 = (UIActivityIndicatorView *)[self.view viewWithTag:2];
    UIActivityIndicatorView *loading3 = (UIActivityIndicatorView *)[self.view viewWithTag:3];
    UIActivityIndicatorView *loading4 = (UIActivityIndicatorView *)[self.view viewWithTag:4];
    UIActivityIndicatorView *loading5 = (UIActivityIndicatorView *)[self.view viewWithTag:5];
    [loading1 stopAnimating];
    [loading2 stopAnimating];
    [loading3 stopAnimating];
    [loading4 stopAnimating];
    [loading5 stopAnimating];
    loading1.hidden = YES;
}

- (void)setIfNoNetworking
{
    self.todayTaraLabel.text = MabiNoDataInfo;
    self.tadayTatingLabel.text = MabiNoDataInfo;
    self.viptodayTatingLabel.text = MabiNoDataInfo;
    self.viptodayTaraLabel.text = MabiNoDataInfo;
    self.todayTaraLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.tadayTatingLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.viptodayTatingLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.viptodayTaraLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    self.weatherTextView.text = MabiNoDataInfo;
    self.weatherTextView.textAlignment = NSTextAlignmentCenter;
    self.weatherTextView.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    [self stopLoadingIndicator];
}

@end
