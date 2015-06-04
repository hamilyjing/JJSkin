//
//  JJMyselfTestStyle.h
//  JJSkin
//
//  Created by gongjian03 on 6/4/15.
//  Copyright (c) 2015 gongjian. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JJSkinStyle.h"

@class JJLabelStyle;
@class JJImageViewStyle;

@interface JJMyselfTestView : UIView

@property (nonatomic, strong) UILabel *lable;
@property (nonatomic, strong) UIImageView *imageView;

@end

@interface JJMyselfTestStyle : JJSkinStyle

@property (nonatomic, strong) JJLabelStyle *label;
@property (nonatomic, strong) JJImageViewStyle *imageView;

@end
