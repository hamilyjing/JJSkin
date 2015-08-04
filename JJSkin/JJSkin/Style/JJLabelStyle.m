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
    if (_textAlignment)
    {
        label.textAlignment = [JJSkinManager getIntegerFromString:_textAlignment];
    }
    if (_lineBreakMode)
    {
        label.lineBreakMode = [JJSkinManager getIntegerFromString:_lineBreakMode];
    }
    
    if (_numberOfLines)
    {
        label.numberOfLines = [JJSkinManager getIntegerFromString:_numberOfLines];
    }
    
    if (_highlightedTextColor)
    {
        label.highlightedTextColor = _highlightedTextColor;
    }
}

@end
