//
//  MabiStrategyBaseController.m
//  MabinogiHelper
//
//  Created by Joshua on 14/12/21.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#define MabiTaskCellID @"taskCell"

#import "MabiStrategyBaseController.h"
#import "MabiMainTaskDetailController.h"
#import "MabiTaskCell.h"
#import "SeraphProgressHUDTool.h"
#import "MabiCommon.h"

@interface MabiStrategyBaseController()
@property (nonatomic, weak) UIView *noDataView;
@end

@implementation MabiStrategyBaseController

- (MabiMainTaskDetailController *)detailVC
{
    if (!_detailVC) {
        UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        _detailVC = [board instantiateViewControllerWithIdentifier:@"MabiStrategyDetailController"];
    }
    return _detailVC;
}

- (NSMutableArray *)strategyArray
{
    if (!_strategyArray) {
        _strategyArray = [NSMutableArray array];
    }
    return _strategyArray;
}

- (id)init
{
    // 流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 每个cell的尺寸
    CGFloat length = [UIScreen mainScreen].bounds.size.width / 2 - SeraphTableViewEdgeMargin;
    layout.itemSize = CGSizeMake(length - 2 * SeraphTableViewEdgeMargin, length + 10);
    // 设置cell之间的水平间距
    layout.minimumInteritemSpacing = SeraphTableViewEdgeMargin;
    // 设置cell之间的垂直间距
    layout.minimumLineSpacing = 3 *SeraphTableViewEdgeMargin;
    // 设置四周的内边距
    layout.sectionInset = UIEdgeInsetsMake(layout.minimumLineSpacing, SeraphTableViewEdgeMargin, 0, SeraphTableViewEdgeMargin);
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setup];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"refresh"] style:UIBarButtonItemStylePlain target:self action:@selector(refresh)];
    [self setIfNoData];
}

//- (void)refresh
//{
//    
//}

- (void)setup
{
    // 注册cell(告诉collectionView将来创建怎样的cell)
    UINib *nib = [UINib nibWithNibName:@"MabiTaskCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:MabiTaskCellID];
    
    // 设置collectionView
    self.title = @"主线任务";
    self.collectionView.backgroundColor = SeraphColor(242, 242, 242);
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
}

#pragma mark - 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (!self.strategyArray.count) {
        self.noDataView.hidden = NO;
        return 0;
    }
    
    self.noDataView.hidden = YES;
    return self.strategyArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 获得cell
    MabiTaskCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MabiTaskCellID forIndexPath:indexPath];
    
    // 传递模型
    if (self.strategyArray.count) {
        cell.strategyItem = self.strategyArray[indexPath.item];
    }
    
    return cell;
}

#pragma mark - 代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.detailVC.currentitem = self.strategyArray[indexPath.item];
    self.detailVC.title = @"攻略详情";
    [self.navigationController pushViewController:self.detailVC animated:YES];
}


#pragma mark - 数据

- (BOOL)dataInDB:(MabiStrategyType)type
{
    // 判断数据库是否有数据
    self.strategyArray = [NSMutableArray arrayWithArray:[MabiStrategyTool getDataFromDatabaseWithType:type]];
    
    if (self.strategyArray.count) {
        return YES;
    }
    return NO;
}

- (void)getDataWithType:(MabiStrategyType)type
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSBlockOperation *getDataFromDB = [NSBlockOperation blockOperationWithBlock:^{
        // 判断数据库是否有数据
        self.strategyArray = [NSMutableArray arrayWithArray:[MabiStrategyTool getDataFromDatabaseWithType:type]];
    }];
    
    NSBlockOperation *getDataFromWeb = [NSBlockOperation blockOperationWithBlock:^{
        if (!self.strategyArray.count) { // 数据库没有数据
            dispatch_async(dispatch_get_main_queue(), ^{
                [SeraphProgressHUDTool showMessage:@"正在拼命加载中..." toView:self.navigationController.view];
            });
            [self getDataFromWebWithType:type];
        }
    }];
    
    NSBlockOperation *reload = [NSBlockOperation blockOperationWithBlock:^{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        [self.collectionView reloadData];
        [SeraphProgressHUDTool hideHUDForView:self.navigationController.view];
    }];
    
    [getDataFromWeb addDependency:getDataFromDB];
    [reload addDependency:getDataFromWeb];
    
    [queue addOperation:getDataFromDB];
    [queue addOperation:getDataFromWeb];
    [[NSOperationQueue mainQueue]addOperation:reload];
}

/**
 * 从网络获取数据
 */
- (void)getDataFromWebWithType:(MabiStrategyType)type
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    // 获取数据
    NSArray *temp = [NSArray array];
    for (int i = 1; i < MAXFLOAT; i++) {
        temp = [MabiStrategyTool getStrategyArrayWithType:type page:i];
        if (!temp) break;
        [self.strategyArray addObjectsFromArray:temp];
        temp = nil;
    }
    // 存入数据库
    [MabiStrategyTool saveToDatabase:self.strategyArray type:type];
}

/**
 *  清空数据
 */
- (void)deleteDataFromDBWithType:(MabiStrategyType)type
{
    [MabiStrategyTool deleteDataFromDatabaseWithType:type];
}

#pragma mark - 事物处理方法

- (void)setIfNoData
{
    // 添加控件
    UIView *noDataView = [[UIView alloc] init];
    noDataView.backgroundColor = [UIColor whiteColor];
    noDataView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:noDataView];
    self.noDataView = noDataView;
    UILabel *noDataLabel = [[UILabel alloc] init];
    noDataLabel.translatesAutoresizingMaskIntoConstraints = NO;
    noDataLabel.text = MabiNoDataInfo;
    noDataLabel.font = [UIFont systemFontOfSize:14];
    noDataLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [noDataView addSubview:noDataLabel];
    
    UILabel *infoLabel = [[UILabel alloc] init];
    infoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    infoLabel.text = @"点击右上角刷新按钮可以获取从官网获取数据";
    infoLabel.font = [UIFont systemFontOfSize:11];
    infoLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [noDataView addSubview:infoLabel];
    
    // 高度
    NSLayoutConstraint *noDataViewH = [NSLayoutConstraint constraintWithItem:noDataView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
    [noDataView addConstraint:noDataViewH];
    // 左边间距
    CGFloat margin = 5;
    NSLayoutConstraint *noDataViewL = [NSLayoutConstraint constraintWithItem:noDataView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:margin];
    [self.view addConstraint:noDataViewL];
    // 顶部间距
    NSLayoutConstraint *noDataViewT = [NSLayoutConstraint constraintWithItem:noDataView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:margin];
    [self.view addConstraint:noDataViewT];
    // 右边间距
    NSLayoutConstraint *noDataViewR = [NSLayoutConstraint constraintWithItem:noDataView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-margin];
    [self.view addConstraint:noDataViewR];
    
    NSLayoutConstraint *noDataLabelX = [NSLayoutConstraint constraintWithItem:noDataLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:noDataView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [noDataView addConstraint:noDataLabelX];
    [noDataView addConstraint:[NSLayoutConstraint constraintWithItem:noDataLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:noDataView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:-15]];
    
    [noDataView addConstraint:[NSLayoutConstraint constraintWithItem:infoLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:noDataView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-margin]];
    [noDataView addConstraint:[NSLayoutConstraint constraintWithItem:infoLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:noDataView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-margin]];
}

@end
