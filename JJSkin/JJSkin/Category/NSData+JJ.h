//
//  NSData+JJ.h
//  JJObjCTool
//
//  Created by hamilyjing on 5/12/15.
//  Copyright (c) 2015 gongjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (JJ)

#pragma mark - String

- (NSString *)jj_UFT8String;

#pragma mark - JSON

- (NSDictionary *)jj_dictionaryWithJSON;
+ (NSDictionary *)jj_dictionaryWithJSONByFilePath:(NSString *)filePath;

#pragma mark - UIImage

- (NSString *)jj_contentTypeForImageData;

#pragma mark - MD5

- (NSString *)jj_md5Sting;
- (NSData *)jj_md5Data;

#pragma mark - Base64

- (NSString *)jj_base64EncodedString;
- (NSData *)jj_base64EncodedData;
- (NSString *)jj_base64DecodedString;
- (NSData *)jj_base64DecodedData;

#pragma mark - AES

- (NSData *)jj_encryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv;
- (NSData *)jj_decryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv;

#pragma mark - 3DES

- (NSData *)jj_encryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv;
- (NSData *)jj_decryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv;

@end
