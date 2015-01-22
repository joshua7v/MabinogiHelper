//
//  HMMusicTool.m
//  02-黑马音乐
//
//  Created by apple on 14-8-8.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "SeraphMusicTool.h"
#import "SeraphMusic.h"
#import "MJExtension.h"
#warning MJExtion
@implementation SeraphMusicTool
static NSArray *_musics;
static SeraphMusic *_playingMusic;

/**
 *  返回所有的歌曲
 */
+ (NSArray *)musics
{
    if (!_musics) {
        _musics = [SeraphMusic objectArrayWithFilename:@"Musics.plist"];
    }
    return _musics;
}

/**
 *  返回正在播放的歌曲
 */
+ (SeraphMusic *)playingMusic
{
    return _playingMusic;
}

+ (void)setPlayingMusic:(SeraphMusic *)playingMusic
{
    if (!playingMusic || ![[self musics] containsObject:playingMusic]) return;
    if (_playingMusic == playingMusic) return;
    
    _playingMusic = playingMusic;
}

/**
 *  下一首歌曲
 */
+ (SeraphMusic *)nextMusic
{
    int nextIndex = 0;
    if (_playingMusic) {
        int playingIndex = [[self musics] indexOfObject:_playingMusic];
        nextIndex = playingIndex + 1;
        if (nextIndex >= [self musics].count) {
            nextIndex = 0;
        }
    }
    return [self musics][nextIndex];
}

/**
 *  上一首歌曲
 */
+ (SeraphMusic *)previousMusic
{
    int previousIndex = 0;
    if (_playingMusic) {
        int playingIndex = [[self musics] indexOfObject:_playingMusic];
        previousIndex = playingIndex - 1;
        if (previousIndex < 0) {
            previousIndex = [self musics].count - 1;
        }
    }
    return [self musics][previousIndex];
}
@end
