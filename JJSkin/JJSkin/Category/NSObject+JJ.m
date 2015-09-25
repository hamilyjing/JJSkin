//
//  NSObject+JJ.m
//  JJObjCTool
//
//  Created by JJ on 5/12/15.
//  Copyright (c) 2015 gongjian. All rights reserved.
//

#import "NSObject+JJ.h"

#import <objc/runtime.h>

static inline dispatch_time_t dTimeDelay(NSTimeInterval time)
{
    int64_t delta = (int64_t)(NSEC_PER_SEC * time);
    return dispatch_time(DISPATCH_TIME_NOW, delta);
}

BOOL method_swizzle(Class klass, SEL origSel, SEL altSel)
{
    if (!klass)
        return NO;
    
    Method __block origMethod, __block altMethod;
    
    void (^find_methods)() = ^
    {
        unsigned methodCount = 0;
        Method *methodList = class_copyMethodList(klass, &methodCount);
        
        origMethod = altMethod = NULL;
        
        if (methodList)
            for (unsigned i = 0; i < methodCount; ++i)
            {
                if (method_getName(methodList[i]) == origSel)
                    origMethod = methodList[i];
                
                if (method_getName(methodList[i]) == altSel)
                    altMethod = methodList[i];
            }
        
        free(methodList);
    };
    
    find_methods();
    
    if (!origMethod)
    {
        origMethod = class_getInstanceMethod(klass, origSel);
        
        if (!origMethod)
            return NO;
        
        if (!class_addMethod(klass, method_getName(origMethod), method_getImplementation(origMethod), method_getTypeEncoding(origMethod)))
            return NO;
    }
    
    if (!altMethod)
    {
        altMethod = class_getInstanceMethod(klass, altSel);
        
        if (!altMethod)
            return NO;
        
        if (!class_addMethod(klass, method_getName(altMethod), method_getImplementation(altMethod), method_getTypeEncoding(altMethod)))
            return NO;
    }
    
    find_methods();
    
    if (!origMethod || !altMethod)
        return NO;
    
    method_exchangeImplementations(origMethod, altMethod);
    
    return YES;
}

void method_append(Class toClass, Class fromClass, SEL selector)
{
    if (!toClass || !fromClass || !selector)
        return;
    
    Method method = class_getInstanceMethod(fromClass, selector);
    
    if (!method)
        return;
    
    class_addMethod(toClass, method_getName(method), method_getImplementation(method), method_getTypeEncoding(method));
}

void method_replace(Class toClass, Class fromClass, SEL selector)
{
    if (!toClass || !fromClass || ! selector)
        return;
    
    Method method = class_getInstanceMethod(fromClass, selector);
    
    if (!method)
        return;
    
    class_replaceMethod(toClass, method_getName(method), method_getImplementation(method), method_getTypeEncoding(method));
}

@implementation NSObject (JJ)

#pragma mark - Setup after finish launching

+ (void)jj_setupAfterFinishLaunching:(void (^)())block
{
    if (!block)
    {
        return;
    }
    
    // block对observer对象的捕获早于函数的返回，所以若不加__block，会捕获到nil
    __block id observer =
    [[NSNotificationCenter defaultCenter]
     addObserverForName:UIApplicationDidFinishLaunchingNotification
     object:nil
     queue:nil
     usingBlock:^(NSNotification *note) {
         block();
         [[NSNotificationCenter defaultCenter] removeObserver:observer];
         observer = nil;
     }];
}

#pragma mark - Run function

