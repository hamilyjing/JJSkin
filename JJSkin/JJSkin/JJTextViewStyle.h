//
//  JJTextViewStyle.h
//  JJSkin
//
//  Created by gongjian03 on 6/8/15.
//  Copyright (c) 2015 gongjian. All rights reserved.
//

#import "JJScrollViewStyle.h"

@class JJFontStyle;

@interface JJTextViewStyle : JJScrollViewStyle

@property (nonatomic, copy) NSString *text;
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
