//
//  JJFontStyle.h
//  JJSkin
//
//  Created by JJ on 5/26/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "JJSkinStyle.h"

extern NSString *JJFontTypeStandard;
extern NSString *JJFontTypeBold;
extern NSString *JJFontTypeItalic;

@interface JJFontStyle : JJSkinStyle

@property (nonatomic, copy) NSString *fontSize;
@property (nonatomic, copy) NSString *fontName;
@property (nonatomic, copy) NSString *fontType;

@end
