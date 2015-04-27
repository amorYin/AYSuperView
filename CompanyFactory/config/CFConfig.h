//
//  CFConfig.h
//  CompanyFactory
//
//  Created by AmorYin on 14-4-12.
//  Copyright (c) 2014年 AmorYin. All rights reserved.
//

#ifndef CompanyFactory_CFConfig_h
#define CompanyFactory_CFConfig_h

#pragma mark -header
#import "CFLibLink.h"
#import "CFColor.h"
#import "CFDebug.h"
#import "info.h"
#import "sys/utsname.h"
#import "ConstDefine.h"

#pragma mark - 资源方法
/**
 * DefaultKey  从配置文件里读取图片地址
 */
#define DefaultKey(key)                        [[NSUserDefaults standardUserDefaults] objectForKey:key]
#define DefaultData(key1,key2)                 [DefaultKey(key1) objectForKey:key2]
#define DefaultObjDataCell(key1,key2,key3)     [DefaultData(key1,key2) objectForKey:key3]
#define DefaultFloatDataCell(key1,key2,key3)   [DefaultObjDataCell(key1,key2,key3) floatValue]
#define DefaultIntDataCell(key1,key2,key3)   [DefaultObjDataCell(key1,key2,key3) intValue]
/**
 * ImagePrefix  从配置文件里读取图片地址
 */
#define ImagePrefix         DefaultKey(@"imagePrefix")
/**
 *  获取当前图片的目录
 *
 *  @param imageName  图片名称
 *
 *  @return 返回当前图片名称的完整目录
 */
#define ImagePrefixName(imageName)  [NSString stringWithFormat:@"%@/%@",ImagePrefix,imageName]
#define HTMLPrefixName(pre,imageName)  [NSString stringWithFormat:@"%@/%@/%@",ImagePrefix,pre,imageName]
#define HTMLPrefixsName(imageName)  [[NSBundle mainBundle] pathForResource:imageName ofType:nil]
/**
 *  获取当前图片的目录
 *
 *  @param prefix    前缀名
 *  @param imageName 图片名
 *
 *  @return 返回当前图片名称的完整目录
 */
#define ImageName(prefix,imageName)  [NSString stringWithFormat:@"%@/%@",prefix,imageName]
/**
 *  获取当前图片
 *
 *  @param imageName 图片名
 *
 *  @return 返回当前图片
 */
#define CFImage(imageName)  [UIImage imageNamed:HTMLPrefixsName(imageName)]
/**
 *  获取当前图片
 *
 *  @param prefix    前缀名
 *  @param imageName 图片名
 *
 *  @return 返回当前图片
 */
#define CFPreImage(prefix,imageName)  [UIImage imageNamed:ImageName(prefix,imageName)]
/**
 * RGBA(r,g,b,a)  获取RGB颜色
 *  r  红色float值
 *  g  绿色float值
 *  b  蓝色float值
 *  a  0～1之间的float透明度值
 */
#define RGBA(r,g,b,a)       [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a]
/**
 * CRGBA(r,g,b,a)  获取RGB颜色结构体
 *  r  红色float值
 *  g  绿色float值
 *  b  蓝色float值
 *  a  0～1之间的float透明度值
 */
#define CRGBA(r,g,b,a)      [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a].CGColor

/**
 * FZDColor  自定义颜色
 */
#define FZColorData(name)      [DefaultKey(@"Color") objectForKey:name]
/**
 * FZDTextColor                 预设文本颜色
 * FZDNavigationColor           预设导航栏背景颜色
 * FZDNavigationTitleColor      预设导航栏字体颜色
 * FZDViewBackgroundColor       预设试图背景颜色
 * FZDNavigationSepColor        预设导航栏分割线颜色
 */
#define FZDTextColor                RGBA(DefaultFloatDataCell(@"Color",@"text-color",@"R"),\
                                         DefaultFloatDataCell(@"Color",@"text-color",@"G"),\
                                         DefaultFloatDataCell(@"Color",@"text-color",@"B"),\
                                         DefaultFloatDataCell(@"Color",@"text-color",@"A"))
#define FZDNavigationColor          RGBA(DefaultFloatDataCell(@"Color",@"navigation-color",@"R"),\
                                         DefaultFloatDataCell(@"Color",@"navigation-color",@"G"),\
                                         DefaultFloatDataCell(@"Color",@"navigation-color",@"B"),\
                                         DefaultFloatDataCell(@"Color",@"navigation-color",@"A"))
#define FZDNavigationTitleColor     RGBA(DefaultFloatDataCell(@"Color",@"navigation-title-color",@"R"),\
                                         DefaultFloatDataCell(@"Color",@"navigation-title-color",@"G"),\
                                         DefaultFloatDataCell(@"Color",@"navigation-title-color",@"B"),\
                                         DefaultFloatDataCell(@"Color",@"view-background-color",@"A"))
#define FZDViewBackgroundColor      RGBA(DefaultFloatDataCell(@"Color",@"view-background-color",@"R"),\
                                         DefaultFloatDataCell(@"Color",@"view-background-color",@"G"),\
                                         DefaultFloatDataCell(@"Color",@"view-background-color",@"B"),\
                                         DefaultFloatDataCell(@"Color",@"view-background-color",@"A"))
