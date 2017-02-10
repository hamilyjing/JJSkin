//
//  UIDevice+JJ.m
//  JJObjCTool
//
//  Created by JJ on 5/12/15.
//  Copyright (c) 2015 gongjian. All rights reserved.
//

#import "UIDevice+JJ.h"

#include <sys/sysctl.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#import <mach/mach.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <ifaddrs.h>
#import <arpa/inet.h>

@implementation UIDevice (JJ)

#pragma mark - Device type

+ (BOOL)jj_isiPhone
{
    return ![UIDevice jj_isiPad];
}

+ (BOOL)jj_isiPad
{
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
}

#pragma mark - Device orientation

+ (BOOL)jj_currentDeviceLandscapeOrientation
{
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    return UIDeviceOrientationIsLandscape(deviceOrientation);
}

+ (BOOL)jj_currentDevicePortraitOrientation
{
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    return UIDeviceOrientationIsPortrait(deviceOrientation);
}

+ (NSString *)jj_currentDeviceOrientationDescription
{
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    if (UIDeviceOrientationIsLandscape(deviceOrientation))
    {
        return @"landscape";
    }
    else
    {
        return @"portrait";
    }
}

+ (BOOL)jj_currentInterfaceLandscapeOrientation
{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    return UIInterfaceOrientationIsLandscape(orientation);
}

+ (BOOL)jj_currentInterfacePortraitOrientation
{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    return UIInterfaceOrientationIsPortrait(orientation);
}

+ (NSString *)jj_currentInterfaceOrientationDescription
{
    if ([self jj_currentInterfaceLandscapeOrientation])
    {
        return @"landscape";
    }
    else
    {
        return @"portrait";
    }
}

#pragma mark - Bundle info

+ (NSDictionary *)jj_bundleInfoDictionary
{
    return [[NSBundle mainBundle] infoDictionary];
}

+ (NSString *)jj_appName
{
    return [self jj_bundleInfoDictionary][@"CFBundleName"];
}

+ (NSString *)jj_bundleIdentifier
{
    NSDictionary * productInfo = [[NSBundle mainBundle] infoDictionary];
    return [productInfo objectForKey:@"CFBundleIdentifier"];
}

