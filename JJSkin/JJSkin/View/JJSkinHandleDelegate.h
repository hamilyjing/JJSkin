//
//  JJSkinHandleDelegate.h
//  JJSkin
//
//  Created by JJ on 6/1/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JJSkinHandleDelegate <NSObject>

- (void)registerSkinHandle;
- (void)removeSkinHandle;

- (void)layoutViewsWhenSkinChanged;

@end
