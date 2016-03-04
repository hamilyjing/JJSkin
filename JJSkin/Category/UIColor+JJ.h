//
//  UIColor+JJ.h
//  JJObjCTool
//
//  Created by hamilyjing on 5/11/15.
//  Copyright (c) 2015 gongjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (JJ)

#pragma mark - Image

- (UIImage *)jj_image;

#pragma mark - HEX to color

+ (UIColor *)jj_colorWithRGBA:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue;
+ (UIColor *)jj_colorWithRGBA:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(NSInteger)alpha;

+ (UIColor *)jj_colorWithHexIncludeAlpha:(NSInteger)hex; // AARRGGBB
+ (UIColor *)jj_colorWithHex:(NSInteger)hex; // RRGGBB
+ (UIColor *)jj_colorWithHex:(NSInteger)hex andAlpha:(CGFloat)alpha;

+ (UIColor *)jj_colorWithHexString:(NSString *)hexString; // #RGB, #ARGB, #RRGGBB, #AARRGGBB

- (NSString *)jj_hexString; // #RRGGBB

#pragma mark - Compare

- (BOOL)jj_equalToAnotherColor:(UIColor *)anotherColor;

@end