+ (NSString *)jj_bundleShortVersion
{
    NSDictionary * productInfo = [[NSBundle mainBundle] infoDictionary];
    return [productInfo objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)jj_bundleVersion
{
    NSDictionary * productInfo = [[NSBundle mainBundle] infoDictionary];
    return [productInfo objectForKey:@"CFBundleVersion"];
}

#pragma mark - Hardware

+ (JJHardware)jj_hardware
{
    NSString *hardware = [self jj_platform];
    if ([hardware isEqualToString:@"iPhone1,1"])    return IPHONE_2G;
    if ([hardware isEqualToString:@"iPhone1,2"])    return IPHONE_3G;
    if ([hardware isEqualToString:@"iPhone2,1"])    return IPHONE_3GS;
    if ([hardware isEqualToString:@"iPhone3,1"])    return IPHONE_4;
    if ([hardware isEqualToString:@"iPhone3,2"])    return IPHONE_4;
    if ([hardware isEqualToString:@"iPhone3,3"])    return IPHONE_4_CDMA;
    if ([hardware isEqualToString:@"iPhone4,1"])    return IPHONE_4S;
    if ([hardware isEqualToString:@"iPhone5,1"])    return IPHONE_5;
    if ([hardware isEqualToString:@"iPhone5,2"])    return IPHONE_5_CDMA_GSM;
    if ([hardware isEqualToString:@"iPhone5,3"])    return IPHONE_5C;
    if ([hardware isEqualToString:@"iPhone5,4"])    return IPHONE_5C_CDMA_GSM;
    if ([hardware isEqualToString:@"iPhone6,1"])    return IPHONE_5S;
    if ([hardware isEqualToString:@"iPhone6,2"])    return IPHONE_5S_CDMA_GSM;
    
    if ([hardware isEqualToString:@"iPhone8,2"])    return IPHONE_6S_PLUS;
    if ([hardware isEqualToString:@"iPhone8,1"])    return IPHONE_6S;
    
    if ([hardware isEqualToString:@"iPhone9,2"])    return IPHONE_7_PLUS;
    if ([hardware isEqualToString:@"iPhone9,1"])    return IPHONE_7;
    
    if ([hardware isEqualToString:@"iPhone8,4"])    return IPHONE_SE;
    
    if ([hardware isEqualToString:@"iPhone7,1"])    return IPHONE_6_PLUS;
    if ([hardware isEqualToString:@"iPhone7,2"])    return IPHONE_6;
    
    if ([hardware isEqualToString:@"iPod1,1"])      return IPOD_TOUCH_1G;
    if ([hardware isEqualToString:@"iPod2,1"])      return IPOD_TOUCH_2G;
    if ([hardware isEqualToString:@"iPod3,1"])      return IPOD_TOUCH_3G;
    if ([hardware isEqualToString:@"iPod4,1"])      return IPOD_TOUCH_4G;
    if ([hardware isEqualToString:@"iPod5,1"])      return IPOD_TOUCH_5G;
    
    if ([hardware isEqualToString:@"iPad1,1"])      return IPAD;
    if ([hardware isEqualToString:@"iPad1,2"])      return IPAD_3G;
    if ([hardware isEqualToString:@"iPad2,1"])      return IPAD_2_WIFI;
    if ([hardware isEqualToString:@"iPad2,2"])      return IPAD_2;
    if ([hardware isEqualToString:@"iPad2,3"])      return IPAD_2_CDMA;
    if ([hardware isEqualToString:@"iPad2,4"])      return IPAD_2;
    if ([hardware isEqualToString:@"iPad2,5"])      return IPAD_MINI_WIFI;
    if ([hardware isEqualToString:@"iPad2,6"])      return IPAD_MINI;
    if ([hardware isEqualToString:@"iPad2,7"])      return IPAD_MINI_WIFI_CDMA;
    if ([hardware isEqualToString:@"iPad3,1"])      return IPAD_3_WIFI;
    if ([hardware isEqualToString:@"iPad3,2"])      return IPAD_3_WIFI_CDMA;
    if ([hardware isEqualToString:@"iPad3,3"])      return IPAD_3;
    if ([hardware isEqualToString:@"iPad3,4"])      return IPAD_4_WIFI;
    if ([hardware isEqualToString:@"iPad3,5"])      return IPAD_4;
    if ([hardware isEqualToString:@"iPad3,6"])      return IPAD_4_GSM_CDMA;
    if ([hardware isEqualToString:@"iPad4,1"])      return IPAD_AIR_WIFI;
    if ([hardware isEqualToString:@"iPad4,2"])      return IPAD_AIR_WIFI_GSM;
    if ([hardware isEqualToString:@"iPad4,3"])      return IPAD_AIR_WIFI_CDMA;
    if ([hardware isEqualToString:@"iPad4,4"])      return IPAD_MINI_RETINA_WIFI;
    if ([hardware isEqualToString:@"iPad4,5"])      return IPAD_MINI_RETINA_WIFI_CDMA;
    if ([hardware isEqualToString:@"iPad4,6"])      return IPAD_MINI_RETINA_WIFI_CELLULAR_CN;
    if ([hardware isEqualToString:@"iPad4,7"])      return IPAD_MINI_3_WIFI;
    if ([hardware isEqualToString:@"iPad4,8"])      return IPAD_MINI_3_WIFI_CELLULAR;
    if ([hardware isEqualToString:@"iPad5,3"])      return IPAD_AIR_2_WIFI;
    if ([hardware isEqualToString:@"iPad5,4"])      return IPAD_AIR_2_WIFI_CELLULAR;
    if ([hardware isEqualToString:@"i386"])         return IOS_SIMULATOR;
    if ([hardware isEqualToString:@"x86_64"])       return IOS_SIMULATOR;
    if ([hardware hasPrefix:@"iPhone"])             return IOS_SIMULATOR;
    if ([hardware hasPrefix:@"iPod"])               return IOS_SIMULATOR;
    if ([hardware hasPrefix:@"iPad"])               return IOS_SIMULATOR;
    
    return NOT_AVAILABLE;
}

+ (float)jj_hardwareNumber:(JJHardware)hardware
{
    switch (hardware) {
        case IPHONE_2G:                         return 1.1f;
        case IPHONE_3G:                         return 1.2f;
        case IPHONE_3GS:                        return 2.1f;
        case IPHONE_4:                          return 3.1f;
        case IPHONE_4_CDMA:                     return 3.3f;
        case IPHONE_4S:                         return 4.1f;
        case IPHONE_5:                          return 5.1f;
        case IPHONE_5_CDMA_GSM:                 return 5.2f;
        case IPHONE_5C:                         return 5.3f;
        case IPHONE_5C_CDMA_GSM:                return 5.4f;
        case IPHONE_5S:                         return 6.1f;
        case IPHONE_5S_CDMA_GSM:                return 6.2f;
        case IPHONE_6_PLUS:                     return 7.1f;
        case IPHONE_6:                          return 7.2f;
        case IPHONE_6S_PLUS:                    return 8.2f;
        case IPHONE_6S:                         return 8.1f;
        case IPHONE_SE:                         return 8.4f;
        case IPHONE_7_PLUS:                     return 9.2f;
        case IPHONE_7:                          return 9.1f;
            
        case IPOD_TOUCH_1G:                     return 1.1f;
        case IPOD_TOUCH_2G:                     return 2.1f;
        case IPOD_TOUCH_3G:                     return 3.1f;
        case IPOD_TOUCH_4G:                     return 4.1f;
        case IPOD_TOUCH_5G:                     return 5.1f;
            
        case IPAD:                              return 1.1f;
        case IPAD_3G:                           return 1.2f;
        case IPAD_2_WIFI:                       return 2.1f;
        case IPAD_2:                            return 2.2f;
        case IPAD_2_CDMA:                       return 2.3f;
        case IPAD_MINI_WIFI:                    return 2.5f;
        case IPAD_MINI:                         return 2.6f;
        case IPAD_MINI_WIFI_CDMA:               return 2.7f;
        case IPAD_3_WIFI:                       return 3.1f;
        case IPAD_3_WIFI_CDMA:                  return 3.2f;
        case IPAD_3:                            return 3.3f;
        case IPAD_4_WIFI:                       return 3.4f;
        case IPAD_4:                            return 3.5f;
        case IPAD_4_GSM_CDMA:                   return 3.6f;
            
        case IPAD_AIR_WIFI:                     return 4.1f;
        case IPAD_AIR_WIFI_GSM:                 return 4.2f;
        case IPAD_AIR_WIFI_CDMA:                return 4.3f;
        case IPAD_AIR_2_WIFI:                   return 5.3f;
        case IPAD_AIR_2_WIFI_CELLULAR:          return 5.4f;
            
        case IPAD_MINI_RETINA_WIFI:             return 4.4f;
        case IPAD_MINI_RETINA_WIFI_CDMA:        return 4.5f;
        case IPAD_MINI_3_WIFI:                  return 4.6f;
        case IPAD_MINI_3_WIFI_CELLULAR:         return 4.7f;
        case IPAD_MINI_RETINA_WIFI_CELLULAR_CN: return 4.8f;
            
            
        case IOS_SIMULATOR:                         return 100.0f;
        case NOT_AVAILABLE:                     return 200.0f;
    }
    return 200.0f; //Device is not available
}

+ (NSString *)jj_platform
{
    NSString *platform = [self jj_getSysInfoByName:"hw.machine"];
    return platform;
}

+ (NSString *)jj_platformDescription
{
    NSString *hardware = [self jj_platform];
    if ([hardware isEqualToString:@"iPhone1,1"])    return @"iPhone 2G";
    if ([hardware isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([hardware isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([hardware isEqualToString:@"iPhone3,1"])    return @"iPhone 4 (GSM)";
    if ([hardware isEqualToString:@"iPhone3,2"])    return @"iPhone 4 (GSM Rev. A)";
    if ([hardware isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
    if ([hardware isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([hardware isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([hardware isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (Global)";
    if ([hardware isEqualToString:@"iPhone5,3"])    return @"iPhone 5C (GSM)";
    if ([hardware isEqualToString:@"iPhone5,4"])    return @"iPhone 5C (Global)";
    if ([hardware isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([hardware isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (Global)";
    
    if ([hardware isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([hardware isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    
    if ([hardware isEqualToString:@"iPod1,1"])      return @"iPod Touch (1 Gen)";
    if ([hardware isEqualToString:@"iPod2,1"])      return @"iPod Touch (2 Gen)";
    if ([hardware isEqualToString:@"iPod3,1"])      return @"iPod Touch (3 Gen)";
    if ([hardware isEqualToString:@"iPod4,1"])      return @"iPod Touch (4 Gen)";
    if ([hardware isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    
    if ([hardware isEqualToString:@"iPad1,1"])      return @"iPad (WiFi)";
    if ([hardware isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([hardware isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([hardware isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([hardware isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([hardware isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi Rev. A)";
    if ([hardware isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([hardware isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([hardware isEqualToString:@"iPad2,7"])      return @"iPad Mini (CDMA)";
    if ([hardware isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([hardware isEqualToString:@"iPad3,2"])      return @"iPad 3 (CDMA)";
    if ([hardware isEqualToString:@"iPad3,3"])      return @"iPad 3 (Global)";
    if ([hardware isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([hardware isEqualToString:@"iPad3,5"])      return @"iPad 4 (CDMA)";
    if ([hardware isEqualToString:@"iPad3,6"])      return @"iPad 4 (Global)";
    if ([hardware isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([hardware isEqualToString:@"iPad4,2"])      return @"iPad Air (WiFi+GSM)";
    if ([hardware isEqualToString:@"iPad4,3"])      return @"iPad Air (WiFi+CDMA)";
    if ([hardware isEqualToString:@"iPad4,4"])      return @"iPad Mini Retina (WiFi)";
    if ([hardware isEqualToString:@"iPad4,5"])      return @"iPad Mini Retina (WiFi+CDMA)";
    if ([hardware isEqualToString:@"iPad4,6"])      return @"iPad Mini Retina (Wi-Fi + Cellular CN)";
    if ([hardware isEqualToString:@"iPad4,7"])      return @"iPad Mini 3 (Wi-Fi)";
    if ([hardware isEqualToString:@"iPad4,8"])      return @"iPad Mini 3 (Wi-Fi + Cellular)";
    if ([hardware isEqualToString:@"iPad5,3"])      return @"iPad Air 2 (Wi-Fi)";
    if ([hardware isEqualToString:@"iPad5,4"])      return @"iPad Air 2 (Wi-Fi + Cellular)";
    
    if ([hardware isEqualToString:@"i386"])         return @"iOS_Simulator";
    if ([hardware isEqualToString:@"x86_64"])       return @"iOS_Simulator";
    if ([hardware hasPrefix:@"iPhone"])             return @"iPhone";
    if ([hardware hasPrefix:@"iPod"])               return @"iPod";
    if ([hardware hasPrefix:@"iPad"])               return @"iPad";
    
    return nil;
}

+ (NSString*)jj_platformSimpleDescription
{
    NSString *hardware = [self jj_platform];
    if ([hardware isEqualToString:@"iPhone1,1"])    return @"iPhone 2G";
    if ([hardware isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([hardware isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([hardware isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([hardware isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([hardware isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([hardware isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([hardware isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([hardware isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([hardware isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([hardware isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([hardware isEqualToString:@"iPhone6,1"])    return @"iPhone 5s";
    if ([hardware isEqualToString:@"iPhone6,2"])    return @"iPhone 5s";
    if ([hardware isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([hardware isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([hardware isEqualToString:@"iPhone8,2"])    return @"iPhone 6S Plus";
    if ([hardware isEqualToString:@"iPhone8,1"])    return @"iPhone 6S";
    
    if ([hardware isEqualToString:@"iPod1,1"])      return @"iPod Touch (1 Gen)";
    if ([hardware isEqualToString:@"iPod2,1"])      return @"iPod Touch (2 Gen)";
    if ([hardware isEqualToString:@"iPod3,1"])      return @"iPod Touch (3 Gen)";
    if ([hardware isEqualToString:@"iPod4,1"])      return @"iPod Touch (4 Gen)";
    if ([hardware isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    
    if ([hardware isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([hardware isEqualToString:@"iPad1,2"])      return @"iPad";
    if ([hardware isEqualToString:@"iPad2,1"])      return @"iPad 2";
    if ([hardware isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([hardware isEqualToString:@"iPad2,3"])      return @"iPad 2";
    if ([hardware isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([hardware isEqualToString:@"iPad2,5"])      return @"iPad Mini";
    if ([hardware isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([hardware isEqualToString:@"iPad2,7"])      return @"iPad Mini";
    if ([hardware isEqualToString:@"iPad3,1"])      return @"iPad 3";
    if ([hardware isEqualToString:@"iPad3,2"])      return @"iPad 3";
    if ([hardware isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([hardware isEqualToString:@"iPad3,4"])      return @"iPad 4";
    if ([hardware isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([hardware isEqualToString:@"iPad3,6"])      return @"iPad 4";
    if ([hardware isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([hardware isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([hardware isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([hardware isEqualToString:@"iPad4,4"])      return @"iPad Mini Retina";
    if ([hardware isEqualToString:@"iPad4,5"])      return @"iPad Mini Retina";
    if ([hardware isEqualToString:@"iPad4,6"])      return @"iPad Mini Retina CN";
    if ([hardware isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([hardware isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([hardware isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([hardware isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    
    if ([hardware isEqualToString:@"i386"])         return @"iOS_Simulator";
    if ([hardware isEqualToString:@"x86_64"])       return @"iOS_Simulator";
    if ([hardware hasPrefix:@"iPhone"])             return @"iPhone";
    if ([hardware hasPrefix:@"iPod"])               return @"iPod";
    if ([hardware hasPrefix:@"iPad"])               return @"iPad";
    
    return nil;
}

+ (NSString *)jj_systemName
{
    return [UIDevice currentDevice].systemName;
}

+ (NSString *)jj_systemVersion
{
    return [UIDevice currentDevice].systemVersion;
}

+ (NSString *)jj_macAddress
{
    int 					mib[6];
    size_t              	len;
    char                	*buf;
    unsigned char       	*ptr;
    struct if_msghdr    	*ifm;
    struct sockaddr_dl  	*sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0)
    {
        NSLog(@"getMacAddress Error: if_nametoindex error/n");
        return nil;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0)
    {
        NSLog(@"getMacAddress Error: sysctl, take 1/n");
        return nil;
    }
    
    if ((buf = (char*)malloc(len)) == NULL)
    {
        NSLog(@"getMacAddress: Could not allocate memory. error!/n");
        return nil;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0)
    {
        NSLog(@"getMacAddress: Error: sysctl, take 2");
        free(buf);
        return nil;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    
    free(buf);
    return [outstring uppercaseString];
}

+ (NSString *)jj_IPAdress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

+ (CGSize)jj_backCameraStillImageResolutionInPixels
{
    switch ([self jj_hardware]) {
        case IPHONE_2G:
        case IPHONE_3G:
            return CGSizeMake(1600, 1200);
            break;
        case IPHONE_3GS:
            return CGSizeMake(2048, 1536);
            break;
        case IPHONE_4:
        case IPHONE_4_CDMA:
        case IPAD_3_WIFI:
        case IPAD_3_WIFI_CDMA:
        case IPAD_3:
        case IPAD_4_WIFI:
        case IPAD_4:
        case IPAD_4_GSM_CDMA:
            return CGSizeMake(2592, 1936);
            break;
        case IPHONE_4S:
        case IPHONE_5:
        case IPHONE_5_CDMA_GSM:
        case IPHONE_5C:
        case IPHONE_5C_CDMA_GSM:
        case IPHONE_5S:
        case IPHONE_5S_CDMA_GSM:
        case IPHONE_6:
        case IPHONE_6_PLUS:
        case IPHONE_6S:
        case IPHONE_6S_PLUS:
        case IPHONE_SE:
        case IPHONE_7:
        case IPHONE_7_PLUS:
            return CGSizeMake(3264, 2448);
            break;
            
        case IPOD_TOUCH_4G:
            return CGSizeMake(960, 720);
            break;
        case IPOD_TOUCH_5G:
            return CGSizeMake(2440, 1605);
            break;
            
        case IPAD_2_WIFI:
        case IPAD_2:
        case IPAD_2_CDMA:
            return CGSizeMake(872, 720);
            break;
            
        case IPAD_MINI_WIFI:
        case IPAD_MINI:
        case IPAD_MINI_WIFI_CDMA:
            return CGSizeMake(1820, 1304);
            break;
            
        case IPAD_AIR_2_WIFI:
        case IPAD_AIR_2_WIFI_CELLULAR:
            return CGSizeMake (1536, 2048);
            break;
            
        default:
            NSLog(@"We have no resolution for your device's camera listed in this category. Please, make photo with back camera of your device, get its resolution in pixels (via Preview Cmd+I for example) and add a comment to this repository (https://github.com/InderKumarRathore/UIDeviceUtil) on GitHub.com in format Device = Hpx x Wpx.");
            NSLog(@"Your device is: %@", [self jj_platformDescription]);
            break;
    }
    return CGSizeZero;
}

+ (NSString *)jj_getSysInfoByName:(const char *)aTypeSpecifier;
{
    size_t size;
    sysctlbyname(aTypeSpecifier, NULL, &size, NULL, 0);
    NSString * results = nil;
    if (size > 0) {
        char * answer = malloc(size);
        if (answer) {
            sysctlbyname(aTypeSpecifier, answer, &size, NULL, 0);
            results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
            free(answer);
        }
    }
    return results;
}

#pragma mark - Memory

+ (double)jj_realMemory
{
    return [NSProcessInfo processInfo].physicalMemory / 1024.0 / 1024.0;
}

+ (double)jj_availableMemory
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    return ((vm_page_size *vmStats.free_count) / 1024.0) / 1024.0;
}

+ (double)jj_usedMemory
{
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    
    if (kernReturn != KERN_SUCCESS)
    {
        return NSNotFound;
    }
    
    return taskInfo.resident_size / 1024.0 / 1024.0;
}

#pragma mark - 运营商信息

+ (NSString *)jj_mobileCountryCode
{
    CTTelephonyNetworkInfo * netInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier * carrier = [netInfo subscriberCellularProvider];
    return [carrier mobileCountryCode];
}

+ (NSString *)jj_mobileNetworkCode
{
    CTTelephonyNetworkInfo * netInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier * carrier = [netInfo subscriberCellularProvider];
    return [carrier mobileNetworkCode];
}

+ (NSString *)jj_carrierName
{
    CTTelephonyNetworkInfo * netInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier * carrier = [netInfo subscriberCellularProvider];
    return carrier.carrierName;
}

+ (BOOL)jj_allowsVOIP
{
    CTTelephonyNetworkInfo * netInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier * carrier = [netInfo subscriberCellularProvider];
    return carrier.allowsVOIP;
}

+ (NSString *)jj_isoCountryCode
{
    CTTelephonyNetworkInfo * netInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier * carrier = [netInfo subscriberCellularProvider];
    return carrier.isoCountryCode;
}

+ (NSString *)jj_currentRadioAccessTechnology
{
    CTTelephonyNetworkInfo *current = [[CTTelephonyNetworkInfo alloc] init];
    return current.currentRadioAccessTechnology;
}

#pragma mark - JailBreak

+ (BOOL)jj_isJailBreak
{
    BOOL jailbroken = NO;
    NSString *cydiaPath = @"/Applications/Cydia.app";
    NSString *aptPath = @"/private/var/lib/apt/";
    if ([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath])
    {
        jailbroken = YES;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:aptPath])
    {
        jailbroken = YES;
    }
    return jailbroken;
}

#pragma mark - Screen

+ (BOOL)jj_isZoom
{
    if (3 == (NSInteger)(round([UIScreen mainScreen].scale)))
    {
        // Plus-sized
        return [UIScreen mainScreen].nativeScale > 2.7;
    }
    else
    {
        return [UIScreen mainScreen].nativeScale > [UIScreen mainScreen].scale;
    }
}

+ (CGSize)jj_screenSizeIgnoreDisplayZoom
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    // 弥补iPhone 6和iPhone 6 Plus中的“设置”->“显示与亮度”->"显示模式"对[UIScreen mainScreen].bounds.size的影响
    JJHardware hardware = [UIDevice jj_hardware];
    if (IPHONE_6 == hardware || IPHONE_6S == hardware || IPHONE_7 == hardware)
    {
        screenSize= CGSizeMake(375, 667);
    }
    else if (IPHONE_6_PLUS == hardware || IPHONE_6S_PLUS == hardware || IPHONE_7_PLUS == hardware)
    {
        screenSize= CGSizeMake(414, 736);
    }
    
    if ([self jj_isZoom])
    {
        CGSize size = [UIScreen mainScreen].nativeBounds.size;
        screenSize.width = size.width / [UIScreen mainScreen].scale;
        screenSize.height = size.height / [UIScreen mainScreen].scale;
    }
    
    return screenSize;
}

+ (CGRect)jj_screenBounds
{
    return [UIScreen mainScreen].bounds;
}

+ (CGSize)jj_screenSize
{
    return [UIScreen mainScreen].bounds.size;
}

+ (CGFloat)jj_screenWidth
{
    return [self jj_screenSize].width;
}

+ (CGFloat)jj_screenHeight
{
    return [self jj_screenSize].height;
}

@end
