//
//  MJImageModel.h
//  MJImagePicker_Example
//
//  Created by Yang Yu on 2019/2/28.
//  Copyright © 2019 yangyu2010@aliyun.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DBModel/DBModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface MJImageModel : DBModel

/// 图片
@property (nonatomic, strong) UIImage<JsonIgnore, DBIgnore> *image;
/// 图片的远程URL
@property (nonatomic, copy) NSString *imageURLString;
/// 图片的md5
@property (nonatomic, copy) NSString *imageMD5String;

@end

NS_ASSUME_NONNULL_END