#define FZDNavigationSepColor       RGBA(DefaultFloatDataCell(@"Color",@"navigation-sep-color",@"R"),\
                                         DefaultFloatDataCell(@"Color",@"navigation-sep-color",@"G"),\
                                         DefaultFloatDataCell(@"Color",@"navigation-sep-color",@"B"),\
                                         DefaultFloatDataCell(@"Color",@"navigation-sep-color",@"A"))
/**
 * degreesToRadian  由角度获取弧度
 */
#define degreesToRadian(x)      (M_PI * (x) / 180.0)
/**
 * radianToDegrees  由弧度获取角度
 */
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

/**
 * FZFont  方正黑体简体字体定义
 */
#define FZFont(F)          [UIFont fontWithName:@"ElegantIcons" size:F]

/**
 * FZDFont  自定义字体
 */
#define FZDFont(name,size)          [UIFont fontWithName:name size:size]
#define FZFontData(key)             [DefaultKey(@"Font") objectForKey:key]
#define FZDTextFont                 [UIFont fontWithName:DefaultObjDataCell(@"Font",@"text-font",@"name")\
                                                    size:DefaultFloatDataCell(@"Font",@"text-font",@"size")]
#define FZDTextFontSize(x)          [UIFont fontWithName:DefaultObjDataCell(@"Font",@"text-font",@"name")\
                                                    size:x]
#define FZDButtonFont               [UIFont fontWithName:DefaultObjDataCell(@"Font",@"button-font",@"name")\
                                                    size:DefaultFloatDataCell(@"Font",@"button-font",@"size")]
#define FZDButtonFontSize(x)        [UIFont fontWithName:DefaultObjDataCell(@"Font",@"button-font",@"name")\
                                                    size:x]
#define FZDTitleFont                [UIFont fontWithName:DefaultObjDataCell(@"Font",@"title-font",@"name")\
                                                    size:DefaultFloatDataCell(@"Font",@"title-font",@"size")]
#define FZDTitleFontSize(x)         [UIFont fontWithName:DefaultObjDataCell(@"Font",@"title-font",@"name")\
                                                    size:x]
/**
 * RigisterDefault  把一个plist注册到用户中心
 * 参数 plist 文件名
 */
#define REGISTER_DEFAULT(plist) \
[[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithContentsOfFile:\
[[NSBundle mainBundle] pathForResource:plist ofType:@"plist"]]];\
NSLog(@"%@",[NSDictionary dictionaryWithContentsOfFile:\
[[NSBundle mainBundle] pathForResource:plist ofType:@"plist"]]);

#pragma mark - 系统方法
/**
 * iOS(x)  判断当前系统版本号是否高于 x
 */
#define iOS(x)              [[[UIDevice currentDevice] systemVersion] floatValue]>=x
/**
 * 检测系统版本
 */
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

/**
 * 判断设备型号
 */
#ifndef DEVICE_MODEL_TYPE

#define DEVICE_MODEL_TYPE   ({struct utsname systemInfo; uname(&systemInfo);\
    ([NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding]);})
#endif

#define DEVICE_VERSION_EQUAL_TO(v)                  ([DEVICE_MODEL_TYPE compare:v options:NSNumericSearch] == NSOrderedSame)
#define DEVICE_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([DEVICE_MODEL_TYPE compare:v options:NSNumericSearch] != NSOrderedAscending)

#define DEVICE_VERSION_GREATER_THAN_OR_EQUAL_TO_iPhone_6  DEVICE_VERSION_GREATER_THAN_OR_EQUAL_TO(@"iPhone6,1")
#define DEVICE_VERSION_GREATER_THAN_OR_EQUAL_TO_iPhone_5  DEVICE_VERSION_GREATER_THAN_OR_EQUAL_TO(@"iPhone5,1")
#define DEVICE_VERSION_GREATER_THAN_OR_EQUAL_TO_iPhone_4  DEVICE_VERSION_GREATER_THAN_OR_EQUAL_TO(@"iPhone4,1")
#define DEVICE_VERSION_GREATER_THAN_OR_EQUAL_TO_iPhone_3  DEVICE_VERSION_GREATER_THAN_OR_EQUAL_TO(@"iPhone3,1")
#define DEVICE_SIMULATOR                                  (DEVICE_VERSION_EQUAL_TO(@"i386")|DEVICE_VERSION_EQUAL_TO(@"x86_64"))
/**
 * iOS(x)  获取系统版本
 */
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]
/**
 * iOS(x)  获取当前语言
 */
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

#pragma mark - 类方法
/**
 * SYNTHESIZE_SINGLETON_FOR_CLASS  单例化一个类 
 * 参数 classname 类名
 */
#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)shared##classname \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [[self alloc] init]; \
} \
} \
\
return shared##classname; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [super allocWithZone:zone]; \
return shared##classname; \
} \
} \
\
return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
}

#endif
