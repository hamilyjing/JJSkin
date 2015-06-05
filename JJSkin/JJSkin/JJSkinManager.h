//
//  JJSkinManager.h
//  JJSkin
//
//  Created by JJ on 5/26/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class JJButtonStyle;
@class JJCommonStyle;
@class JJControlStyle;
@class JJFontStyle;
@class JJImageViewStyle;
@class JJLabelStyle;
@class JJViewStyle;

@protocol JJSkinConfig;

@interface JJSkinManager : NSObject

@property (nonatomic, strong) id<JJSkinConfig> skinConfig;

+ (instancetype)sharedSkinManager;

// Common Method to get style and object, or update object
+ (id)getStyleByID:(NSString *)id withStyleClass:(Class)styleClass;
+ (id)getObjectByID:(NSString *)id withStyleClass:(Class)styleClass;
+ (void)updateObject:(id)object withID:(NSString *)id withStyleClass:(Class)styleClass;

// Button
+ (JJButtonStyle *)getButtonStyleByID:(NSString *)id;
+ (UIButton *)getButtonByID:(NSString *)id;
+ (void)updateButton:(UIButton *)button withID:(NSString *)id;

// Font
+ (JJFontStyle *)getFontStyleByID:(NSString *)id;
+ (UIFont *)getFontByID:(NSString *)id;
+ (void)updateFont:(UIFont *)font withID:(NSString *)id;

// Image View
+ (JJImageViewStyle *)getImageViewStyleByID:(NSString *)id;
+ (UIImageView *)getImageViewByID:(NSString *)id;
+ (void)updateImageView:(UIImageView *)imageView withID:(NSString *)id;

// Label
+ (JJLabelStyle *)getLabelStyleByID:(NSString *)id;
+ (UILabel *)getLabelByID:(NSString *)id;
+ (void)updateLabel:(UILabel *)label withID:(NSString *)id;

// View
+ (JJViewStyle *)getViewStyleByID:(NSString *)id;
+ (UIView *)getViewByID:(NSString *)id;
+ (void)updateView:(UIView *)view withID:(NSString *)id;

// Common
+ (JJCommonStyle *)getCommonStyleByID:(NSString *)id;
+ (NSString *)getStringByID:(NSString *)id;
+ (NSInteger)getIntegerByID:(NSString *)id;
+ (CGFloat)getFloatByID:(NSString *)id;
+ (BOOL)getBoolByID:(NSString *)id;
+ (UIEdgeInsets)getEdgeInsetsByID:(NSString *)id; // "{top,left,bottom,right}"
+ (CGRect)getRectByID:(NSString *)id; // "{{x,y},{width,height}}"
+ (CGSize)getSizeByID:(NSString *)id; // "{width,height}"
+ (UIColor *)getColorByID:(NSString *)id; // "#AARRGGBB"

// Type conversion
+ (NSInteger)getIntegerFromString:(NSString *)string;
+ (CGFloat)getFloatFromString:(NSString *)string;
+ (BOOL)getBoolFromString:(NSString *)string;
+ (UIEdgeInsets)getEdgeInsetsFromString:(NSString *)string;
+ (CGRect)getRectFromString:(NSString *)string;
+ (CGSize)getSizeFromString:(NSString *)string;
+ (UIColor *)getColorFromString:(NSString *)string;
+ (UIImage *)getImageFromString:(NSString *)string;

// Change skin
- (void)changeSkin;

// Remove cache
- (void)removeAllStyleCache;
- (void)removeStyleCacheByID:(NSString *)id;

@end
