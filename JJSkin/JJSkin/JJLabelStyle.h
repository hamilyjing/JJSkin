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
@property (nonatomic, copy) NSString *textAlignment;
@property (nonatomic, copy) NSString *lineBreakMode;

@property (nonatomic, copy) NSString *numberOfLines;

@property (nonatomic, strong) UIColor *highlightedTextColor;

@end

extern NSString *JJTextAlignmentLeft;
extern NSString *JJTextAlignmentCenter;
extern NSString *JJTextAlignmentRight;
extern NSString *JJTextAlignmentJustified;
extern NSString *JJTextAlignmentNatural;

extern NSString *JJTextLineBreakModeByWordWrapping;
extern NSString *JJTextLineBreakModeByCharWrapping;
extern NSString *JJTextLineBreakModeByClipping;
extern NSString *JJTextLineBreakModeByTruncatingHead;
extern NSString *JJTextLineBreakModeByTruncatingTail;
extern NSString *JJTextLineBreakModeByTruncatingMiddle;
