//
//  JJScrollViewStyle.m
//  JJSkin
//
//  Created by gongjian03 on 6/8/15.
//  Copyright (c) 2015 gongjian. All rights reserved.
//

#import "JJScrollViewStyle.h"

#import "JJSkinManager.h"

@implementation JJScrollViewStyle

#pragma mark - JJSkinStyleDataSource

+ (id)objectFromStyle:(id)style
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [style updateObject:scrollView];
    return scrollView;
}

- (void)updateObject:(id)object
{
    [super updateObject:object];
    
    UIScrollView *scrollView = (UIScrollView *)object;
    
    if (_showsHorizontalScrollIndicator)
    {
        scrollView.showsHorizontalScrollIndicator = [JJSkinManager getBoolFromString:_showsHorizontalScrollIndicator];
    }
    
    if (_showsVerticalScrollIndicator)
    {
        scrollView.showsVerticalScrollIndicator = [JJSkinManager getBoolFromString:_showsVerticalScrollIndicator];
    }
}

@end
