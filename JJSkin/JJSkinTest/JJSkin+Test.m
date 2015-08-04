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
    JJSkinManager *skinManager = [JJSkinManager sharedSkinManager];
    
    // Common
    //// string
    NSString *stringValue = [skinManager getStringByID:@"R.stringValue"];
    assert([stringValue isEqualToString:@"1234567890"]);
    //// int
    NSInteger intergerValue = [skinManager getIntegerByID:@"R.intergerValue"];
    assert(890 == intergerValue);
    //// float
    CGFloat floatValue = [skinManager getFloatByID:@"R.floatValue"];
    assert((234.9 - floatValue) < 0.1);
    //// bool
    BOOL boolValue = [skinManager getFloatByID:@"R.boolValue"];
    assert(boolValue);
    //// edge inserts
    UIEdgeInsets inserts = [skinManager getEdgeInsetsByID:@"R.edgeInsets"];
    UIEdgeInsets inserts1 = {1,2,3,4};
    assert(UIEdgeInsetsEqualToEdgeInsets(inserts, inserts1));
    //// rect
    CGRect rect = [skinManager getRectByID:@"R.rect"];
    CGRect rect1 = CGRectMake(5, 6, 7, 8);
    assert(CGRectEqualToRect(rect, rect1));
    //// size
    CGSize size = [skinManager getSizeByID:@"R.size"];
    CGSize size1 = CGSizeMake(9, 0);
    assert(CGSizeEqualToSize(size, size1));
    //// color
    __unused UIColor *color = [skinManager getColorByID:@"R.color"];
    __unused UIColor *color1 = [UIColor jj_colorWithRGBA:0xc5 green:0xd0 blue:0xd0];
    //assert(CGColorEqualToColor(color.CGColor, color1.CGColor));
    
    // Button
    __unused JJButtonStyle *buttonStyle = [skinManager getButtonStyleByID:@"R.button"];
    __unused UIButton *button = [skinManager getButtonByID:@"R.button"];
    
    // Font
    JJFontStyle *fontStyle = [skinManager getFontStyleByID:@"R.font"];
    assert([JJSkinStyleStatusFinish isEqualToString:fontStyle.status]);
    assert(([JJSkinManager getFloatFromString:fontStyle.fontSize] - 90) <= 0);
    assert([JJFontTypeBold isEqualToString:fontStyle.fontType]);
    assert(!fontStyle.fontName);
    
    UIFont *font = [skinManager getFontByID:@"R.font"];
    assert((font.pointSize - 90) <= 0);
    //assert([font.fontName isEqualToString:@".HelveticaNeueInterface-MediumP4"]);
    
    JJFontStyle *fontStyle1 = [skinManager getFontStyleByID:@"R.font1"];
    assert(!fontStyle1.status);
    assert(([JJSkinManager getFloatFromString:fontStyle1.fontSize] - 50) <= 0);
    assert([fontStyle1.fontName isEqualToString:@"Verdana"]);
    assert(!fontStyle1.fontType);
    
    UIFont *font1 = [skinManager getFontByID:@"R.font1"];
    assert((font1.pointSize - 50) <= 0);
    assert([font1.familyName isEqualToString:@"Verdana"]);

    // Image View
    __unused JJImageViewStyle *imageViewStyle = [skinManager getImageViewStyleByID:@"R.imageView"];
    __unused UIImageView *imageView = [skinManager getImageViewByID:@"R.imageView"];
    
    // Label
    __unused JJLabelStyle *labelStyle = [skinManager getLabelStyleByID:@"R.label"];
    
    /**
     test result
     1   (double) $0 = 0.0001099705696105957
     10  (double) $0 = 0.00045496225357055664
     50  (double) $0 = 0.0026829838752746582
     100 (double) $0 = 0.0027459859848022461
     200 (double) $0 = 0.0062749981880187988
     500 (double) $0 = 0.01586604118347168
     */
    __unused double labelConsumeTime = measureExecutionTime(^{
        
        for (int i = 0; i < 1; ++i)
        {
            __unused UILabel *label = [skinManager getLabelByID:@"R.label"];
        }
    });
    
    __unused UILabel *label1 = [[UILabel alloc] init];
    [skinManager updateLabel:label1 withID:@"R.label"];
    
    // View
    __unused JJViewStyle *viewStyle = [skinManager getViewStyleByID:@"R.view"];
    __unused UIView *view = [skinManager getViewByID:@"R.view"];
    
    // Cache
    __unused JJViewStyle *cacheStyle = [skinManager getViewStyleByID:@"R.cache"];
    __unused UIView *cache = [skinManager getViewByID:@"R.cache"];
    __unused UIView *cache2 = [skinManager getViewByID:@"R.cache"];
    
    // Inherit
    __unused JJImageViewStyle *inheritImageViewStyle = [skinManager getImageViewStyleByID:@"R.inheritImageView"];
    __unused UIImageView *inheritImageView = [skinManager getImageViewByID:@"R.inheritImageView"];
    
    // More file
    __unused JJLabelStyle *moreFileLabelStyle = [skinManager getLabelStyleByID:@"R.moreFileLabel"];
    __unused UILabel *moreFileLabel = [skinManager getLabelByID:@"R.moreFileLabel"];
    
    __unused JJLabelStyle *moreFileStatusIncludeSonLabelStyle = [skinManager getLabelStyleByID:@"R.moreFileStatusIncludeSonLabel"];
    __unused UILabel *moreFileStatusIncludeSonLabel = [skinManager getLabelByID:@"R.moreFileStatusIncludeSonLabel"];
    
    __unused JJLabelStyle *moreFileStatusFinishLabelStyle = [skinManager getLabelStyleByID:@"R.moreFileStatusFinishLabel"];
    __unused UILabel *moreFileStatusFinishLabel = [skinManager getLabelByID:@"R.moreFileStatusFinishLabel"];
    
    // self defind style
    __unused JJMyselfTestView *myselfTestView = [[JJMyselfTestView alloc] initWithFrame:CGRectZero];
    
    __unused double consumeTime = measureExecutionTime(^{
        
        for (int i = 0; i < 500; ++i)
        {
            __unused JJMyselfTestView *myselfTestView1 = [skinManager getObjectByID:@"R.myselfTestView" withStyleClass:[JJMyselfTestStyle class]];
        }
    });
    
    /************* below need landsacpe ******************/
    
    // merge
    __unused JJLabelStyle *mergeLabelStyle = [skinManager getLabelStyleByID:@"R.mergeLabel"];
    __unused UILabel *mergeLabel = [skinManager getLabelByID:@"R.mergeLabel"];
    
    // merge status
    __unused JJLabelStyle *mergeStatueLabelStyle = [skinManager getLabelStyleByID:@"R.mergeStatueLabel"];
    __unused UILabel *mergeStatueLabel = [skinManager getLabelByID:@"R.mergeStatueLabel"];
}
