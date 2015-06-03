//
//  NSData+JJ.h
//  JJSkin
//
//  Created by JJ on 5/12/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (JJ)

// JSON
- (NSDictionary *)jj_dictionaryWithJSON;
+ (NSDictionary *)jj_dictionaryWithJSONByFilePath:(NSString *)filePath;

@end
