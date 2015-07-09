//
//  JJSkinConfig.m
//  JJSkin
//
//  Created by JJ on 5/26/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import "JJSkinConfig.h"

#import "UIDevice+JJ.h"

@implementation JJSkinConfig

- (NSBundle *)bundle
{
    return [NSBundle mainBundle];
}

- (NSString *)fileNamePrefix
{
    return @"jjSkin-";
}

- (NSString *)fileType
{
    return @"json";
}

- (NSString *)landscapeJsonLabel
{
    return @"landscape";
}

- (NSString *)portraitJsonLabel
{
    return @"portrait";
}

- (NSString *)iPhoneFileNameSuffix
{
    return @"iPhone";
}

- (NSString *)iPadFileNameSuffix
{
    return @"iPad";
}

- (NSArray *)fileNames
{
    static NSMutableArray *mArray = nil;
    
    if ([mArray count] > 0)
    {
        return mArray;
    }
    
    mArray = [NSMutableArray array];
    
    // 后缀为平台描述的文件, "jjSkin-iPhone 5C.json"
    NSString *fileNamePrefix = [self fileNamePrefix];
    NSString *fileName1 = [fileNamePrefix stringByAppendingString:[UIDevice jj_platformSimpleDescription]];
    [mArray addObject:fileName1];
    
    // 后缀为屏幕尺寸的文件, "jjSkin-iPhone320x480.json"
    NSString *device = [UIDevice isiPad] ? [self iPadFileNameSuffix] : [self iPhoneFileNameSuffix];
    NSString *fileName2 = [fileNamePrefix stringByAppendingString:device];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    // 弥补iPhone 6和iPhone 6 Plus中的“设置”->“显示与亮度”->"显示模式"对[UIScreen mainScreen].bounds.size的影响
    if ([[UIDevice jj_platformSimpleDescription] isEqualToString:@"iPhone 6"])
    {
        screenSize= CGSizeMake(375, 667);
    }
    else if ([[UIDevice jj_platformSimpleDescription] isEqualToString:@"iPhone 6 Plus"])
    {
        screenSize= CGSizeMake(414, 736);
    }
    NSString *suffix = [NSString stringWithFormat:@"%ldx%ld", (long)screenSize.width, (long)screenSize.height];
    fileName2 = [fileName2 stringByAppendingString:suffix];
    [mArray addObject:fileName2];
    
    // 获取common文件内容
    NSString *fileName3 = [fileNamePrefix stringByAppendingString:device];
    [mArray addObject:fileName3];
    
    return mArray;
}

@end
