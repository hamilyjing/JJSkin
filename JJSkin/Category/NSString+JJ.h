//
//  NSString+JJ.h
//  JJObjCTool
//
//  Created by hamilyjing on 5/11/15.
//  Copyright (c) 2015 gongjian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (JJ)

#pragma mark - Data

- (NSData *)jj_data;

#pragma mark - UI

- (CGSize)jj_textSize:(UIFont *)font;

#pragma mark - Remove characters

- (NSString *)jj_trimWhitespace; // 删除两边空格
- (NSString *)jj_trimNewline; // 删除回车
- (NSString *)jj_trimWhitespaceAndNewline; // 删除两边空格和回车

#pragma mark - UUID

+ (NSString *)jj_UUID;

#pragma mark - MD5

- (NSString *)jj_md5String;
- (NSData *)jj_md5Data;

#pragma mark - Base64

- (NSString *)jj_base64EncodedString;
- (NSData *)jj_base64EncodedData;
- (NSString *)jj_base64DecodedString;
- (NSData *)jj_base64DecodedData;

#pragma mark - JSON

- (NSDictionary *)jj_dictionaryWithJSON;

#pragma mark - URL

- (NSString*)jj_urlEncodedString;
- (NSString*)jj_urlDecodedString;

- (NSString *)jj_urlEncodeUsingEncoding:(CFStringEncoding)encoding;
- (NSString *)jj_urlDecodeUsingEncoding:(CFStringEncoding)encoding;

// http://www.example.com/index.php?key1=value1&key2=value2 , the query string is key1=value1&key2=value2. Self is "key1=value1&key2=value2"
- (NSDictionary *)jj_dictionaryWithURLQuery;

#pragma mark - SubString

- (NSString *)jj_subStringBeforeFirstSeparator:(NSString *)separator;
- (NSString *)jj_subStringAfterFirstSeparator:(NSString *)separator;

- (NSArray *)jj_stringBetweenTheSameString:(NSString *)separator;

@end
