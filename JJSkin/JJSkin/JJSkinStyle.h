//
//  JJSkinStyle.h
//  JJSkin
//
//  Created by JJ on 5/28/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JJSkinStyleDelegate.h"
#import "JJSkinStyleDataSource.h"

extern NSString *JJSkinStyleStatusFinishIncludeSon;
extern NSString *JJSkinStyleStatusFinish;

@interface JJSkinStyle : NSObject <JJSkinStyleDelegate, JJSkinStyleDataSource>

@property (nonatomic, copy) NSString *status;

@end
