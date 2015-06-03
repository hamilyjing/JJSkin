//
//  JJButtonStyle.h
//  JJSkin
//
//  Created by JJ on 5/29/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "JJControlStyle.h"

extern NSString *JJButtonTypeCustom;
extern NSString *JJButtonTypeSystem;
extern NSString *JJButtonTypeDetailDisclosure;
extern NSString *JJButtonTypeInfoLight;
extern NSString *JJButtonTypeInfoDark;
extern NSString *JJButtonTypeContactAdd;

@class JJLabelStyle;

@interface JJButtonStyle : JJControlStyle

@property (nonatomic, copy) NSString *buttonType;

@property (nonatomic, strong) JJLabelStyle *labelStyle;

@property (nonatomic, copy) NSString *titleNormal;
@property (nonatomic, copy) NSString *titleDisable;
@property (nonatomic, copy) NSString *titleHighlighted;
@property (nonatomic, copy) NSString *titleSelected;

@property (nonatomic, strong) UIColor *titleColorNormal;
@property (nonatomic, strong) UIColor *titleColorDisable;
@property (nonatomic, strong) UIColor *titleColorHighlighted;
@property (nonatomic, strong) UIColor *titleColorSelected;

@property (nonatomic, strong) UIImage *imageNormal;
@property (nonatomic, strong) UIImage *imageDisable;
@property (nonatomic, strong) UIImage *imageHighlighted;
@property (nonatomic, strong) UIImage *imageSelected;

@property (nonatomic, strong) UIImage *bgImageNormal;
@property (nonatomic, strong) UIImage *bgImageDisable;
@property (nonatomic, strong) UIImage *bgImageHighlighted;
@property (nonatomic, strong) UIImage *bgImageSelected;

@property (nonatomic, copy) NSString *contentInsets;
@property (nonatomic, copy) NSString *titleInsets;
@property (nonatomic, copy) NSString *imageInsets;

@end
