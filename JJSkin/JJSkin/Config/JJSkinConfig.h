//
//  JJSkinConfig.h
//  JJSkin
//
//  Created by JJ on 5/26/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JJSkinConfig <NSObject>

- (NSBundle *)bundle;
- (NSString *)fileNamePrefix;
- (NSString *)fileType;

- (NSString *)landscapeJsonLabel;
- (NSString *)portraitJsonLabel;

- (NSString *)iPhoneFileNameSuffix;
- (NSString *)iPadFileNameSuffix;

/**
 JJSkin will analyse style values from first file, When you invoke JJSkinManager API to get object. If JJSkin does not get all style propeties, it will analyse the next file.
 
 In one file, it has portrait and landscape root lable. If interface oritation is portrait, JJSkin only analyse portrait root label. If interface oritation is landscape, JJSkin will first analyse landscape root label. It will continue analyse portrait root label if JJSkin does not get all style values.
 
 Be carefule, JJSkin will not continue to analyse if it has "status" label and its value is "finish". if the value is "finishIncludeSon", JJSkin will not analyse the son style value.
 */
- (NSArray *)fileNames;

@end

@interface JJSkinConfig : NSObject <JJSkinConfig>

@end
