//
//  ConstDefine.h
//  CompanyFactory
//
//  Created by AmorYin on 14-4-21.
//  Copyright (c) 2014年 AmorYin. All rights reserved.
//

#ifndef YangCheDaGe_ConstDefine_h
#define YangCheDaGe_ConstDefine_h

#pragma mark - 通知字符串
/**
 * NEED_REFRANSH_LOAD  是否刷新用户登录信息通知 key
 */
#define NEED_REFRANSH_USERINFO   @"NEED_REFRANSH_USERINFO"
/**
 * NEED_REFRANSH_LOAD  是否刷新用户登录信息通知 key
 */
#define NEED_LOAD_USERINFO   @"NEED_LOAD_USERINFO"
/**
 * NEED_DISMISS_VIEW  通知根试图关闭
 */
#define NEED_DISMISS_VIEW   @"NEED_DISMISS_VIEW"

#pragma mark - 定义常量

/**
 *
 */
#define TEMPONARY_INDEX     1

#define _width [[UIScreen mainScreen] bounds].size.width
#define _height [[UIScreen mainScreen] bounds].size.height

#define HEAD_PAHT [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"pic.jpg"]

#define  TEST    true

#endif
