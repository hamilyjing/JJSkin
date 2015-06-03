//
//  NSData+JJ.m
//  JJSkin
//
//  Created by JJ on 5/12/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import "NSData+JJ.h"

@implementation NSData (JJ)

+ (NSDictionary *)jj_dictionaryWithJSONByFilePath:(NSString *)filePath
{
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    return [data jj_dictionaryWithJSON];
}

- (NSDictionary *)jj_dictionaryWithJSON
{
    id result = [NSJSONSerialization JSONObjectWithData:self
                                                options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves
                                                  error:nil];
    return result;
}

@end
