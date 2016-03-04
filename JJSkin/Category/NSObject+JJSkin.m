//
//  NSObject+JJSkin.m
//  JJSkin
//
//  Created by JJ on 11/14/15.
//  Copyright © 2015 gongjian. All rights reserved.
//

#import "NSObject+JJSkin.h"

#import <objc/runtime.h>

#import "JJSkinConfig.h"
#import "JJSkinManager.h"

@implementation NSObject (JJSkin)

- (JJSkinManager *)jjSkinManager
{
    JJSkinManager *skinManager = objc_getAssociatedObject(self, @selector(jjSkinManager));
    if (skinManager)
    {
        return skinManager;
    }
    
    skinManager = [[JJSkinManager alloc] initWithSkinConfig:[[JJSkinConfig alloc] init]];
    objc_setAssociatedObject(self, @selector(jjSkinManager), skinManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return skinManager;
}

@end
