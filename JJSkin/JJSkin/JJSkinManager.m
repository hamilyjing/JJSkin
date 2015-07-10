//
//  JJSkinManager.m
//  JJSkin
//
//  Created by JJ on 5/26/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import "JJSkinManager.h"

// category
#import "NSData+JJ.h"
#import "NSString+JJ.h"
#import "UIColor+JJ.h"
#import "UIDevice+JJ.h"

#import "JJSkinConfig.h"

// style
#import "JJCommonStyle.h"
#import "JJControlStyle.h"
#import "JJButtonStyle.h"
#import "JJFontStyle.h"
#import "JJImageViewStyle.h"
#import "JJLabelStyle.h"
#import "JJSkinStyle.h"
#import "JJSkinStyleDataSource.h"
#import "JJSkinStyleDelegate.h"
#import "JJViewStyle.h"

extern NSString *JJSkinChangedNotification;

@interface JJSkinManager ()

@property (nonatomic, strong) NSMutableDictionary *fileContentDic;
@property (nonatomic, strong) NSMutableDictionary *idStyleDic;

@end

@implementation JJSkinManager

+ (instancetype)sharedSkinManager
{
    static JJSkinManager *instance;
    static dispatch_once_t t;
    dispatch_once(&t, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.fileContentDic = [NSMutableDictionary dictionary];
        self.idStyleDic = [NSMutableDictionary dictionary];
        
        self.skinConfig = [[JJSkinConfig alloc] init];
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(handleMemoryWarning) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    
    return self;
}

#pragma mark - memory warning

- (void)handleMemoryWarning
{
    @synchronized(self)
    {
        [self.idStyleDic removeAllObjects];
    }
}

#pragma mark - Common Method to get style and object

+ (id)getStyleByID:(NSString *)id_ withStyleClass:(Class)styleClass_
{
    id style = [[self sharedSkinManager] getStyleByID:id_ styleClass:styleClass_];
    return style;
}

+ (id)getObjectByID:(NSString *)id_ withStyleClass:(Class)styleClass_
{
    id style = [self getStyleByID:id_ withStyleClass:styleClass_];
    id object = [[style class] objectFromStyle:style];
    
    return object;
}

+ (void)updateObject:(id)object_ withID:(NSString *)id_ withStyleClass:(Class)styleClass_
{
    id style = [[self sharedSkinManager] getStyleByID:id_ styleClass:styleClass_];
    [style updateObject:object_];
}

#pragma mark - UIFont

+ (JJFontStyle *)getFontStyleByID:(NSString *)id_
{
    JJFontStyle *style = [self getStyleByID:id_ withStyleClass:[JJFontStyle class]];
    return style;
}

+ (UIFont *)getFontByID:(NSString *)id_
{
    UIFont *font = [self getObjectByID:id_ withStyleClass:[JJFontStyle class]];
    return font;
}

+ (void)updateFont:(UIFont *)font_ withID:(NSString *)id_
{
    [self updateObject:font_ withID:id_ withStyleClass:[JJFontStyle class]];
}

#pragma mark - UIView

+ (JJViewStyle *)getViewStyleByID:(NSString *)id_
{
    JJViewStyle *style = [self getStyleByID:id_ withStyleClass:[JJViewStyle class]];
    return style;
}

+ (UIView *)getViewByID:(NSString *)id_
{
    UIView *view = [self getObjectByID:id_ withStyleClass:[JJViewStyle class]];
    return view;
}

+ (void)updateView:(UIView *)view_ withID:(NSString *)id_
{
    [self updateObject:view_ withID:id_ withStyleClass:[JJViewStyle class]];
}

#pragma mark - Button Style

+ (JJButtonStyle *)getButtonStyleByID:(NSString *)id_
{
    JJButtonStyle *style = [self getStyleByID:id_ withStyleClass:[JJButtonStyle class]];
    return style;
}

+ (UIButton *)getButtonByID:(NSString *)id_
{
    UIButton *button = [self getObjectByID:id_ withStyleClass:[JJButtonStyle class]];
    return button;
}

+ (void)updateButton:(UIButton *)button_ withID:(NSString *)id_
{
    [self updateObject:button_ withID:id_ withStyleClass:[JJButtonStyle class]];
}

#pragma mark - Image View Style

+ (JJImageViewStyle *)getImageViewStyleByID:(NSString *)id_
{
    JJImageViewStyle *style = [self getStyleByID:id_ withStyleClass:[JJImageViewStyle class]];
    return style;
}

+ (UIImageView *)getImageViewByID:(NSString *)id_
{
    UIImageView *imageView = [self getObjectByID:id_ withStyleClass:[JJImageViewStyle class]];
    return imageView;
}

+ (void)updateImageView:(UIImageView *)imageView_ withID:(NSString *)id_
{
    [self updateObject:imageView_ withID:id_ withStyleClass:[JJImageViewStyle class]];
}

#pragma mark - Label Style

+ (JJLabelStyle *)getLabelStyleByID:(NSString *)id_
{
    JJLabelStyle *style = [self getStyleByID:id_ withStyleClass:[JJLabelStyle class]];
    return style;
}

+ (UILabel *)getLabelByID:(NSString *)id_
{
    UILabel *label = [self getObjectByID:id_ withStyleClass:[JJLabelStyle class]];
    return label;
}

+ (void)updateLabel:(UILabel *)label_ withID:(NSString *)id_
{
    [self updateObject:label_ withID:id_ withStyleClass:[JJLabelStyle class]];
}

#pragma mark - Common Style

+ (JJCommonStyle *)getCommonStyleByID:(NSString *)id_
{
    JJCommonStyle *style = [self getStyleByID:id_ withStyleClass:[JJCommonStyle class]];
    return style;
}

+ (NSString *)getStringByID:(NSString *)id_
{
    JJCommonStyle *style = [self getCommonStyleByID:id_];
    return style.value;
}

+ (NSInteger)getIntegerByID:(NSString *)id_
{
    JJCommonStyle *style = [self getCommonStyleByID:id_];
    NSInteger value = [self getIntegerFromString:style.value];
    return value;
}

+ (CGFloat)getFloatByID:(NSString *)id_
{
    JJCommonStyle *style = [self getCommonStyleByID:id_];
    CGFloat value = [self getFloatFromString:style.value];
    return value;
}

+ (BOOL)getBoolByID:(NSString *)id_
{
    JJCommonStyle *style = [self getCommonStyleByID:id_];
    BOOL value = [self getBoolFromString:style.value];
    return value;
}

+ (UIEdgeInsets)getEdgeInsetsByID:(NSString *)id_
{
    JJCommonStyle *style = [self getCommonStyleByID:id_];
    UIEdgeInsets insets = [self getEdgeInsetsFromString:style.value];
    return insets;
}

+ (CGRect)getRectByID:(NSString *)id_
{
    JJCommonStyle *style = [self getCommonStyleByID:id_];
    CGRect rect = [self getRectFromString:style.value];
    return rect;
}

+ (CGSize)getSizeByID:(NSString *)id_
{
    JJCommonStyle *style = [self getCommonStyleByID:id_];
    CGSize size = [self getSizeFromString:style.value];
    return size;
}

+ (UIColor *)getColorByID:(NSString *)id_
{
    JJCommonStyle *style = [self getCommonStyleByID:id_];
    UIColor *color = [self getColorFromString:style.value];
    return color;
}

#pragma mark - Type conversion

+ (NSInteger)getIntegerFromString:(NSString *)string
{
    return [string integerValue];
}

+ (CGFloat)getFloatFromString:(NSString *)string
{
    return [string floatValue];
}

+ (BOOL)getBoolFromString:(NSString *)string
{
    return [string boolValue];
}

+ (UIEdgeInsets)getEdgeInsetsFromString:(NSString *)string
{
    return UIEdgeInsetsFromString(string);
}

+ (CGRect)getRectFromString:(NSString *)string
{
    return CGRectFromString(string);
}

+ (CGSize)getSizeFromString:(NSString *)string
{
    return CGSizeFromString(string);
}

+ (UIColor *)getColorFromString:(NSString *)string
{
    UIColor *color = [UIColor colorWithHexString:string];
    return color;
}

+ (UIImage *)getImageFromString:(NSString *)string
{
    UIImage *image = [UIImage imageNamed:string];
    return image;
}

#pragma mark - Change skin

+ (void)changeSkin
{
    [self removeAllStyleCache];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:JJSkinChangedNotification object:self];
}

