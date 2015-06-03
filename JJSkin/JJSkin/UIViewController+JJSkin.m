//
//  UIViewController+JJSkin.m
//  JJSkin
//
//  Created by JJ on 6/1/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import "UIViewController+JJSkin.h"

extern NSString *JJSkinChangedNotification;

@implementation UIViewController (JJSkin)

- (void)registerSkinHandle
{
    [self removeSkinHandle];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(skinChangedNotification:) name:JJSkinChangedNotification object:nil];
}

- (void)removeSkinHandle
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self name:JJSkinChangedNotification object:nil];
}

- (void)layoutViewsWhenSkinChanged
{
    
}

#pragma mark - skin changed notification

- (void)skinChangedNotification:(NSNotification *)notification
{
    [self layoutViewsWhenSkinChanged];
}

@end
