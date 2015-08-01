//
//  JJSkinStyleDelegate.h
//  JJSkin
//
//  Created by JJ on 5/27/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JJSkinStyleDelegate <NSObject>

- (BOOL)verifyPropertyValues;

- (void)mergeWithStyle:(id)style;

+ (id)styleFromContent:(id)content;

@end
