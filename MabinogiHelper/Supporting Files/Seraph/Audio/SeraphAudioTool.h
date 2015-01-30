//
//  SeraphAudioTool.h
//  Seraph
//
//  Created by Joshua on 14/12/9.
//  Copyright (c) 2014年 SigmaStudio. All rights reserved.
//  播放本地音乐/音效

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface SeraphAudioTool : NSObject
/**
 *  播放音乐
 *
 *  @param filename 音乐的文件名
 */
+ (AVAudioPlayer *)playMusic:(NSString *)filename;
/**
 *  暂停音乐
 *
 *  @param filename 音乐的文件名
 */
+ (void)pauseMusic:(NSString *)filename;
/**
 *  停止音乐
 *
 *  @param filename 音乐的文件名
 */
+ (void)stopMusic:(NSString *)filename;

/**
 *  播放音效
 *
 *  @param filename 音效的文件名
 */
+ (void)playSound:(NSString *)filename;
/**
 *  销毁音效
 *
 *  @param filename 音效的文件名
 */
+ (void)disposeSound:(NSString *)filename;
@end
