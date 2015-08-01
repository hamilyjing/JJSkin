//
//  JJFontStyle.m
//  JJSkin
//
//  Created by JJ on 5/26/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import "JJFontStyle.h"

#import "JJSkinManager.h"

NSString *JJFontTypeStandard = @"standard";
NSString *JJFontTypeBold = @"bold";
NSString *JJFontTypeItalic = @"italic";

@implementation JJFontStyle

#pragma mark - JJSkinStyleDataSource

+ (id)objectFromStyle:(id)style
{
    JJFontStyle *fontStyle = (JJFontStyle *)style;
    
    CGFloat size = [JJSkinManager getFloatFromString: fontStyle.fontSize];
    if (size <= 0)
    {
        size = [UIFont labelFontSize];
    }
    
    UIFont *font = nil;
    
    if (fontStyle.fontName)
    {
        font = [UIFont fontWithName:fontStyle.fontName size:size];
    }
    else
    {
        if (!fontStyle.fontType || [fontStyle.fontType isEqualToString:JJFontTypeStandard])
        {
            font = [UIFont systemFontOfSize:size];
        }
        else if ([fontStyle.fontType isEqualToString:JJFontTypeBold])
        {
            font = [UIFont boldSystemFontOfSize:size];
        }
        else if ([fontStyle.fontType isEqualToString:JJFontTypeItalic])
        {
            font = [UIFont italicSystemFontOfSize:size];
        }
    }
    
    return font;
}

@end
