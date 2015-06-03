//
//  JJLabelStyle.m
//
//
//  Created by JJ on 13-4-11.
//
//

#import "JJLabelStyle.h"

#import "JJFontStyle.h"
#import "JJSkinManager.h"

@implementation JJLabelStyle

#pragma mark - JJSkinStyleDataSource

+ (id)objectFromStyle:(id)style
{
    UILabel *label = [[UILabel alloc] init];
    [style updateObject:label];
    return label;
}

- (void)updateObject:(id)object
{
    [super updateObject:object];
    
    UILabel *label = (UILabel *)object;
    
    if (_fontStyle)
    {
        label.font = [JJFontStyle objectFromStyle:_fontStyle];
    }
    
    if (_text)
    {
        label.text = NSLocalizedString(_text, nil);
    }
    if (_textColor)
    {
        label.textColor = _textColor;
    }
    
    [self setTextAlignmentByLabel:label];
    [self setTextLineBreakModeByLabel:label];
    
    if (_numberOfLines)
    {
        label.numberOfLines = [JJSkinManager getIntegerByID:_numberOfLines];
    }
    
    if (_highlightedTextColor)
    {
        label.highlightedTextColor = _highlightedTextColor;
    }
}

#pragma mark - Private

- (void)setTextAlignmentByLabel:(UILabel *)label
{
    if (!_textAlignment)
    {
        return;
    }
    
    NSTextAlignment alignment = NSTextAlignmentLeft;
    if ([JJTextAlignmentCenter isEqualToString:_textAlignment])
    {
        alignment = NSTextAlignmentCenter;
    }
    else if ([JJTextAlignmentRight isEqualToString:_textAlignment])
    {
        alignment = NSTextAlignmentRight;
    }
    else if ([JJTextAlignmentJustified isEqualToString:_textAlignment])
    {
        alignment = NSTextAlignmentJustified;
    }
    else if ([JJTextAlignmentNatural isEqualToString:_textAlignment])
    {
        alignment = NSTextAlignmentNatural;
    }
    
    label.textAlignment = alignment;
}

- (void)setTextLineBreakModeByLabel:(UILabel *)label
{
    if (!_lineBreakMode)
    {
        return;
    }
    
    NSLineBreakMode breakMode = NSLineBreakByTruncatingTail;
    
    if ([JJTextLineBreakModeByWordWrapping isEqualToString:_lineBreakMode])
    {
        breakMode = NSLineBreakByWordWrapping;
    }
    else if ([JJTextLineBreakModeByCharWrapping isEqualToString:_lineBreakMode])
    {
        breakMode = NSLineBreakByCharWrapping;
    }
    else if ([JJTextLineBreakModeByClipping isEqualToString:_lineBreakMode])
    {
        breakMode = NSLineBreakByClipping;
    }
    else if ([JJTextLineBreakModeByTruncatingHead isEqualToString:_lineBreakMode])
    {
        breakMode = NSLineBreakByTruncatingHead;
    }
    else if ([JJTextLineBreakModeByTruncatingMiddle isEqualToString:_lineBreakMode])
    {
        breakMode = NSLineBreakByTruncatingMiddle;
    }
    
    label.lineBreakMode = breakMode;
}

@end

NSString *JJTextAlignmentLeft = @"left";
NSString *JJTextAlignmentCenter = @"center";
NSString *JJTextAlignmentRight = @"right";
NSString *JJTextAlignmentJustified = @"justified";
NSString *JJTextAlignmentNatural = @"natural";

NSString *JJTextLineBreakModeByWordWrapping = @"wordWrapping";
NSString *JJTextLineBreakModeByCharWrapping = @"charWrapping";
NSString *JJTextLineBreakModeByClipping = @"clipping";
NSString *JJTextLineBreakModeByTruncatingHead = @"truncatingHead";
NSString *JJTextLineBreakModeByTruncatingTail = @"truncatingTail";
NSString *JJTextLineBreakModeByTruncatingMiddle = @"truncatingMiddle";
