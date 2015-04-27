//
//  CFiPhoneSuperView.h
//  CompanyFactory
//
//  Created by AmorYin on 14-4-12.
//  Copyright (c) 2014年 AmorYin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CFTransitionStyle) {
    CFTransitionStyleSlideFromRight = 0,
    CFTransitionStyleSlideFromBottom,
    CFTransitionStyleSlideFromTop,
    CFTransitionStyleSlideFromLeft,
    CFTransitionStyleFade,
    CFTransitionStyleBounce,
    CFTransitionStyleDropDown
};

typedef void(^CFNavigationHandler)(UIView *actionView);

@protocol CFiPhoneSuperMethod <NSObject>
@optional
- (void)viewWilChangeInterfaceOrientation:(UIInterfaceOrientation)orgin;
- (void)needFranshUserStatus:(NSDictionary*)noti;
@end

@interface CFiPhoneSuperView : UIView
/**
 *  设置状态栏隐藏，默认 NO
 */
@property (nonatomic,getter = isStatusbarHidden) BOOL statusBarHidden;
/**
 *  判断用户登录，默认 NO
 */
@property (nonatomic,getter = isUserLoaded) BOOL userLoaded;
/**
 *  设置导航栏隐藏，默认 NO
 */
@property (nonatomic,getter = isNavigationBarHidden) BOOL navigationBarHidden;
/**
 *  设置底层栏隐藏，默认 NO
 */
@property (nonatomic,getter = isBottomBarHidden) BOOL bottomBarHidden;
/**
 *  是否全屏,默认 NO
 */
@property (nonatomic,getter = isWantsFullscreen) BOOL wantsFullscreen;
/**
 *  是否支持旋转,默认 YES
 */
@property (nonatomic,getter = isSupportInterface) BOOL supportInterface;
/**
 *  是否支持旋转,默认 YES
 */
@property (nonatomic,getter = isSwapEnable) BOOL swapEnable;

/**
 *  导航栏标题栏
 */
@property (nonatomic,strong) NSString *title;
/**
 *  导航栏标题背景图
 */
@property (nonatomic,strong) UIImage *titleImage;
/**
 *  导航栏背景图
 */
@property (nonatomic,strong) UIImage *navigationBackImage;
/**
 *  导航栏左侧按钮
 */
@property (nonatomic,strong)UIButton *leftBarButton;
/**
 *  导航栏右侧按钮
 */
@property (nonatomic,strong)UIView *rightBarButton;
/**
 *  导航栏title的颜色
 */
@property (nonatomic,strong)UIColor *titleColor;
/**
 *  导航栏的颜色
 */
@property (nonatomic,strong)UIColor *navigationColor;
/**
 *  导航栏分割线的颜色
 */
@property (nonatomic,strong)UIColor *navigationSepreatorColor;
/**
 *  导航栏分割线的颜色
 */
@property (nonatomic,readonly)UIView *navigationView;
/**
 *  导航栏分割线的颜色
 */
@property (nonatomic,strong)UIView *bottomView;
/**
 * 动画时间
 */
@property (nonatomic,assign)NSTimeInterval duration;
/**
 *  默认是 CFTransitionStyleSlideFromRight
 */
@property (nonatomic, assign) CFTransitionStyle transitionInStyle;
/**
 *  默认是 CFTransitionStyleSlideFromRight
 */
@property (nonatomic, assign) CFTransitionStyle transitionOutStyle;
/**
 *  移动加载的节点记录
 */
@property (nonatomic,weak)UIView *preView;
@property (nonatomic,weak)UIView *nextView;
/**
 *  所有创建的子元素都要放在这个view上
 */
@property(nonatomic,strong)UIScrollView *contentView;
/**
 *  是否支持旋转,默认 YES
 *  需要使用 
 * - (void)addMySubview:(UIView*)view;
 * - (void)addMySublayer:(CALayer*)layer;
 */
@property (nonatomic,getter = isAutoContentSize) BOOL autoContentSize;
/**
 * autoSwapGestureRecognizer 是设置是否在contentview设置自动返回，默认为YES
 */
@property (nonatomic,getter = isAutoSwapGestureRecognizer) BOOL autoSwapGestureRecognizer;
/**
 *  block块
 */
@property (nonatomic, copy) CFNavigationHandler willShowHandler;
@property (nonatomic, copy) CFNavigationHandler didShowHandler;
@property (nonatomic, copy) CFNavigationHandler willDismissHandler;
@property (nonatomic, copy) CFNavigationHandler didDismissHandler;
@property (nonatomic, copy) CFNavigationHandler didRemoveHandle;

- (void)setupUI;
- (void)presentOnView:(__weak UIView*)handler;
- (void)dismiss;
- (void)presentOnView:(__weak UIView*)handler withAnimation:(BOOL)animation;
- (void)dismissWithAnimation:(BOOL)animation;
- (void)viewWilChangeInterfaceOrientation:(UIInterfaceOrientation)orgin;
- (void)addMySubview:(UIView*)view;
- (void)addMySublayer:(CALayer*)layer;
- (void)resetContentSize;
- (void)setBottomBarHidden:(BOOL)bottomBarHidden withDuration:(NSTimeInterval)duration;
- (void)deallocc;
@end
