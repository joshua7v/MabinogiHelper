//
//  HMMusicTool.h
//  02-黑马音乐
//
//  Created by apple on 14-8-8.
//  Copyright (c) 2014年 heima. All rights reserved.
//  管理音乐数据（音乐模型）

#import <Foundation/Foundation.h>
@class SeraphMusicTool, SeraphMusic;

@interface SeraphMusicTool : NSObject
/**
 *  返回所有的歌曲
 */
+ (NSArray *)musics;

/**
 *  返回正在播放的歌曲
 */
+ (SeraphMusic *)playingMusic;
+ (void)setPlayingMusic:(SeraphMusic *)playingMusic;

/**
 *  下一首歌曲
 */
+ (SeraphMusic *)nextMusic;

/**
 *  上一首歌曲
 */
+ (SeraphMusic *)previousMusic;
@end
