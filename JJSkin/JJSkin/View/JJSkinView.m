//
//  JJSkinView.m
//  JJSkin
//
//  Created by JJ on 6/1/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import "JJSkinView.h"

NSString *JJSkinChangedNotification = @"JJSkinChangedNotification";

@implementation JJSkinView

- (void)dealloc
{
    self.shouldRegisterSkinHandle = NO;
}

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (void)awakeFromNib
{
    self.shouldRegisterSkinHandle = YES;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.shouldRegisterSkinHandle = YES;
    }
    
    return self;
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
