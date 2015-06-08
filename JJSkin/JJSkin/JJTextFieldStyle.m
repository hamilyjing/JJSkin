//
//  JJTextFieldStyle.m
//  JJSkin
//
//  Created by gongjian03 on 6/8/15.
//  Copyright (c) 2015 gongjian. All rights reserved.
//

#import "JJTextFieldStyle.h"

#import "JJFontStyle.h"
#import "JJSkinManager.h"

@implementation JJTextFieldStyle

#pragma mark - JJSkinStyleDataSource

+ (id)objectFromStyle:(id)style
{
    UITextField *textField = [[UITextField alloc] init];
    [style updateObject:textField];
    return textField;
}

- (void)updateObject:(id)object
{
    [super updateObject:object];
    
    UITextField *textField = (UITextField *)object;
    
    if (_text)
    {
        textField.text = _text;
    }
    
    if (_placeholder)
    {
        textField.placeholder = _placeholder;
    }
    
    if (_font)
    {
        textField.font = [JJFontStyle objectFromStyle:_font];
    }
    
    if (_textColor)
    {
        textField.textColor = _textColor;
    }
    
    if (_textAlignment)
    {
        textField.textAlignment = [JJSkinManager getIntegerFromString:_textAlignment];
    }
    
    if (_autocapitalizationType)
    {
        textField.autocapitalizationType = [JJSkinManager getIntegerFromString:_autocapitalizationType];
    }
    
    if (_autocorrectionType)
    {
        textField.autocorrectionType = [JJSkinManager getIntegerFromString:_autocorrectionType];
    }
    
    if (_spellCheckingType)
    {
        textField.spellCheckingType = [JJSkinManager getIntegerFromString:_spellCheckingType];
    }
    
    if (_enablesReturnKeyAutomatically)
    {
        textField.enablesReturnKeyAutomatically = [JJSkinManager getBoolFromString:_enablesReturnKeyAutomatically];
    }
    
    if (_keyboardAppearance)
    {
        textField.keyboardAppearance = [JJSkinManager getIntegerFromString:_keyboardAppearance];
    }
    
    if (_keyboardType)
    {
        textField.keyboardType = [JJSkinManager getIntegerFromString:_keyboardType];
    }
    
    if (_returnKeyType)
    {
        textField.returnKeyType = [JJSkinManager getIntegerFromString:_returnKeyType];
    }
    
    if (_secureTextEntry)
    {
        textField.secureTextEntry = [JJSkinManager getBoolFromString:_secureTextEntry];
    }
}

@end