+ (id)jj_runFunction:(NSObject *)object sel:(SEL)sel parameters:(NSArray *)parameters
{
    NSMethodSignature *methodSignature = [[object class] instanceMethodSignatureForSelector:sel];//获得类和方法的签名
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    //从签名获得调用对象
    [invocation setTarget:object];
    //设置target
    [invocation setSelector:sel];//设置selector
    //参数
    NSInteger parameterIndex = 2;
    for (id parameter in parameters)
    {
        void *p = (__bridge void *)parameter;
        [invocation setArgument:&p atIndex:parameterIndex];
        ++parameterIndex;
    }
    
    //retain一遍参数
    [invocation retainArguments];
    //调用
    [invocation invoke];
    
    // 小心arc crash，http://blog.csdn.net/zengconggen/article/details/38024625
    //获得返回值类型
    const char *returnType = methodSignature.methodReturnType;
    //声明返回值变量
    id returnValue;
    //如果没有返回值，也就是消息声明为void，那么returnValue=nil
    if( !strcmp(returnType, @encode(void)) ){
        returnValue =  nil;
    }
    //如果返回值为对象，那么为变量赋值
    else if( !strcmp(returnType, @encode(id)) ){
        void *retLoc = NULL;
        [invocation getReturnValue:&retLoc];
        returnValue = (__bridge id)retLoc;
    }
    else{
        //如果返回值为普通类型NSInteger  BOOL
        //返回值长度
        NSUInteger length = [methodSignature methodReturnLength];
        //根据长度申请内存
        void *buffer = (void *)malloc(length);
        //为变量赋值
        [invocation getReturnValue:buffer];
        //以下代码为参考:具体地址我忘记了，等我找到后补上，(很对不起原作者)
        if( !strcmp(returnType, @encode(BOOL)) ) {
            returnValue = [NSNumber numberWithBool:*((BOOL*)buffer)];
        }
        else if( !strcmp(returnType, @encode(NSInteger)) ){
            returnValue = [NSNumber numberWithInteger:*((NSInteger*)buffer)];
        }
        returnValue = [NSValue valueWithBytes:buffer objCType:returnType];
    }
    
    return returnValue;
}

#pragma mark - GCD

- (id)jj_performBlock:(void (^)(id obj))block afterDelay:(NSTimeInterval)delay
{
    return [self jj_performBlock:block onQueue:dispatch_get_main_queue() afterDelay:delay];
}

+ (id)jj_performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay
{
    return [NSObject jj_performBlock:block onQueue:dispatch_get_main_queue() afterDelay:delay];
}

- (id)jj_performBlockInBackground:(void (^)(id obj))block afterDelay:(NSTimeInterval)delay
{
    return [self jj_performBlock:block onQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0) afterDelay:delay];
}

+ (id)jj_performBlockInBackground:(void (^)(void))block afterDelay:(NSTimeInterval)delay
{
    return [NSObject jj_performBlock:block onQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0) afterDelay:delay];
}

- (id)jj_performBlock:(void (^)(id obj))block onQueue:(dispatch_queue_t)queue afterDelay:(NSTimeInterval)delay
{
    NSParameterAssert(block != nil);
    
    __block BOOL cancelled = NO;
    
    void (^wrapper)(BOOL) = ^(BOOL cancel) {
        if (cancel) {
            cancelled = YES;
            return;
        }
        if (!cancelled) block(self);
    };
    
    dispatch_after(dTimeDelay(delay), queue, ^{
        wrapper(NO);
    });
    
    return [wrapper copy];
}

+ (id)jj_performBlock:(void (^)(void))block onQueue:(dispatch_queue_t)queue afterDelay:(NSTimeInterval)delay
{
    NSParameterAssert(block != nil);
    
    __block BOOL cancelled = NO;
    
    void (^wrapper)(BOOL) = ^(BOOL cancel) {
        if (cancel) {
            cancelled = YES;
            return;
        }
        if (!cancelled) block();
    };
    
    dispatch_after(dTimeDelay(delay), queue, ^{ wrapper(NO); });
    
    return [wrapper copy];
}

+ (void)jj_cancelBlock:(id)block
{
    NSParameterAssert(block != nil);
    void (^wrapper)(BOOL) = block;
    wrapper(YES);
}

#pragma mark - Get property and method info

