//
//  JJTextFieldStyle.h
//  JJSkin
//
//  Created by JJ on 6/8/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "JJControlStyle.h"

@class JJFontStyle;

@interface JJTextFieldStyle : JJControlStyle

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) JJFontStyle *font;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, copy) NSString *textAlignment; // NSTextAlignment

@property (nonatomic, copy) NSString *autocapitalizationType; // UITextAutocapitalizationType
@property (nonatomic, copy) NSString *autocorrectionType; // UITextAutocorrectionType
@property (nonatomic, copy) NSString *spellCheckingType; // UITextSpellCheckingType
@property (nonatomic, copy) NSString *enablesReturnKeyAutomatically;
@property (nonatomic, copy) NSString *keyboardAppearance; // UIKeyboardAppearance
@property (nonatomic, copy) NSString *keyboardType; // UIKeyboardType
@property (nonatomic, copy) NSString *returnKeyType; // UIReturnKeyType
@property (nonatomic, copy) NSString *secureTextEntry;

@end
