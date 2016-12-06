//
//  UIDevice+JJ.h
//  JJObjCTool
//
//  Created by JJ on 5/12/15.
//  Copyright (c) 2015 gongjian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JJHardware)
{
    NOT_AVAILABLE,
    
    IPHONE_2G,
    IPHONE_3G,
    IPHONE_3GS,
    IPHONE_4,
    IPHONE_4_CDMA,
    IPHONE_4S,
    IPHONE_5,
    IPHONE_5_CDMA_GSM,
    IPHONE_5C,
    IPHONE_5C_CDMA_GSM,
    IPHONE_5S,
    IPHONE_5S_CDMA_GSM,
    IPHONE_6_PLUS,
    IPHONE_6,
    IPHONE_6S_PLUS,
    IPHONE_6S,
    IPHONE_SE,
    IPHONE_7_PLUS,
    IPHONE_7,
    
    IPOD_TOUCH_1G,
    IPOD_TOUCH_2G,
    IPOD_TOUCH_3G,
    IPOD_TOUCH_4G,
    IPOD_TOUCH_5G,
    
    IPAD,
    IPAD_2,
    IPAD_2_WIFI,
    IPAD_2_CDMA,
    IPAD_3,
    IPAD_3G,
    IPAD_3_WIFI,
    IPAD_3_WIFI_CDMA,
    IPAD_4,
    IPAD_4_WIFI,
    IPAD_4_GSM_CDMA,
    
    IPAD_MINI,
    IPAD_MINI_WIFI,
    IPAD_MINI_WIFI_CDMA,
    IPAD_MINI_RETINA_WIFI,
    IPAD_MINI_RETINA_WIFI_CDMA,
    IPAD_MINI_3_WIFI,
    IPAD_MINI_3_WIFI_CELLULAR,
    IPAD_MINI_RETINA_WIFI_CELLULAR_CN,
    
    IPAD_AIR_WIFI,
    IPAD_AIR_WIFI_GSM,
    IPAD_AIR_WIFI_CDMA,
    IPAD_AIR_2_WIFI,
    IPAD_AIR_2_WIFI_CELLULAR,
    
    IOS_SIMULATOR
};

@interface UIDevice (JJ)

#pragma mark - Device type

+ (BOOL)jj_isiPhone;
+ (BOOL)jj_isiPad;

#pragma mark - Device orientation

+ (BOOL)jj_currentDeviceLandscapeOrientation;
+ (BOOL)jj_currentDevicePortraitOrientation;
+ (NSString *)jj_currentDeviceOrientationDescription;

+ (BOOL)jj_currentInterfaceLandscapeOrientation;
+ (BOOL)jj_currentInterfacePortraitOrientation;
+ (NSString *)jj_currentInterfaceOrientationDescription;

#pragma mark - Bundle info

+ (NSDictionary *)jj_bundleInfoDictionary;
+ (NSString *)jj_appName;
+ (NSString *)jj_bundleIdentifier; // "com.jianjing.JJObjCTool"
+ (NSString *)jj_bundleShortVersion; // "5.1.4"
+ (NSString *)jj_bundleVersion; // "12345"

#pragma mark - Hardware

+ (JJHardware)jj_hardware;
+ (float)jj_hardwareNumber:(JJHardware)hardware;
+ (NSString *)jj_platform; // 平台，"iPhone5,4"
+ (NSString *)jj_platformDescription; // "iPhone 4 (CDMA)"
+ (NSString*)jj_platformSimpleDescription; // "iPhone4", "iPhone4s"

+ (NSString *)jj_systemName; // iOS
+ (NSString *)jj_systemVersion; // iOS8.0

+ (NSString *)jj_macAddress; // 获取MAC地址，大写，"3C075417B5C6"

+ (NSString *)jj_IPAdress;

/** This method returns the resolution for still image that can be received
 from back camera of the current device. Resolution returned for image oriented landscape right. **/
+ (CGSize)jj_backCameraStillImageResolutionInPixels;

+ (NSString *)jj_getSysInfoByName:(const char *)aTypeSpecifier;

#pragma mark - Memory

+ (double)jj_realMemory; // 设备总内存
+ (double)jj_availableMemory; // 当前设备可用内存(单位：MB)
+ (double)jj_usedMemory; // 当前应用所占内存(单位：MB)

#pragma mark - 运营商信息

+ (NSString *)jj_currentRadioAccessTechnology; // 运营商的网络类型

//// mobileCountryCode(MCC)和mobileNetworkCode(MNC)可以参考：http://en.wikipedia.org/wiki/Mobile_country_code
+ (NSString *)jj_mobileCountryCode; // 运营商国家码，"460"
+ (NSString *)jj_mobileNetworkCode; // 运营商网络码，"01"
+ (NSString *)jj_carrierName; // 运营商信息，"中国联通"

+ (BOOL)jj_allowsVOIP;

//// isoCountryCode使用ISO 3166-1标准，参考：http://en.wikipedia.org/wiki/ISO_3166-1
+ (NSString *)jj_isoCountryCode; // "cn"

#pragma mark - JailBreak

+ (BOOL)jj_isJailBreak;

#pragma mark - Screen

// 弥补iPhone 6及以后设备中的“设置”->“显示与亮度”->"显示模式"对[UIScreen mainScreen].bounds.size的影响
+ (CGSize)jj_screenSizeIgnoreDisplayZoom;

// below using [UIScreen mainScreen]
+ (CGRect)jj_screenBounds;
+ (CGSize)jj_screenSize;
+ (CGFloat)jj_screenWidth;
+ (CGFloat)jj_screenHeight;

@end
