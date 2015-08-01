//
//  JJViewStyle.m
//  JJSkin
//
//  Created by JJ on 5/30/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import "JJViewStyle.h"

#import "JJSkinManager.h"

@implementation JJViewStyle

#pragma mark - JJSkinStyleDataSource

+ (id)objectFromStyle:(id)style
{
    UIView *view = [[UIView alloc] init];
    [style updateObject:view];
    return view;
}

- (void)updateObject:(id)object
{
    UIView *view = (UIView *)object;
    
    if (_frame)
    {
        view.frame = [JJSkinManager getRectFromString:_frame];
    }
    
    if (_backgroundColor)
    {
        view.backgroundColor = _backgroundColor;
    }
}

@end
