//
//  LCFileManager.m
//  LimitChat
//
//  Created by Yang Yu on 2018/5/30.
//  Copyright © 2018 Musjoy. All rights reserved.
//

#import "LCFileManager.h"
#import <FileSource/FileSource.h>


@implementation LCFileManager

/// 准备图片或者语音下载的文件
+ (void)prepareAssetPath {
    [self getLocalAudioPath];
    [self getLocalImagePath];
    [self getLocalVideoPath];
}

/// 获取完整的图片文件夹
+ (NSString *)getLocalImagePath {
    return [FileSource getLocalImagePath];
}

/// 获取完整的音频文件夹
+ (NSString *)getLocalAudioPath {
    return [FileSource getLocalAudioPath];
}

/// 获取完整的视频文件夹
+ (NSString *)getLocalVideoPath {
    return [FileSource getLocalVideoPath];
}



/// 移动文件
+ (BOOL)moveItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath {
    NSError *error = nil;
    [[NSFileManager defaultManager] moveItemAtPath:srcPath toPath:dstPath error:&error];
    if (error) {
        return NO;
    }
    return YES;
}

@end