#pragma mark - Remove cache

+ (void)removeAllStyleCache
{
    JJSkinManager *skinManager = [self sharedSkinManager];
    
    [skinManager.idStyleDic removeAllObjects];
}

+ (void)removeStyleCacheByID:(NSString *)id_
{
    JJSkinManager *skinManager = [self sharedSkinManager];
    
    NSString *idKey = [id_ stringByAppendingString:[skinManager.skinConfig portraitJsonLabel]];
    [skinManager.idStyleDic removeObjectForKey:idKey];
    
    idKey = [id_ stringByAppendingString:[skinManager.skinConfig landscapeJsonLabel]];
    [skinManager.idStyleDic removeObjectForKey:idKey];
}

+ (void)removeStyleCacheByPrefixID:(NSString *)prefixID_
{
    JJSkinManager *skinManager = [self sharedSkinManager];
    
    NSMutableDictionary *savedIDStyleDic = [NSMutableDictionary dictionary];
    
    [skinManager.idStyleDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
    {
        NSRange range = [key rangeOfString:prefixID_];
        if (range.location != 0)
        {
            savedIDStyleDic[key] = obj;
        }
    }];
    
    skinManager.idStyleDic = savedIDStyleDic;
}

#pragma mark - Common

- (NSArray *)idPath:(NSString *)id_
{
    NSMutableArray *mArray = [[id_ componentsSeparatedByString:@"."] mutableCopy];
    
    NSAssert([mArray count] > 0, nil);
    
    NSString *rootLabel = [self interfaceOritationDescription];
    
    if (rootLabel)
    {
        [mArray replaceObjectAtIndex:0 withObject:rootLabel];
    }
    else
    {
        [mArray removeObjectAtIndex:0];
    }
    
    return mArray;
}

