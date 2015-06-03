//
//  UIColor+JJ.h
//  JJSkin
//
//  Created by JJ on 5/11/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import <UIKit/UIKit.h>

#define JJ_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define JJ_RGB(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]

@interface UIColor (JJ)

// HEX
+ (UIColor *)colorWithHex:(NSInteger)hex; // RRGGBB
+ (UIColor *)colorWithHexIncludeAlpha:(NSInteger)hex; // AARRGGBB
+ (UIColor *)colorWithHex:(NSInteger)hex andAlpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexString:(NSString *)hexString; // #RGB, #ARGB, #RRGGBB, #AARRGGBB
- (NSString *)HEXString; // #RRGGBB

- (BOOL)equalToAnotherColor:(UIColor *)anotherColor;

@end
