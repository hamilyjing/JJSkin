//
//  JJTableViewStyle.h
//  JJSkin
//
//  Created by JJ on 6/8/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import "JJScrollViewStyle.h"

@interface JJTableViewStyle : JJScrollViewStyle

@property (nonatomic, copy) NSString *separatorStyle;
@property (nonatomic, strong) UIColor *separatorColor;
@property (nonatomic, copy) NSString *separatorInset;

@end
