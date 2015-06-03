//
//  NSString+JJ.m
//  JJSkin
//
//  Created by JJ on 5/11/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import "NSString+JJ.h"

@implementation NSString (JJ)

- (NSString *)jj_stringBetweenTheSameString:(NSString *)separator
{
    NSArray *array = [self componentsSeparatedByString:separator];
    if ([array count] >= 2)
    {
        return array[1];
    }
    return nil;
}

@end
