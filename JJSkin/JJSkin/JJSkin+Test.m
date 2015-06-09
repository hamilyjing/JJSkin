//
//  JJSkin+Test.m
//  JJSkin
//
//  Created by JJ on 5/26/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "JJSkin+Test.h"
#import "JJMyselfTestStyle.h"

#import "JJSkin.h"
#import "UIColor+JJ.h"
#import "NSObject+JJ.h"

double measureExecutionTime(void(^block)())
{
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    
    block();
    
    double executionTime = CFAbsoluteTimeGetCurrent() - startTime;
    return executionTime;
}

void jjSkinTest()
{
    // Common
    //// string
    NSString *stringValue = [JJSkinManager getStringByID:@"R.stringValue"];
    assert([stringValue isEqualToString:@"1234567890"]);
    //// int
    NSInteger intergerValue = [JJSkinManager getIntegerByID:@"R.intergerValue"];
    assert(890 == intergerValue);
    //// float
    CGFloat floatValue = [JJSkinManager getFloatByID:@"R.floatValue"];
    assert((234.9 - floatValue) < 0.1);
    //// bool
    BOOL boolValue = [JJSkinManager getFloatByID:@"R.boolValue"];
    assert(boolValue);
    //// edge inserts
    UIEdgeInsets inserts = [JJSkinManager getEdgeInsetsByID:@"R.edgeInsets"];
    UIEdgeInsets inserts1 = {1,2,3,4};
    assert(UIEdgeInsetsEqualToEdgeInsets(inserts, inserts1));
    //// rect
    CGRect rect = [JJSkinManager getRectByID:@"R.rect"];
    CGRect rect1 = CGRectMake(5, 6, 7, 8);
    assert(CGRectEqualToRect(rect, rect1));
    //// size
    CGSize size = [JJSkinManager getSizeByID:@"R.size"];
    CGSize size1 = CGSizeMake(9, 0);
    assert(CGSizeEqualToSize(size, size1));
    //// color
    __unused UIColor *color = [JJSkinManager getColorByID:@"R.color"];
    __unused UIColor *color1 = JJ_RGBA(0xc5, 0x8d, 0xd0, 1);
    //assert(CGColorEqualToColor(color.CGColor, color1.CGColor));
    
    // Button
    __unused JJButtonStyle *buttonStyle = [JJSkinManager getButtonStyleByID:@"R.button"];
    __unused UIButton *button = [JJSkinManager getButtonByID:@"R.button"];
    
    // Font
    JJFontStyle *fontStyle = [JJSkinManager getFontStyleByID:@"R.font"];
    assert([JJSkinStyleStatusFinish isEqualToString:fontStyle.status]);
    assert(([JJSkinManager getFloatFromString:fontStyle.fontSize] - 90) <= 0);
    assert([JJFontTypeBold isEqualToString:fontStyle.fontType]);
    assert(!fontStyle.fontName);
    
    UIFont *font = [JJSkinManager getFontByID:@"R.font"];
    assert((font.pointSize - 90) <= 0);
    assert([font.fontName isEqualToString:@".HelveticaNeueInterface-MediumP4"]);
    
    JJFontStyle *fontStyle1 = [JJSkinManager getFontStyleByID:@"R.font1"];
    assert(!fontStyle1.status);
    assert(([JJSkinManager getFloatFromString:fontStyle1.fontSize] - 50) <= 0);
    assert([fontStyle1.fontName isEqualToString:@"Verdana"]);
    assert(!fontStyle1.fontType);
    
    UIFont *font1 = [JJSkinManager getFontByID:@"R.font1"];
    assert((font1.pointSize - 50) <= 0);
    assert([font1.familyName isEqualToString:@"Verdana"]);

    // Image View
    __unused JJImageViewStyle *imageViewStyle = [JJSkinManager getImageViewStyleByID:@"R.imageView"];
    __unused UIImageView *imageView = [JJSkinManager getImageViewByID:@"R.imageView"];
    
    // Label
    __unused JJLabelStyle *labelStyle = [JJSkinManager getLabelStyleByID:@"R.label"];
    
    __unused double labelConsumeTime = measureExecutionTime(^{
        
        for (int i = 0; i < 1; ++i)
        {
            __unused UILabel *label = [JJSkinManager getLabelByID:@"R.label"];
        }
    });
    
    __unused UILabel *label1 = [[UILabel alloc] init];
    [JJSkinManager updateLabel:label1 withID:@"R.label"];
    
    // View
    __unused JJViewStyle *viewStyle = [JJSkinManager getViewStyleByID:@"R.view"];
    __unused UIView *view = [JJSkinManager getViewByID:@"R.view"];
    
    // Cache
    __unused JJViewStyle *cacheStyle = [JJSkinManager getViewStyleByID:@"R.cache"];
    __unused UIView *cache = [JJSkinManager getViewByID:@"R.cache"];
    __unused UIView *cache2 = [JJSkinManager getViewByID:@"R.cache"];
    
    // Inherit
    __unused JJImageViewStyle *inheritImageViewStyle = [JJSkinManager getImageViewStyleByID:@"R.inheritImageView"];
    __unused UIImageView *inheritImageView = [JJSkinManager getImageViewByID:@"R.inheritImageView"];
    
    // More file
    __unused JJLabelStyle *moreFileLabelStyle = [JJSkinManager getLabelStyleByID:@"R.moreFileLabel"];
    __unused UILabel *moreFileLabel = [JJSkinManager getLabelByID:@"R.moreFileLabel"];
    
    __unused JJLabelStyle *moreFileStatusIncludeSonLabelStyle = [JJSkinManager getLabelStyleByID:@"R.moreFileStatusIncludeSonLabel"];
    __unused UILabel *moreFileStatusIncludeSonLabel = [JJSkinManager getLabelByID:@"R.moreFileStatusIncludeSonLabel"];
    
    __unused JJLabelStyle *moreFileStatusFinishLabelStyle = [JJSkinManager getLabelStyleByID:@"R.moreFileStatusFinishLabel"];
    __unused UILabel *moreFileStatusFinishLabel = [JJSkinManager getLabelByID:@"R.moreFileStatusFinishLabel"];
    
    // self defind style
    __unused JJMyselfTestView *myselfTestView = [[JJMyselfTestView alloc] initWithFrame:CGRectZero];
    
    __unused double consumeTime = measureExecutionTime(^{
        
        for (int i = 0; i < 500; ++i)
        {
            __unused JJMyselfTestView *myselfTestView1 = [JJSkinManager getObjectByID:@"R.myselfTestView" withStyleClass:[JJMyselfTestStyle class]];
        }
    });
    
    /************* below need landsacpe ******************/
    
    // merge
    __unused JJLabelStyle *mergeLabelStyle = [JJSkinManager getLabelStyleByID:@"R.mergeLabel"];
    __unused UILabel *mergeLabel = [JJSkinManager getLabelByID:@"R.mergeLabel"];
    
    // merge status
    __unused JJLabelStyle *mergeStatueLabelStyle = [JJSkinManager getLabelStyleByID:@"R.mergeStatueLabel"];
    __unused UILabel *mergeStatueLabel = [JJSkinManager getLabelByID:@"R.mergeStatueLabel"];
}