-(NSDictionary *)jj_propertyNameAndValueDictionary
{
    //创建可变字典
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    unsigned int outCount;
    objc_property_t *props = class_copyPropertyList([self class], &outCount);
    for(int i=0;i<outCount;i++){
        objc_property_t prop = props[i];
        NSString *propName = [[NSString alloc]initWithCString:property_getName(prop) encoding:NSUTF8StringEncoding];
        id propValue = [self valueForKey:propName];
        if(propValue){
            [dict setObject:propValue forKey:propName];
        }
    }
    free(props);
    return dict;
}

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

+ (NSArray *)classPropertyList
{
    NSMutableArray *allProperties = [[NSMutableArray alloc] init];
    
    unsigned int outCount;
    objc_property_t *props = class_copyPropertyList(self, &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t prop = props[i];
        
        NSString *propName = [[NSString alloc]initWithCString:property_getName(prop) encoding:NSUTF8StringEncoding];
        
        if (propName) {
            [allProperties addObject:propName];
        }
        
    }
    free(props);
    return [NSArray arrayWithArray:allProperties];
}

+ (NSArray *)classMethodList
{
    NSMutableArray *list = [NSMutableArray array];
    
    unsigned int mothCout_f =0;
    Method* mothList_f = class_copyMethodList([self class],&mothCout_f);
    
    for(int i=0; i < mothCout_f; i++)
    {
        Method temp_f = mothList_f[i];
        __unused IMP imp_f = method_getImplementation(temp_f);
        __unused SEL name_f = method_getName(temp_f);
        const char* name_s =sel_getName(method_getName(temp_f));
        int arguments = method_getNumberOfArguments(temp_f);
        const char* encoding =method_getTypeEncoding(temp_f);
        
        [list addObject:@{@"name": [NSString stringWithUTF8String:name_s], @"parameterAccount": @(arguments), @"encode": [NSString stringWithUTF8String:encoding]}];
    }
    
    free(mothList_f);
    
    return list;
}

#pragma mark - swizzle

+ (BOOL)swizzleMethod:(SEL)originalMethod withMethod:(SEL)newMethod
{
    Method method1 = class_getInstanceMethod(self, originalMethod);
    if (!method1)
    {
        return NO;
    }
    
    Method method2 = class_getInstanceMethod(self, newMethod);
    if (!method2)
    {
        return NO;
    }
    
    class_addMethod(self,
                    originalMethod,
                    class_getMethodImplementation(self, originalMethod),
                    method_getTypeEncoding(method1));
    class_addMethod(self,
                    newMethod,
                    class_getMethodImplementation(self, newMethod),
                    method_getTypeEncoding(method2));
    
    method_exchangeImplementations(class_getInstanceMethod(self, originalMethod), class_getInstanceMethod(self, newMethod));
    return YES;
}

+ (void)swizzleMethod:(Class)srcClass srcSel:(SEL)srcSel tarClass:(Class)tarClass tarSel:(SEL)tarSel
{
    @try
    {
        Method srcMethod = class_getInstanceMethod(srcClass, srcSel);
        Method tarMethod = class_getInstanceMethod(tarClass, tarSel);
        method_exchangeImplementations(srcMethod, tarMethod);
    }
    @catch (NSException *exception)
    {
    }
    @finally
    {
    }
}

+ (void)appendMethod:(SEL)newMethod fromClass:(Class)klass
{
    method_append(self.class, klass, newMethod);
}

+ (void)replaceMethod:(SEL)method fromClass:(Class)klass
{
    method_replace(self.class, klass, method);
}

#pragma mark - Associated

- (void)jj_associateStongValue:(id)value withKey:(const void *)key
{
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)jj_associateAssignValue:(id)value withKey:(const void *)key
{
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
}

- (void)jj_associateCopyValue:(id)value withKey:(const void *)key
{
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (id)jj_associatedValueForKey:(const void *)key
{
    return objc_getAssociatedObject(self, key);
}

@end
