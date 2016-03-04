//
//  JJImageViewStyle.m
//  JJSkin
//
//  Created by JJ on 5/31/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import "JJImageViewStyle.h"

@implementation JJImageViewStyle

#pragma mark - JJSkinStyleDataSource

+ (id)objectFromStyle:(id)style
{
    UIImageView *imageView = [[UIImageView alloc] init];
    [style updateObject:imageView];
    return imageView;
}

- (void)updateObject:(id)object
{
    [super updateObject:object];
    
    UIImageView *imageView = (UIImageView *)object;
    
    if (_image)
    {
        imageView.image = _image;
    }
    
    if (_highlightedImage)
    {
        imageView.highlightedImage = _highlightedImage;
    }
}

@end
