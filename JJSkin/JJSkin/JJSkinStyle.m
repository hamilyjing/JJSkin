//
//  JJSkinStyle.m
//  JJSkin
//
//  Created by JJ on 5/28/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import "JJSkinStyle.h"

#import "JJSkinManager.h"
#import "NSObject+JJ.h"
#import "NSString+JJ.h"

NSString *JJSkinStyleStatusFinishIncludeSon = @"finishIncludeSon";
NSString *JJSkinStyleStatusFinish = @"finish";

@implementation JJSkinStyle

#pragma mark - JJSkinStyleDataSource

+ (id)styleFromStyle:(id)style
{
    NSParameterAssert(style && ([self class] == [style class]));
    
    id theStyle = [[[self class] alloc] init];
    
    NSMutableDictionary *propertNameToAttribute = (NSMutableDictionary *)[self jj_classPropertyNameToAttributeListIncludeSuper];
    [propertNameToAttribute enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
    {
        [theStyle setValue:[style objectForKey:key] forKey:key];
    }];
    
    return theStyle;
}

+ (id)objectFromStyle:(id)style
{
    return nil;
}

- (void)updateObject:(id)object
{
    
}

#pragma mark - JJSkinStyleDelegate

- (BOOL)verifyPropertyValues
{
    if ([JJSkinStyleStatusFinishIncludeSon isEqualToString:_status])
    {
        return YES;
    }
    
    return NO;
}

- (void)mergeWithStyle:(id)style
{
    if (!style)
    {
        return;
    }
    
    if ([JJSkinStyleStatusFinishIncludeSon isEqualToString:_status])
    {
        return;
    }
    
    NSDictionary *propertNameToAttribute = [[self class] jj_classPropertyNameToAttributeListIncludeSuper];
    
    for (NSString *key in [propertNameToAttribute allKeys])
    {
        id mergeValue = [style valueForKey:key];
        if (!mergeValue)
        {
            continue;
        }
        
        NSString *propertyAtt = propertNameToAttribute[key];
        
        if ([propertyAtt hasPrefix:@"T@\"NSString\""]
            || [propertyAtt hasPrefix:@"T@\"UIColor\""]
            || [propertyAtt hasPrefix:@"T@\"UIImage\""])
        {
            NSString *objc = [self valueForKey:key];
            if (!objc && ![JJSkinStyleStatusFinish isEqualToString:_status])
            {
                [self setValue:mergeValue forKey:key];
            }
        }
        else
        {
            id objc = [self valueForKey:key];
            if (!objc)
            {
                [self setValue:mergeValue forKey:key];
            }
            else
            {
                if ([objc conformsToProtocol:NSProtocolFromString(@"JJSkinStyleDelegate")])
                {
                    [objc mergeWithStyle:mergeValue];
                }
                else
                {
                    NSAssert(NO, @"Objc:%@ does not conform JJSkinStyleDelegate", NSStringFromClass([objc class]));
                }
            }
        }
    }
}

+ (id)styleFromContent:(id)content
{
    NSParameterAssert(content);
    
    id style = [[[self class] alloc] init];
    NSDictionary *propertNameToAttribute;
    
    if ([content isKindOfClass:[NSDictionary class]])
    {
        propertNameToAttribute = [self jj_classPropertyNameToAttributeListIncludeSuper];
        
        [((NSDictionary *)content) enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
        {
            NSString *propertyAtt = propertNameToAttribute[key];
            id value;
            
            if ([propertyAtt hasPrefix:@"T@\"NSString\""])
            {
                value = obj;
            }
            else if ([propertyAtt hasPrefix:@"T@\"UIColor\""])
            {
                value = [JJSkinManager getColorFromString:obj];
            }
            else if ([propertyAtt hasPrefix:@"T@\"UIImage\""])
            {
                value = [JJSkinManager getImageFromString:obj];
            }
            else
            {
                NSString *styleString = [propertyAtt jj_stringBetweenTheSameString:@"\""];
                Class class = NSClassFromString(styleString);
                if ([class conformsToProtocol:NSProtocolFromString(@"JJSkinStyleDelegate")])
                {
                    value = [class styleFromContent:obj];
                }
            }
            /*
            else if ([propertyAtt hasPrefix:@"Ti"])
            {// integer
                NSInteger flag = [JJSkinManager getIntegerFromString:obj];
                value = [NSNumber numberWithInteger:flag];
            }
            else if ([propertyAtt hasPrefix:@"Td"])
            {// float
                CGFloat flag = [JJSkinManager getFloatFromString:obj];
                value = [NSNumber numberWithFloat:flag];
            }
            else if ([propertyAtt hasPrefix:@"T@\"BOOL\""])
            {
                BOOL flag = [JJSkinManager getBoolFromString:obj];
                value = [NSNumber numberWithBool:flag];
            }
            else if ([propertyAtt hasPrefix:@"T{UIEdgeInsets="])
            {
                UIEdgeInsets inserts = [JJSkinManager getEdgeInsetsFromString:obj];
                value = [NSValue valueWithUIEdgeInsets:inserts];
            }
            else if ([propertyAtt hasPrefix:@"T{CGRect="])
            {
                CGRect rect = [JJSkinManager getRectFromString:obj];
                value = [NSValue valueWithCGRect:rect];
            }
            else if ([propertyAtt hasPrefix:@"T{CGSize="])
            {
                CGSize size = [JJSkinManager getSizeFromString:obj];
                value = [NSValue valueWithCGSize:size];
            }
            else if ([propertyAtt hasPrefix:@"Tq"])
            {
                NSInteger flag = [JJSkinManager getIntegerFromString:obj];
                value = [NSNumber numberWithInteger:flag];
            }
             */
            
            if (value)
            {
                [style setValue:value forKey:key];
            }
        }];
    }
    else if ([content isKindOfClass:[NSString class]])
    {
        NSDictionary *propertNameToAttribute = [self jj_classPropertyNameToAttributeList];
        NSString *key = [[propertNameToAttribute allKeys] firstObject];
        NSAssert(key && (1 == [[propertNameToAttribute allKeys] count]), nil);
        [style setValue:content forKey:key];
    }
    
    return style;
}

@end
