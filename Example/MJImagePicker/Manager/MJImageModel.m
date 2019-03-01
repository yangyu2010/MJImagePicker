//
//  MJImageModel.m
//  MJImagePicker_Example
//
//  Created by Yang Yu on 2019/2/28.
//  Copyright © 2019 yangyu2010@aliyun.com. All rights reserved.
//

#import "MJImageModel.h"
#import <SDWebImage/SDImageCache.h>

@implementation MJImageModel


- (void)setImage:(UIImage<JsonIgnore,DBIgnore> *)image {
    _image = image;
    
    
//    [SDImageCache sharedImageCache] storeImage:<#(nullable UIImage *)#> forKey:<#(nullable NSString *)#> completion:<#^(void)completionBlock#>
}

@end
