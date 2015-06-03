//
//  JJSkinView.h
//  JJSkin
//
//  Created by JJ on 6/1/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIView+JJSkin.h"

extern NSString *JJSkinChangedNotification;

@interface JJSkinView : UIView

@property (nonatomic, assign) BOOL shouldRegisterSkinHandle;

@end
