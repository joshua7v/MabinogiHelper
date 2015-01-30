//
//  MabiAdPanelView.m
//  MabinogiHelper
//
//  Created by Joshua on 14/12/28.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import "MabiAdPanelView.h"
#import "MabiParamMap.h"

@interface MabiAdPanelView() <UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, weak) IBOutlet UITextField *numberOfRowsTextField;
@property (nonatomic, weak) IBOutlet UITextField *numberOfPagesTextField;

- (IBAction)itemNameAscOrDescBtnDidClicked:(UIButton *)sender;
- (IBAction)changeSearchTypeBtnDidClicked:(UIButton *)sender;
- (IBAction)didTapView:(UITapGestureRecognizer *)sender;
@property (nonatomic, strong) NSArray *rowDataArray;
@end

@implementation MabiAdPanelView

- (NSArray *)rowDataArray
{
    if (!_rowDataArray) {
        _rowDataArray = @[@"5", @"10", @"20", @"50"];
    }
    return _rowDataArray;
}

//- (NSString *)currentNumberOfRows
//{
//    if (!_currentNumberOfRows) {
//        _currentNumberOfRows = @"5";
//    }
//    return _currentNumberOfRows;
//}

- (void)setCurrentNumberOfRows:(NSString *)currentNumberOfRows
{
    _currentNumberOfRows = currentNumberOfRows;
    self.numberOfRowsTextField.text = self.currentNumberOfRows;
}

- (void)setCurrentPage:(NSString *)currentPage
{
    _currentPage = currentPage;
    self.numberOfPagesTextField.text = self.currentPage;
}

- (void)setSearchWordTextField:(UITextField *)searchWordTextField
{
    _searchWordTextField = searchWordTextField;
}

- (void)awakeFromNib
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.userInteractionEnabled = YES;
    // 给加载条数加上pickerview
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.backgroundColor = [UIColor whiteColor];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    pickerView.tag = 0;
    self.numberOfRowsTextField.inputView = pickerView;
    
    self.currentNumberOfRows = @"10";
    self.currentPage = @"1";
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.rowDataArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *number = self.rowDataArray[row];
    return number;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *number = self.rowDataArray[row];
    self.currentNumberOfRows = number;
    [[NSNotificationCenter defaultCenter] postNotificationName:[MabiParamMap notificationWithNumberOfSearchRowsDidChanged] object:self.currentNumberOfRows];
}

- (IBAction)changeSearchTypeBtnDidClicked:(UIButton *)sender
{
    if ([self.searchWordTextField.placeholder isEqualToString:@"请输入物品名称"]) {
        [sender setTitle:@"切换-按物品名称搜索" forState:UIControlStateNormal];
        self.searchWordTextField.text = nil;
        self.searchWordTextField.placeholder = @"请输入卖家名称";
        [[NSNotificationCenter defaultCenter] postNotificationName:[MabiParamMap notificationWithSearchTypeDidChangeToSeller] object:self.searchWordTextField];
    } else if ([self.searchWordTextField.placeholder isEqualToString:@"请输入卖家名称"]) {
        [sender setTitle:@"切换-按卖家名称搜索" forState:UIControlStateNormal];
        self.searchWordTextField.text = nil;
        self.searchWordTextField.placeholder = @"请输入物品名称";
        [[NSNotificationCenter defaultCenter] postNotificationName:[MabiParamMap notificationWithSearchTypeDidChangeToItemName] object:self.searchWordTextField];
    }
    [self.searchWordTextField becomeFirstResponder];
}

- (IBAction)didTapView:(UITapGestureRecognizer *)sender
{
    if (self.numberOfRowsTextField.isFirstResponder) {
        [self.numberOfRowsTextField resignFirstResponder];
    }
    if (self.searchWordTextField.isFirstResponder) {
        [self.searchWordTextField resignFirstResponder];
    }
    if (self.numberOfPagesTextField.isFirstResponder) {
        [self.numberOfPagesTextField resignFirstResponder];
        [[NSNotificationCenter defaultCenter] postNotificationName:[MabiParamMap notificationWithJumpToPage] object:self.numberOfPagesTextField.text];
    }
    self.coverView.alpha = 0.5;
}

- (IBAction)itemNameAscOrDescBtnDidClicked:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:[MabiParamMap notificationWithSortTypeDidChangeToItemName] object:sender];
}

@end
