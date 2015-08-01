//
//  JJSkinStyleDataSource.h
//  JJSkin
//
//  Created by JJ on 5/30/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JJSkinStyleDataSource <NSObject>

+ (id)styleFromStyle:(id)style;
+ (id)objectFromStyle:(id)style;
- (void)updateObject:(id)object;

@end
