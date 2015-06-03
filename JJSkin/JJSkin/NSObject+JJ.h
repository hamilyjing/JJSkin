//
//  NSObject+JJ.h
//  JJSkin
//
//  Created by JJ on 5/12/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (JJ)

+ (NSDictionary *)jj_classPropertyNameToAttributeList;
+ (NSDictionary *)jj_classPropertyNameToAttributeListIncludeSuper;

@end
