//
//  MabiCommon.m
//  MabinogiHelper
//
//  Created by Joshua on 14/12/16.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//


#define MabiPreferenceServerNameKey @"ServerName"
#define MabiPreferenceAppCodeKey @"AppCode"
#define MabiPreferenceNumberOfRowsKey @"numberOfRows"
#define MabiPreferenceThemeColorKey @"ThemeColor"

/**
 *  颜色
 */
#define MabiThemeColorPink @"FC9D9A"
#define MabiThemeColorBlue @"83C3ED"

#define MabiName_Server_Mary @"mabicn16"
#define MabiAdItemDefaultRow @"10"
#define MabiXMLURL @"http://app01.luoqi.com.cn/shopAdvertise/ShopAdvertise.asp"

/**
 *  看板
 */
#define MabiNoDataInfo @"暂时没有数据哟"
#define MabiGettingDataInfo @"获取数据中..."

#define MabiWebViewCss @"<style type=\"text/css\"> \
dd { \
font-size:35; \
} \
p { \
font-size:35; \
} \
p span { \
font-size:35; \
} \
img { \
max-width:1000px;max-height:800px \
} \
</style>"

#define MabiWebViewErrorCss @"<style type=\"text/css\"> \
dd { \
font-size:70; \
text-align:center; \
margin-top:300px; \
color:#cccccc \
} \
</style> \
<dd> \
人家拿不到这个页面的数据嘛<br/>(╯°口°)╯(┴—┴ \
<br><br><br> \
<font size='55'>非官网数据暂时获取不到哟</font> \
</dd> \
"

#define MabiColorCodeGroupTitleYellow @"黄色"
#define MabiColorCodeGroupTitleRed @"红色"
#define MabiColorCodeGroupTitleBlue @"蓝色"
#define MabiColorCodeGroupTitleGreen @"绿色"
#define MabiColorCodeGroupTitlePurple @"紫色"
#define MabiColorCodeGroupTitlePink @"粉色"

#import <Foundation/Foundation.h>
#import "MabiParamMap.h"
#import "UIImage+MabiTheme.h"