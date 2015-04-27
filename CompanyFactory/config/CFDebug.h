//
//  CFDebug.h
//  CompanyFactory
//
//  Created by AmorYin on 14-4-21.
//  Copyright (c) 2014年 AmorYin. All rights reserved.
//

#ifndef CompanyFactory_CFDebug_h
#define CompanyFactory_CFDebug_h




#define CFEBUG
#define CFLOGLEVEL_INFO     10
#define CFLOGLEVEL_WARNING  3
#define CFLOGLEVEL_ERROR    1

#ifndef CFMAXBUGLEVEL

#if DEBUG
#define CFMAXBUGLEVEL   CFLOGLEVEL_INFO
#else
#define CFMAXBUGLEVEL   CFLOGLEVEL_ERROR
#endif

#endif

#if DEBUG

#if CFMAXBUGLEVEL <= CFLOGLEVEL_ERROR
    #define CFLog(fmt,...)   fprintf(stderr,"\n    file: %s\nfunction: %s\n    line: %d\n content: %s\n",__FILE__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:fmt, ##__VA_ARGS__] UTF8String]);
#elif  CFMAXBUGLEVEL <= CFLOGLEVEL_WARNING
    #define CFLog(fmt,...)   NSLog((@"<%s> [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#elif  CFMAXBUGLEVEL <= CFLOGLEVEL_INFO
    #define CFLog(fmt,...)   NSLog((@"[Line %d] " fmt), __LINE__, ##__VA_ARGS__);
#else
    #define CFLog(fmt,...)  ((void)0)
#endif

    #define NSLog(FORMAT, ...)   fprintf(stderr,"\n    file: %s\nfunction: %s\n    line: %d\n content: %s\n",__FILE__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#else
    #define NSLog(FORMAT, ...)   ((void)0)
    #define CFLog(fmt,...)  ((void)0)
#endif




#endif
