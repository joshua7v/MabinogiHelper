//
//  MabiAdPanelView.h
//  MabinogiHelper
//
//  Created by Joshua on 14/12/28.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MabiAdPanelView : UIView
@property (weak, nonatomic) UITextField *searchWordTextField;
@property (weak, nonatomic) UIView *coverView;
@property (nonatomic, copy) NSString *currentPage;
@property (nonatomic, copy) NSString *currentNumberOfRows;



// need to change theme color
@property (nonatomic, weak) IBOutlet UIImageView *arrowImageView;
@property (nonatomic, weak) IBOutlet UIButton *changeSearchTypeBtn;
@property (nonatomic, weak) IBOutlet UIButton *itemNameAscOrDescBtn;
@property (nonatomic, weak) IBOutlet UILabel *everyTimeLabel;
@property (nonatomic, weak) IBOutlet UILabel *rowLabel;
@property (nonatomic, weak) IBOutlet UILabel *jumpToLabel;
@property (nonatomic, weak) IBOutlet UILabel *pageLabel;


@property (nonatomic, weak) IBOutlet UIImageView *settingImageView;
@property (nonatomic, weak) IBOutlet UIImageView *serverImageView;
@property (nonatomic, weak) IBOutlet UIButton *maryBtn;
@property (nonatomic, weak) IBOutlet UIButton *lulaliBtn;
@property (nonatomic, weak) IBOutlet UIButton *piailuoBtn;
@property (nonatomic, weak) IBOutlet UIButton *samalaBtn;
@property (nonatomic, weak) IBOutlet UIButton *yiwenBtn;
@property (nonatomic, weak) IBOutlet UIButton *lunaBtn;
@end
