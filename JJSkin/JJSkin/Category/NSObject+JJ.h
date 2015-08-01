//
//  NSObject+JJ.h
//  JJObjCTool
//
//  Created by JJ on 5/12/15.
//  Copyright (c) 2015 gongjian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (JJ)

#pragma mark - Setup after finish launching

+ (void)jj_setupAfterFinishLaunching:(void (^)())block; // 一般在+ (void)load方法中调用

#pragma mark - Run function

+ (id)jj_runFunction:(NSObject *)object sel:(SEL)sel parameters:(NSArray *)parameters;

#pragma mark - GCD

- (id)jj_performBlock:(void (^)(id obj))block afterDelay:(NSTimeInterval)delay; // 返回需要执行的block，可以调用jj_cancelBlock来取消
+ (id)jj_performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
- (id)jj_performBlockInBackground:(void (^)(id obj))block afterDelay:(NSTimeInterval)delay;
+ (id)jj_performBlockInBackground:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
- (id)jj_performBlock:(void (^)(id obj))block onQueue:(dispatch_queue_t)queue afterDelay:(NSTimeInterval)delay;
+ (id)jj_performBlock:(void (^)(void))block onQueue:(dispatch_queue_t)queue afterDelay:(NSTimeInterval)delay;
+ (void)jj_cancelBlock:(id)block;

#pragma mark - Get property and method info

- (NSDictionary *)jj_propertyNameAndValueDictionary;
+ (NSArray *)classPropertyList;
+ (NSDictionary *)jj_classPropertyNameToAttributeList;
+ (NSDictionary *)jj_classPropertyNameToAttributeListIncludeSuper;
+ (NSArray *)classMethodList;

#pragma mark - swizzle

+ (BOOL)swizzleMethod:(SEL)originalMethod withMethod:(SEL)newMethod;
+ (void)swizzleMethod:(Class)srcClass srcSel:(SEL)srcSel tarClass:(Class)tarClass tarSel:(SEL)tarSel;
+ (void)appendMethod:(SEL)newMethod fromClass:(Class)klass;
+ (void)replaceMethod:(SEL)method fromClass:(Class)klass;

#pragma mark - Associated

- (void)jj_associateStongValue:(id)value withKey:(const void *)key;
- (void)jj_associateAssignValue:(id)value withKey:(const void *)key;
- (void)jj_associateCopyValue:(id)value withKey:(const void *)key;
- (id)jj_associatedValueForKey:(const void *)key;

@end
