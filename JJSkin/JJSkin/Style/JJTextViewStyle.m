//
//  JJTextViewStyle.m
//  JJSkin
//
//  Created by JJ on 6/8/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import "JJTextViewStyle.h"

#import "JJFontStyle.h"
#import "JJSkinManager.h"

@implementation JJTextViewStyle

#pragma mark - JJSkinStyleDataSource

+ (id)objectFromStyle:(id)style
{
    UITextView *textView = [[UITextView alloc] init];
    [style updateObject:textView];
    return textView;
}

- (void)updateObject:(id)object
{
    [super updateObject:object];
    
    UITextView *textView = (UITextView *)object;
    
    if (_text)
    {
        textView.text = _text;
    }
    
    if (_font)
    {
        textView.font = [JJFontStyle objectFromStyle:_font];
    }
    
    if (_textColor)
    {
        textView.textColor = _textColor;
    }
    
    if (_textAlignment)
    {
        textView.textAlignment = [JJSkinManager getIntegerFromString:_textAlignment];
    }
    
    if (_autocapitalizationType)
    {
        textView.autocapitalizationType = [JJSkinManager getIntegerFromString:_autocapitalizationType];
    }
    
    if (_autocorrectionType)
    {
        textView.autocorrectionType = [JJSkinManager getIntegerFromString:_autocorrectionType];
    }
    
    if (_spellCheckingType)
    {
        textView.spellCheckingType = [JJSkinManager getIntegerFromString:_spellCheckingType];
    }
    
    if (_enablesReturnKeyAutomatically)
    {
        textView.enablesReturnKeyAutomatically = [JJSkinManager getBoolFromString:_enablesReturnKeyAutomatically];
    }
    
    if (_keyboardAppearance)
    {
        textView.keyboardAppearance = [JJSkinManager getIntegerFromString:_keyboardAppearance];
    }
    
    if (_keyboardType)
    {
        textView.keyboardType = [JJSkinManager getIntegerFromString:_keyboardType];
    }
    
    if (_returnKeyType)
    {
        textView.returnKeyType = [JJSkinManager getIntegerFromString:_returnKeyType];
    }
    
    if (_secureTextEntry)
    {
        textView.secureTextEntry = [JJSkinManager getBoolFromString:_secureTextEntry];
    }
}

@end
