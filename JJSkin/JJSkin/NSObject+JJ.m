//
//  NSObject+JJ.m
//  JJSkin
//
//  Created by JJ on 5/12/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import "NSObject+JJ.h"

#import <objc/runtime.h>

@implementation NSObject (JJ)

+ (NSDictionary *)jj_classPropertyNameToAttributeListIncludeSuper
{
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    id class = [self class];
    do {
        NSDictionary *dic = [class jj_classPropertyNameToAttributeList];
        if (dic)
        {
            [mDic addEntriesFromDictionary:dic];
        }
        
        class = [class superclass];
        
    } while (class != [NSObject class]);
    
    [mDic removeObjectForKey:@"debugDescription"];
    [mDic removeObjectForKey:@"description"];
    [mDic removeObjectForKey:@"hash"];
    [mDic removeObjectForKey:@"superclass"];
    
    return mDic;
}

+ (NSDictionary *)jj_classPropertyNameToAttributeList
{
    NSMutableDictionary *nameToAttribut = [[NSMutableDictionary alloc] init];
    
    unsigned int outCount;
    objc_property_t *props = class_copyPropertyList(self, &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t prop = props[i];
        
        NSString *propName = [[NSString alloc]initWithCString:property_getName(prop) encoding:NSUTF8StringEncoding];
        NSString * propertyAttributes = [NSString stringWithUTF8String:property_getAttributes(prop)];
        NSAssert(propName && propertyAttributes, nil);
        if (propName && propertyAttributes)
        {
            nameToAttribut[propName] = propertyAttributes;
        }
    }
    free(props);
    return nameToAttribut;
}

@end
