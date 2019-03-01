//
//  NSString+Category.m
//  SecretPhoto
//
//  Created by Podul on 2018/1/11.
//  Copyright © 2018年 Yang Yu. All rights reserved.
//

#import "NSString+Category.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Category)
#pragma mark - Set & Get
- (BOOL)isEmail {
    return [self isAvailability:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];
}

/// 是否为纯数字
- (BOOL)isPureNumber {
    if (!self.isPureDouble || ![self isPureLongLong]) {
        return NO;
    }
    return YES;
}

/// 是否为纯浮点数
- (BOOL)isPureDouble {
    NSScanner *scan = [NSScanner scannerWithString:self];
    double val;
    return [scan scanDouble:&val] && [scan isAtEnd];
}

- (NSString *)countNumAndChangeformat {
    // 判断是否为整数
    if (self.isPureNumber && [self containsString:@"."]) {
        return self;
    }
    int count = 0;
    long long int a = self.longLongValue;
    while (a != 0) {
        count ++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:self];
    NSMutableString *newString = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newString insertString:str atIndex:0];
        [newString insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newString insertString:string atIndex:0];
    return newString;
}

+ (NSString *)stringWithRandomUUID {
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    return [uuid lowercaseString];
}

/// 文件md5
- (NSString *)md5String {
    return (__bridge NSString *)FileMD5HashCreateWithPath((__bridge CFStringRef)self, 256);
}


#pragma mark - Privacy
- (BOOL)isAvailability:(NSString *)re {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", re];
    return [predicate evaluateWithObject:self];
}

/// 是否为纯整数
- (BOOL)isPureLongLong {
    NSScanner *scan = [NSScanner scannerWithString:self];
    long long val;
    return [scan scanLongLong:&val] && [scan isAtEnd];
}

/// 文件md5
CFStringRef FileMD5HashCreateWithPath(CFStringRef filePath,
                                      size_t chunkSizeForReadingData) {
    
    // Declare needed variables
    CFStringRef result = NULL;
    CFReadStreamRef readStream = NULL;
    
    // Get the file URL
    CFURLRef fileURL =
    CFURLCreateWithFileSystemPath(kCFAllocatorDefault,
                                  (CFStringRef)filePath,
                                  kCFURLPOSIXPathStyle,
                                  (Boolean)false);
    if (!fileURL) goto done;
    
    // Create and open the read stream
    readStream = CFReadStreamCreateWithFile(kCFAllocatorDefault,
                                            (CFURLRef)fileURL);
    if (!readStream) goto done;
    bool didSucceed = (bool)CFReadStreamOpen(readStream);
    if (!didSucceed) goto done;
    
    // Initialize the hash object
    CC_MD5_CTX hashObject;
    CC_MD5_Init(&hashObject);
    
    // Make sure chunkSizeForReadingData is valid
    if (!chunkSizeForReadingData) {
        chunkSizeForReadingData = 256;
    }
    
    // Feed the data to the hash object
    bool hasMoreData = true;
    while (hasMoreData) {
        uint8_t buffer[chunkSizeForReadingData];
        CFIndex readBytesCount = CFReadStreamRead(readStream,
                                                  (UInt8 *)buffer,
                                                  (CFIndex)sizeof(buffer));
        if (readBytesCount == -1) break;
        if (readBytesCount == 0) {
            hasMoreData = false;
            continue;
        }
        CC_MD5_Update(&hashObject,
                      (const void *)buffer,
                      (CC_LONG)readBytesCount);
    }
    
    // Check if the read operation succeeded
    didSucceed = !hasMoreData;
    
    // Compute the hash digest
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &hashObject);
    
    // Abort if the read operation failed
    if (!didSucceed) goto done;
    
    // Compute the string result
    char hash[2 * sizeof(digest) + 1];
    for (size_t i = 0; i < sizeof(digest); ++i) {
        snprintf(hash + (2 * i), 3, "%02x", (int)(digest[i]));
    }
    result = CFStringCreateWithCString(kCFAllocatorDefault,
                                       (const char *)hash,
                                       kCFStringEncodingUTF8);
    
    done:
    
    if (readStream) {
        CFReadStreamClose(readStream);
        CFRelease(readStream);
    }
    if (fileURL) {
        CFRelease(fileURL);
    }
    return result;
}

@end
