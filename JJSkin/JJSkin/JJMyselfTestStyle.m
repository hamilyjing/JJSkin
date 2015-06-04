//
//  JJMyselfTestStyle.m
//  JJSkin
//
//  Created by gongjian03 on 6/4/15.
//  Copyright (c) 2015 gongjian. All rights reserved.
//

#import "JJMyselfTestStyle.h"

#import "JJSkin.h"

@implementation JJMyselfTestView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.lable = [JJSkinManager getLabelByID:@"R.myselfTestView.label"];
        self.imageView = [JJSkinManager getImageViewByID:@"R.myselfTestView.imageView"];
    }
    
    return self;
}

@end

@implementation JJMyselfTestStyle

#pragma mark - JJSkinStyleDataSource

+ (id)objectFromStyle:(id)style
{
    JJMyselfTestView *view = [[JJMyselfTestView alloc] init];
    [style updateObject:view];
    return view;
}

- (void)updateObject:(id)object
{
    JJMyselfTestView *view = (JJMyselfTestView *)object;
    
    if (_label)
    {
        view.lable = [JJLabelStyle objectFromStyle:_label];
    }
    
    if (_imageView)
    {
        view.imageView = [JJImageViewStyle objectFromStyle:_imageView];
    }
}

@end
