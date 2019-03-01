//
//  NSString+Category.h
//  SecretPhoto
//
//  Created by Podul on 2018/1/11.
//  Copyright © 2018年 Yang Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)
@property (nonatomic, readonly, getter=isEmail) BOOL email;                 ///< 是否为邮箱号码
@property (nonatomic, readonly, getter=isPureNumber) BOOL pureNumber;       ///< 是否为纯数字
@property (nonatomic, readonly, getter=isPureDouble) BOOL pureDouble;       ///< 是否为纯浮点数

/// 对整数进行格式化
- (NSString *)countNumAndChangeformat;

/// 获取随机的 uuid
+ (NSString *)stringWithRandomUUID;

/// 文件md5
- (NSString *)md5String;

@end