- (NSDictionary *)getFileContent:(NSString *)fileName_
{
    NSDictionary *content = [_fileContentDic objectForKey:fileName_];
    if (!content)
    {
        content = [self fileContent:fileName_];
        
        NSAssert(content, nil);
        
        [_fileContentDic setObject:content forKey:fileName_];
    }
    
    return content;
}

- (NSDictionary *)idPathLastObjectValue:(NSString *)fileName_ withIdPath:(NSArray *)idPath_
{
    NSDictionary *fileContent = [self getFileContent:fileName_];
    
    __block NSDictionary *content = fileContent;
    [idPath_ enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         content = content[obj];
         if (!content)
         {
             *stop = YES;
         }
     }];
    
    return content;
}

- (id)getStyleByFileName:(NSString *)fileName_ withIdPath:(NSArray *)idPath_ styleClass:(Class)class_
{
    NSDictionary *content = [self idPathLastObjectValue:fileName_ withIdPath:idPath_];
    if (!content)
    {
        return nil;
    }
    
    return [class_ styleFromContent:content];
}

- (NSDictionary *)fileContent:(NSString *)fileName_
{
    NSString *filePath = [self filePath:fileName_];
    NSDictionary *dic = [NSData jj_dictionaryWithJSONByFilePath:filePath];
    return dic;
}

- (NSString *)filePath:(NSString *)fileName_
{
    NSString *filePath = [[_skinConfig bundle] pathForResource:fileName_ ofType:[_skinConfig fileType]];
    return filePath;
}

- (BOOL)fileExist:(NSString *)fileName_
{
    NSString *filePath = [self filePath:fileName_];
    BOOL exist = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    return exist;
}

- (id)getStyleByID:(NSString *)id_ styleClass:(Class)class_
{
    NSString *idKey = [id_ stringByAppendingString:[self interfaceOritationDescription]];
    
    id style = [_idStyleDic objectForKey:idKey];
    if (style)
    {
        return style;
    }
    
    NSArray *idPath = [self idPath:id_];
    
    NSMutableArray *fileNames = [NSMutableArray array];
    for (NSString *fileName in [_skinConfig fileNames])
    {
        if ([self fileExist:fileName])
        {
            [fileNames addObject:fileName];
        }
    }
    
    style = [self getStyleByFileNames:fileNames withIdPath:idPath lastStyle:nil styleClass:class_];
    
    NSAssert(style, @"Style canont be nil with id path %@", id_);
    
    [_idStyleDic setObject:style forKey:idKey];
    
    return style;
}

- (id)getStyleByFileNames:(NSArray *)fileNames_ withIdPath:(NSArray *)idPath_ lastStyle:(id)lastStyle_ styleClass:(Class)class_
{
    id style = lastStyle_;
    
    for (NSString *fileName in fileNames_)
    {
        BOOL success = NO;
        style = [self getStyleByFileName:fileName withIdPath:idPath_ styleClass:class_ lastStyle:style success:&success];
        if (success)
        {
            break;
        }
    }
    
    return style;
}

- (id)getStyleByFileName:(NSString *)fileName_ withIdPath:(NSArray *)idPath_ styleClass:(Class)class_ lastStyle:(id)lastStyle_ success:(BOOL *)success
{
    id style = lastStyle_;
    
    id tempStyle = [self getStyleByFileName:fileName_ withIdPath:idPath_ styleClass:class_];
    if (style)
    {
        [style mergeWithStyle:tempStyle];
    }
    else
    {
        style = tempStyle;
    }
    
    if ([style verifyPropertyValues])
    {
        *success = YES;
        return style;
    }
    
    if ([idPath_.firstObject isEqualToString:[_skinConfig landscapeJsonLabel]])
    {
        NSMutableArray *tempIdPath = [idPath_ mutableCopy];
        [tempIdPath replaceObjectAtIndex:0 withObject:[_skinConfig portraitJsonLabel]];
        tempStyle = [self getStyleByFileName:fileName_ withIdPath:tempIdPath styleClass:class_];
        if (style)
        {
            if (tempStyle)
            {
                [style mergeWithStyle:tempStyle];
                
                if ([style verifyPropertyValues])
                {
                    *success = YES;
                    return style;
                }
            }
        }
        else
        {
            style = tempStyle;
        }
    }
    
    *success = NO;
    return style;
}

- (NSString *)interfaceOritationDescription
{
    NSString *description = [_skinConfig portraitJsonLabel];
    if ([UIDevice jj_currentInterfaceLandscapeOrientation])
    {
        description = [_skinConfig landscapeJsonLabel];
    }
    
    return description;
}

@end
