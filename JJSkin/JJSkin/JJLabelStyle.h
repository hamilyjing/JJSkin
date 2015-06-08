//
//  JJLabelStyle.h
//
//
//  Created by JJ on 13-4-11.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "JJViewStyle.h"

@class JJFontStyle;

@interface JJLabelStyle : JJViewStyle

@property (nonatomic, strong) JJFontStyle *fontStyle;

@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, copy) NSString *textAlignment; // NSTextAlignment
@property (nonatomic, copy) NSString *lineBreakMode; // NSLineBreakMode

@property (nonatomic, copy) NSString *numberOfLines;

@property (nonatomic, strong) UIColor *highlightedTextColor;

@end
