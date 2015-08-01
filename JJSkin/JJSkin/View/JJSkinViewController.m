//
//  JJSkinViewController.m
//  JJSkin
//
//  Created by JJ on 6/1/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import "JJSkinViewController.h"

@implementation JJSkinViewController

- (void)dealloc
{
    self.shouldRegisterSkinHandle = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.shouldRegisterSkinHandle = YES;
}

- (void)setShouldRegisterSkinHandle:(BOOL)shouldRegisterSkinHandle_
{
    if (_shouldRegisterSkinHandle != shouldRegisterSkinHandle_)
    {
        _shouldRegisterSkinHandle = shouldRegisterSkinHandle_;
        if (_shouldRegisterSkinHandle)
        {
            [self registerSkinHandle];
        }
        else
        {
            [self removeSkinHandle];
        }
    }
}

@end
