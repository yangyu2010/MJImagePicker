//
//  LCFileManager.h
//  LimitChat
//
//  Created by Yang Yu on 2018/5/30.
//  Copyright © 2018 Musjoy. All rights reserved.
//  管理文件

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ActionProtocol.h>

@interface LCFileManager : NSObject

/// 准备图片或者语音下载的文件
+ (void)prepareAssetPath;


/// 获取完整的图片文件夹
+ (NSString *)getLocalImagePath;
/// 获取完整的音频文件夹
+ (NSString *)getLocalAudioPath;
/// 获取完整的视频文件夹
+ (NSString *)getLocalVideoPath;


+ (BOOL)moveItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath;

@end
