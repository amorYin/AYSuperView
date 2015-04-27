//
//  CFiPhoneSuperView.m
//  CompanyFactory
//
//  Created by AmorYin on 14-4-12.
//  Copyright (c) 2014年 AmorYin. All rights reserved.
//

#import "CFiPhoneSuperView.h"
#import "CFViewController.h"

@interface CFiPhoneSuperView()
{
    UIImageView *_titleImageView;
    UIImageView *_navigationBackImageView;
    UILabel *_titleLable;
    UIView *_navigationSepreatorView;
    BOOL _animation;
    UIInterfaceOrientation orient;
    CGFloat bottomHeight;
    UISwipeGestureRecognizer *originS;
}
@property(nonatomic,strong)UIView *navigationView;
@end
@implementation CFiPhoneSuperView
@synthesize statusBarHidden=_statusBarHidden;
@synthesize userLoaded=_userLoaded;
@synthesize navigationBarHidden=_navigationBarHidden;
@synthesize bottomBarHidden=_bottomBarHidden;
@synthesize wantsFullscreen=_wantsFullscreen;
@synthesize title=_title;
@synthesize leftBarButton=_leftBarButton;
@synthesize rightBarButton=_rightBarButton;
@synthesize navigationSepreatorColor=_navigationSepreatorColor;
@synthesize navigationColor=_navigationColor;
@synthesize titleColor=_titleColor;
@synthesize navigationBackImage=_navigationBackImage;
@synthesize titleImage=_titleImage;
@synthesize duration=_duration;
@synthesize supportInterface=_supportInterface;
@synthesize autoContentSize=_autoContentSize;
@synthesize contentView = _contentView;
@synthesize autoSwapGestureRecognizer=_autoSwapGestureRecognizer;
@synthesize swapEnable = _swapEnable;

- (id)initWithFrame:(CGRect)frame
{
    @autoreleasepool {
        self = [super initWithFrame:frame];
        if (self) {
            // Initialization code
            _navigationSepreatorColor = [UIColor redColor];//FZDNavigationSepColor;
            _titleColor = [UIColor blackColor];//FZDNavigationTitleColor;
            _navigationColor = RGBA(242, 242, 242, 1.);//FZDNavigationColor;
            _transitionInStyle = CFTransitionStyleSlideFromRight;
            _transitionOutStyle = CFTransitionStyleSlideFromRight;
            _autoSwapGestureRecognizer = YES;
            _supportInterface = YES;
            _autoContentSize = YES;
            bottomHeight = 0.0;
            _swapEnable = YES;
            _duration = [[UIApplication sharedApplication] statusBarOrientationAnimationDuration];
            self.backgroundColor = [UIColor whiteColor];//FZDViewBackgroundColor;
            
            if (DEVICE_VERSION_GREATER_THAN_OR_EQUAL_TO_iPhone_5) {
                CALayer *frontViewLayer = self.layer;
                frontViewLayer.masksToBounds = NO;
                frontViewLayer.shadowColor = [UIColor blackColor].CGColor;
                frontViewLayer.shadowOpacity = 1.0f;
                frontViewLayer.shadowOpacity = 1.0;
                frontViewLayer.shadowOffset = CGSizeMake(0.0f, 2.5f);
                frontViewLayer.shadowRadius = 5.f;
                frontViewLayer = nil;
            }

            
            //rigister REFRANSH_LOAD_SUCCESS
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(needFranshUserInfo:)
                                                         name:NEED_REFRANSH_USERINFO
                                                       object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(supportedInterfaceOrientationsForWindow:)
                                                         name:UIApplicationWillChangeStatusBarOrientationNotification
                                                       object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(supportedInterfaceeStatusBarFrame:)
                                                         name:UIApplicationWillChangeStatusBarFrameNotification
                                                       object:nil];
            
            [self setupUI];
        }
        return self;
    }
}

- (CGRect)fetchBounds
{
    @autoreleasepool {
        UIView *pview = [(CFViewController*)[CFViewController shareMainViewController] view];
        return  pview.bounds;
    }

}
- (CGRect)fetchFrame
{
    @autoreleasepool {
        UIView *pview = [(CFViewController*)[CFViewController shareMainViewController] view];
        return  pview.frame;
    }
}
- (BOOL)isStatusbarHidden
{
    return _statusBarHidden;
}
- (BOOL)isUserLoaded
{
    return _userLoaded;
}
- (BOOL)isWantsFullscreen
{
    return _wantsFullscreen;
}
- (BOOL)isNavigationBarHidden
{
    return _navigationBarHidden;
}
- (BOOL)isBottomBarHidden
{
    return _bottomBarHidden;
}
- (BOOL)isSupportInterface
{
    return _supportInterface;
}
- (BOOL)isAutoContentSize
{
    return _autoContentSize;
}
- (BOOL)isSwapEnable
{
    return _swapEnable;
}
- (BOOL)isAutoSwapGestureRecognizer
{
    return _autoSwapGestureRecognizer;
}
- (void)setAutoContentSize:(BOOL)autoContentSize
{
    _autoContentSize = autoContentSize;
    [[self contentView] setScrollEnabled:_autoContentSize];
}
- (void)setBottomBarHidden:(BOOL)bottomBarHidden
{
    _bottomBarHidden = bottomBarHidden;
    NSTimeInterval time = [[UIApplication sharedApplication] statusBarOrientationAnimationDuration];
    [self setBottomBarHidden:_bottomBarHidden withDuration:time];
}
- (UIView*)_navigationSepreatorView
{
    if (!_navigationSepreatorView) {
        __autoreleasing UIView *view = [[UIView alloc]init];
        _navigationSepreatorView = view;
        view = nil;
    }
    if (iOS(7.0)) {
        _navigationSepreatorView.frame = CGRectMake(0, 64.5, CGRectGetWidth([self fetchBounds]), 0.5);
    }else{
        _navigationSepreatorView.frame = CGRectMake(0, 44.5, CGRectGetWidth([self fetchBounds]), 0.5);
    }
    _navigationSepreatorView.backgroundColor = _navigationSepreatorColor;
    return _navigationSepreatorView;
}
- (UIImageView*)_navigationBackImageView
{
    if (!_navigationBackImageView) {
        CGRect frame = [[self navigationView] bounds];
        if (iOS(7.0)) {
            _navigationBackImageView = [[UIImageView alloc] initWithFrame:frame];
        }else{
            _navigationBackImageView = [[UIImageView alloc] initWithFrame:frame];
        }
        _navigationBackImageView.contentMode = UIViewContentModeScaleAspectFill;
        _navigationBackImageView.backgroundColor = [UIColor clearColor];
        _navigationBackImageView.image = _navigationBackImage;
    }
    return _navigationBackImageView;
}
- (UILabel*)_titleLable
{
    if (!_titleLable) {
        CGRect frame = [[self navigationView] frame];
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(62, CGRectGetHeight(frame)-32, CGRectGetWidth(frame)-124,20)];
        _titleLable.backgroundColor = [UIColor clearColor];
        _titleLable.font =  FZDTextFontSize(22.);//FZDTitleFont;
        _titleLable.textColor = _titleColor;
        _titleLable.shadowColor = RGBA(255, 255, 255, 1.);
#ifdef __IPHONE_6_0
        _titleLable.textAlignment = NSTextAlignmentCenter;
#else
        _titleLable.textAlignment = UITextAlignmentCenter;
#endif
    }
    return _titleLable;
}
- (UIImageView*)_titleImageView
{
    if (!_titleImageView) {
        CGRect frame = [[self _titleLable] bounds];
        if (iOS(7.0)) {
            _titleImageView = [[UIImageView alloc] initWithFrame:frame];
        }else{
            _titleImageView = [[UIImageView alloc] initWithFrame:frame];
        }
        _titleImageView.contentMode = UIViewContentModeScaleAspectFill;
        _titleImageView.backgroundColor = [UIColor clearColor];
        _titleImageView.image = _titleImage;
    }
    return _titleImageView;
}
- (UIView*)navigationView
{
    if (!_navigationView) {
        if (iOS(7.0)) {
            _navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([self fetchBounds]), 64)];
        }else{
            _navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([self fetchBounds]), 44)];
        }
        _navigationView.backgroundColor = _navigationColor;
        
        [[self navigationView] addSubview:[self _navigationSepreatorView]];
        [[self navigationView] addSubview:[self _navigationBackImageView]];
        [[self navigationView] addSubview:[self _titleImageView]];
        [[self navigationView] addSubview:[self _titleLable]];
    }
    return _navigationView;
}

- (UIButton*)leftBarButton
{
    
    if (!_leftBarButton) {
        if (iOS(7.0)) {
            _leftBarButton = [[UIButton alloc] initWithFrame:CGRectMake(2, 22, 60, 40)];
        }else{
            _leftBarButton = [[UIButton alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
        }
        _leftBarButton.backgroundColor = [UIColor clearColor];
        [_leftBarButton setImage:CFImage(@"返回图标.png") forState:UIControlStateNormal];
        [_leftBarButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBarButton;
}
- (UIScrollView*)contentView
{
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] init];
        if (_wantsFullscreen) {
            _contentView.frame = self.bounds;
        }else{
            if (iOS(7.0)) {
                _contentView.frame = CGRectMake(CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - 65-bottomHeight);
            }else{
                _contentView.frame = CGRectMake(CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)- 45-bottomHeight);
            }
        }
        _contentView.backgroundColor = self.backgroundColor;
    }
    return _contentView;
}
- (void)setContentView:(UIScrollView *)contentView
{
    if (_contentView) {
        CGRect frame = _contentView.frame;
        [_contentView removeFromSuperview];
        _contentView = contentView;
        _contentView.frame = frame;
        contentView = nil;
    }else{
        _contentView = contentView;
        contentView = nil;
        if (iOS(7.0)) {
            _contentView.frame = CGRectMake(CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - 65-bottomHeight);
        }else{
            _contentView.frame = CGRectMake(CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)- 45-bottomHeight);
        }
    }
    _contentView.backgroundColor = self.backgroundColor;
    [self addSubview:_contentView];
}
- (void)setStatusBarHidden:(BOOL)statusBarHidden
{
    @autoreleasepool {
        if (statusBarHidden) {
            [UIView animateWithDuration:0.1 animations:^{
                CGFloat orgy = [self fetchBounds].origin.y-20>0?[self fetchBounds].origin.y-20:0;
                self.frame = CGRectMake([self fetchBounds].origin.x,orgy, [self fetchBounds].size.width, [self fetchBounds].size.height+20);
            }];
            [[UIApplication sharedApplication] setStatusBarHidden:YES];
        }else{
            [UIView animateWithDuration:0.1 animations:^{
                self.frame = CGRectMake([self fetchBounds].origin.x,[self fetchBounds].origin.y+20, [self fetchBounds].size.width, [self fetchBounds].size.height-20);
            }];
            [[UIApplication sharedApplication] setStatusBarHidden:NO];
#ifdef NSFoundationVersionNumber_iOS_6_1
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
#endif
        }
    }
    _statusBarHidden = statusBarHidden;
}
- (void)setBottomBarHidden:(BOOL)bottomBarHidden withDuration:(NSTimeInterval)duration
{
    @autoreleasepool {
        if (_bottomView) {
            CGPoint orgin = _bottomView.origin;
            CGFloat height = [self contentView].height;
            if (bottomBarHidden) {
                bottomHeight = _bottomView.height;
                [UIView animateKeyframesWithDuration:duration delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
                    _bottomView.origin = CGPointMake(orgin.x, orgin.y+_bottomView.height);
                    [self contentView].height = height+_bottomView.height;
                } completion:^(BOOL finished) {
                    
                }];
            }else{
                bottomHeight = 0.0;
                [UIView animateKeyframesWithDuration:duration delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
                    _bottomView.origin = CGPointMake(orgin.x, orgin.y-_bottomView.height);
                    [self contentView].height = height-_bottomView.height;
                } completion:^(BOOL finished) {
                    
                }];
            }
        }
    }
}
- (void)setWantsFullscreen:(BOOL)wantsFullscreen
{
    _wantsFullscreen = wantsFullscreen;
    if (_wantsFullscreen) {
        [[self contentView] setOrigin:CGPointMake(0, 0)];
    }else{
         if (iOS(7.0)) {
             [[self contentView] setOrigin:CGPointMake(0, 65)];
         }else{
             [[self contentView] setOrigin:CGPointMake(0, 45)];
         }
    }
}
- (void)setNavigationBarHidden:(BOOL)navigationBarHidden
{
    _navigationBarHidden = navigationBarHidden;
    if (!_navigationBarHidden) {
        [self addSubview:[self navigationView]];
    }else{
        [[self navigationView] removeFromSuperview];
    }
}
- (void)setBottomView:(UIView *)bottomView
{
    [_bottomView removeFromSuperview];
    _bottomView = bottomView;
    bottomHeight = _bottomView.height;
    CGRect frame = _navigationSepreatorView.frame;
    CGFloat curentHeight = CGRectGetHeight(self.frame)-bottomHeight-CGRectGetMinY(frame);
   [_contentView setFrame:CGRectMake(CGRectGetMinX(frame), CGRectGetMaxY(frame), CGRectGetWidth(frame), curentHeight)];
    if (!bottomView)return;
    _bottomView.origin = CGPointMake(0, CGRectGetMaxY(self.frame)-bottomHeight);
    [self addSubview:bottomView];
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    [self _titleLable].text = _title;
    title = nil;
}
- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    [self _titleLable].textColor = titleColor;
    titleColor = nil;
}
- (void)setTitleImage:(UIImage *)titleImage
{
    _titleImage = titleImage;
    [self _titleImageView].image = titleImage;
    titleImage = nil;
}
- (void)setNavigationColor:(UIColor *)navigationColor
{
    _navigationColor = navigationColor;
    [self navigationView].backgroundColor = navigationColor;
}
- (void)setNavigationBackImage:(UIImage *)navigationBackImage
{
    _navigationBackImage = navigationBackImage;
    [self _navigationBackImageView].image = navigationBackImage;
    navigationBackImage = nil;
}
- (void)setRightBarButton:(UIView *)rightBarButton
{
    [_rightBarButton removeFromSuperview];
    _rightBarButton = rightBarButton;
    if (_rightBarButton==nil) return;
    
    if (iOS(7.0)) {
        _rightBarButton.frame = CGRectMake(CGRectGetWidth([self fetchBounds])-CGRectGetWidth(rightBarButton.frame)-10, 20, CGRectGetWidth(rightBarButton.frame), 44);
    }else{
        _rightBarButton.frame = CGRectMake(CGRectGetWidth([self fetchBounds])-CGRectGetWidth(rightBarButton.frame)-10, 0, CGRectGetWidth(rightBarButton.frame), 44);
    }
    [[self navigationView] addSubview:rightBarButton];
    rightBarButton = nil;
}

- (void)setLeftBarButton:(UIButton*)rightBarButton
{
    [_leftBarButton removeFromSuperview];
    _leftBarButton = rightBarButton;
    if (_leftBarButton==nil) return;

    if (iOS(7.0)) {
        _leftBarButton.frame = CGRectMake(2, 22, 60, 40);
    }else{
        _leftBarButton.frame = CGRectMake(2, 2, 60, 40);
    }
    [[self navigationView] addSubview:rightBarButton];
    rightBarButton = nil;
}

- (void)setAutoSwapGestureRecognizer:(BOOL)autoSwapGestureRecognizer
{
    if (_autoSwapGestureRecognizer!=autoSwapGestureRecognizer&&originS) {
        [self dismissRecognizer];
    }
    _autoSwapGestureRecognizer = autoSwapGestureRecognizer;
}
- (void)addMySubview:(UIView*)view;
{
    @autoreleasepool {
        [[self contentView] addSubview:view];
        CGSize contentSize = [[self contentView] contentSize];
        if (_autoContentSize){
            for (UIView *sub in [[self contentView] subviews]) {
                if (CGRectGetMaxY(sub.frame)>contentSize.height) {
                    contentSize = CGSizeMake(contentSize.width, CGRectGetMaxY(sub.frame));
                    NSLog(@"contentSize:%@",NSStringFromCGSize(contentSize));
                }
            }
        }
        [[self contentView] setContentSize:contentSize];
    }
}
- (void)addMySublayer:(CALayer*)layer
{
    @autoreleasepool {
        [[[self contentView] layer] addSublayer:layer];
        CGSize contentSize = [[self contentView] contentSize];
        if (_autoContentSize){
            for (CALayer *sub in [[[self contentView] layer] sublayers]) {
                if (CGRectGetMaxY(sub.frame)>contentSize.height) {
                    contentSize = CGSizeMake(contentSize.width, CGRectGetMaxY(sub.frame));
                }
            }
        }
        [[self contentView] setContentSize:contentSize];
    }
}
- (void)resetContentSize
{
    @autoreleasepool {
        CGFloat max = CGRectGetHeight(_contentView.frame);
        if (_autoContentSize){
            for (UIView *sub in [[self contentView] subviews]) {
                if (CGRectGetMaxY(sub.frame)>max) {
                    max =CGRectGetMaxY(sub.frame);
                }
            }
        }
        CGSize contentSize = CGSizeMake(CGRectGetWidth(_contentView.frame), max);
        [[self contentView] setContentSize:contentSize];
    }
}
- (void)setupUI
{
    [self setWantsFullscreen:_wantsFullscreen];
    [self setNavigationBarHidden:_navigationBarHidden];
    [self addSubview:[self contentView]];
}

#pragma mark - 
- (void)viewWilChangeInterfaceOrientation:(UIInterfaceOrientation)orgin
{
    
}
- (void)viewResetInterfaceOrientation:(UIInterfaceOrientation)orgin
{

    @autoreleasepool {
        CGFloat max = CGRectGetHeight(_contentView.frame);
        for (UIView *sub in [[self contentView] subviews]) {
            CGRect frme = sub.frame;
            CGFloat scale = CGRectGetHeight(self.frame)/CGRectGetWidth(self.frame);
            sub.frame = CGRectMake(CGRectGetMinX(frme)/scale, CGRectGetMinY(frme)/scale, CGRectGetWidth(frme)/scale, CGRectGetHeight(frme)/scale);
            if (CGRectGetMaxY(sub.frame)>max) {
                max =CGRectGetMaxY(sub.frame);
            }
        }
         CGSize contentSize = CGSizeMake(CGRectGetWidth(_contentView.frame), max);
        [[self contentView] setContentSize:contentSize];
    }
}
- (void)viewWilChangeInterfaceOr:(UIInterfaceOrientation)orgin
{
    @autoreleasepool {
        if (!_supportInterface)return;
        CGRect frame_o = [self fetchBounds];
        self.frame = CGRectMake(self.origin.x, self.origin.y, CGRectGetWidth(frame_o), CGRectGetHeight(frame_o));
        switch (orgin) {
            case UIInterfaceOrientationPortrait:
            case UIInterfaceOrientationPortraitUpsideDown:
                if ((orient==UIInterfaceOrientationPortrait)|(orient==UIInterfaceOrientationPortraitUpsideDown)) {
                    NSLog(@"状态未切换");
                }else{
                    //重新设置frame
                    if (_wantsFullscreen) {
                        _contentView.frame = self.bounds;
                    }else{
                        if (iOS(7.0)) {
                            _contentView.frame = CGRectMake(CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - 65-bottomHeight);
                        }else{
                            _contentView.frame = CGRectMake(CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)- 45-bottomHeight);
                        }
                    }
                    
                    if (iOS(7.0)) {
                        _navigationView.frame = CGRectMake(0, 0, CGRectGetWidth(frame_o), 64);
                        _navigationSepreatorView.frame = CGRectMake(0, 64, CGRectGetWidth(frame_o), 1);
                        if (!_wantsFullscreen) {
                            [_contentView setOrigin:CGPointMake(0, 65)];
                        }else{
                            [_contentView setOrigin:CGPointMake(0, 0)];
                        }
                    }else{
                        _navigationView.frame = CGRectMake(0, 0, CGRectGetWidth(frame_o), 44);
                        _navigationSepreatorView.frame = CGRectMake(0, 44, CGRectGetWidth(frame_o), 1);
                        if (!_wantsFullscreen) {
                            [_contentView setOrigin:CGPointMake(0, 45)];
                        }else{
                            [_contentView setOrigin:CGPointMake(0, 0)];
                        }
                    }
                    _navigationBackImageView.frame = _navigationView.bounds;
                    _titleLable.frame = CGRectMake(62, CGRectGetHeight(_navigationView.bounds)-32, CGRectGetWidth(_navigationView.bounds)-124,20);
//                    CGFloat y1 = CGRectGetMaxY(_contentView.frame);
//                    CGFloat y2 = CGRectGetMinY(_bottomView.frame);
//                    CGFloat marginY =  y1<y2?y1:y2;
                    _bottomView.frame = CGRectMake(CGRectGetMinX(self.bounds), self.height-bottomHeight, CGRectGetWidth(self.bounds), bottomHeight);
                    _titleImageView.frame = _titleLable.bounds;
                    _rightBarButton.frame = CGRectMake(CGRectGetWidth(_navigationView.bounds)-60, 22, 58, 40);
//                    [self viewResetInterfaceOrientation:UIInterfaceOrientationPortrait];
                }
                break;
            case UIInterfaceOrientationLandscapeLeft:
            case UIInterfaceOrientationLandscapeRight:
            {
                if ((orient==UIInterfaceOrientationLandscapeLeft)|(orient==UIInterfaceOrientationLandscapeRight)) {
                    NSLog(@"状态未切换");
                }else{
                    //重新设置frame
                    //重新设置frame
                    if (_wantsFullscreen) {
                        _contentView.frame = self.bounds;
                    }else{
                        if (iOS(7.0)) {
                            _contentView.frame = CGRectMake(CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - 65 - bottomHeight);
                        }else{
                            _contentView.frame = CGRectMake(CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - 45 - bottomHeight);
                        }
                    }
                    
                    if (iOS(7.0)) {
                        _navigationView.frame = CGRectMake(0, 0, CGRectGetWidth(frame_o), 64);
                        _navigationSepreatorView.frame = CGRectMake(0, 64, CGRectGetWidth(frame_o), 1);
                        if (!_wantsFullscreen) {
                            [_contentView setOrigin:CGPointMake(0, 65)];
                        }else{
                            [_contentView setOrigin:CGPointMake(0, 0)];
                        }
                    }else{
                        _navigationView.frame = CGRectMake(0, 0, CGRectGetWidth(frame_o), 44);
                        _navigationSepreatorView.frame = CGRectMake(0, 44, CGRectGetWidth(frame_o), 1);
                        if (!_wantsFullscreen) {
                            [_contentView setOrigin:CGPointMake(0, 45)];
                        }else{
                            [_contentView setOrigin:CGPointMake(0, 0)];
                        }
                    }
                    _navigationBackImageView.frame = _navigationView.bounds;
                    _titleLable.frame = CGRectMake(62, CGRectGetHeight(_navigationView.bounds)-32, CGRectGetWidth(_navigationView.bounds)-124,20);
//                    CGFloat y1 = CGRectGetMaxY(_contentView.frame);
//                    CGFloat y2 = CGRectGetMinY(_bottomView.frame);
//                    CGFloat marginY =  y1<y2?y1:y2;
                    _bottomView.frame = CGRectMake(CGRectGetMinX(self.bounds), self.height-bottomHeight, CGRectGetWidth(self.bounds), bottomHeight);
                    _titleImageView.frame = _titleLable.bounds;
                    _rightBarButton.frame = CGRectMake(CGRectGetWidth(_navigationView.bounds)-60, 22, 58, 40);
//                    [self viewResetInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
                }
            }
                break;
            default:
                break;
        }
        
        [[self contentView] removeFromSuperview];
        [self addSubview:[self contentView]];
        [[self navigationView] removeFromSuperview];
        [self addSubview:[self navigationView]];
        orient = orgin;
        [self viewWilChangeInterfaceOrientation:orient];
        [self resetContentSize];
    }
}
- (void)viewWillChangeInterface:(NSNumber*)orginNum
{
    [self viewWilChangeInterfaceOr:[orginNum intValue]];
    orginNum = nil;
}
- (void)supportedInterfaceOrientationsForWindow:(NSNotification*)notification
{
    NSNumber *orginNum = (NSNumber*)[[notification userInfo] objectForKey:UIApplicationStatusBarOrientationUserInfoKey];
    [self performSelector:@selector(viewWillChangeInterface:) withObject:orginNum afterDelay:0.];
    notification = nil;
}

- (void)supportedInterfaceeStatusBarFrame:(NSNotification*)notification
{
    NSDictionary* userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGRect frame = [[UIScreen mainScreen] bounds];
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height+20-keyboardRect.size.height);
    notification = nil;
}
#pragma mark - action
- (void)needFranshUserInfo:(NSNotification*)notification
{

}
#pragma mark - animation delegate
- (void)animationDidStart:(CAAnimation *)anim
{
    anim = nil;
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    anim = nil;
}
#pragma mark - animation in and out
- (void)animationOrigin:(CGPoint)oldP show:(BOOL)animation
{
    @autoreleasepool {
        __weak CFiPhoneSuperView *uSelf = (CFiPhoneSuperView*)self;
        if (animation) {
            if (_animation) {
                //animation
                [UIView animateWithDuration:_duration animations:^{
                    uSelf.preView.alpha = 0.0;
                    uSelf.preView.layer.transform = CATransform3DMakeScale(0.93,0.93,1.0);
                    uSelf.origin = oldP;
                } completion:^(BOOL finished) {
                    //noti
                    [uSelf dismissRecognizer];
                    //end
                    if (_didShowHandler) {
                        _didShowHandler(uSelf);
                    }
                    if (((CFiPhoneSuperView*)uSelf.preView).didDismissHandler) {
                        ((CFiPhoneSuperView*)uSelf.preView).didDismissHandler(uSelf.preView);
                    }
                }];
            }else{
                //animation
                [UIView animateWithDuration:_duration animations:^{
                    uSelf.origin = oldP;
                } completion:^(BOOL finished) {
                    //noti
                    [uSelf dismissRecognizer];
                    //end
                    if (_didShowHandler) {
                        _didShowHandler(uSelf);
                    }
                    
                    if (((CFiPhoneSuperView*)uSelf.preView).didDismissHandler) {
                        ((CFiPhoneSuperView*)uSelf.preView).didDismissHandler(uSelf.preView);
                    }
                }];
            }
        }else{
            if (uSelf.nextView) {
                [((CFiPhoneSuperView*)uSelf.nextView) dismissWithAnimation:NO];
            }
//----------------------------------
            if (_animation) {
                //animation
                [UIView animateWithDuration:_duration animations:^{
                    //animation
                    uSelf.origin = oldP;
                    uSelf.preView.layer.transform = CATransform3DMakeScale(1.0,1.0,1.0);
                    uSelf.preView.origin = CGPointZero;
                    uSelf.preView.alpha = 1.0;
                    uSelf.alpha = 0.5;
                } completion:^(BOOL finished) {
                    if (((CFiPhoneSuperView*)uSelf.preView).didShowHandler) {
                        ((CFiPhoneSuperView*)uSelf.preView).didShowHandler(uSelf.preView);
                    }
                    [uSelf.preView.layer removeAllAnimations];
                    [uSelf.layer removeAllAnimations];
                    uSelf.preView = nil;
                    //end
                    if (_didDismissHandler) {
                        _didDismissHandler(uSelf);
                    }
                    if (_didRemoveHandle) {
                        _didRemoveHandle(uSelf);
                    }
                    //noti
                    [uSelf deallocc];
                    [uSelf removeFromSuperview];
                }];
            }else{
                //remove
                uSelf.preView.layer.transform = CATransform3DMakeScale(1.0,1.0,1.0);
                [uSelf.preView setFrame:[uSelf fetchFrame]];
                uSelf.preView.alpha = 1.0;
                uSelf.alpha = 0.0;
                //animation
                [UIView animateWithDuration:_duration animations:^{
                    uSelf.origin = oldP;
                } completion:^(BOOL finished) {
                
                    if (((CFiPhoneSuperView*)uSelf.preView).didShowHandler) {
                        ((CFiPhoneSuperView*)uSelf.preView).didShowHandler(uSelf.preView);
                    }
                    
                    [uSelf.preView.layer removeAllAnimations];
                    [uSelf.layer removeAllAnimations];
                    uSelf.preView = nil;
                    //end
                    if (_didDismissHandler) {
                        _didDismissHandler(uSelf);
                    }
                    
                    //noti
                    [uSelf deallocc];
                    [uSelf removeFromSuperview];
                }];
            }
//----------------------------------
            
        }
    }
}
- (void)animationFadeWithShow:(BOOL)animation
{
    
}
- (void)animationBounceWithShow:(BOOL)animation
{

}
- (void)animationDropDwonWithShow:(BOOL)animation
{

}
- (void)dismissRecognizer
{
    if (_swapEnable) {
        __autoreleasing UISwipeGestureRecognizer *ges = [[UISwipeGestureRecognizer alloc]
                                                         initWithTarget:self
                                                         action:@selector(dismiss)];
        ges.direction = UISwipeGestureRecognizerDirectionRight;
        
        
        if (_autoSwapGestureRecognizer) {
            [[self navigationView] removeGestureRecognizer:originS];
            [self addGestureRecognizer:ges];
        }else{
            [self  removeGestureRecognizer:originS];
            [[self navigationView] addGestureRecognizer:ges];
        }
        originS = ges;
        ges = nil;
    }
}
#pragma mark - navogation
- (void)presentOnView:(__weak UIView*)handler
{
    [self presentOnView:handler withAnimation:_animation];
}
- (void)presentOnView:(__weak UIView*)handler withAnimation:(BOOL)animation
{
    if (!handler)return;
    //begin
    if (_willShowHandler) {
        _willShowHandler(self);
    }
    
    if (((CFiPhoneSuperView*)self.preView).willDismissHandler) {
        ((CFiPhoneSuperView*)self.preView).willDismissHandler(self.preView);
    }
    
    //move
    _animation = animation;
    _preView = handler;
    ((CFiPhoneSuperView*)handler).nextView = self;
    
    UIView *pview = [(CFViewController*)[CFViewController shareMainViewController] view];
    CGPoint oldP = handler.origin;
    //add
    [pview addSubview:self];
    //add back button
    [[self navigationView] addSubview:[self leftBarButton]];
    CGRect frmae_o = [self fetchBounds];
    switch (_transitionInStyle) {
        case CFTransitionStyleSlideFromRight:
            self.origin = CGPointMake(oldP.x + CGRectGetWidth(frmae_o),  self.origin.y);
            [self animationOrigin:oldP show:true];
            break;
        case CFTransitionStyleSlideFromBottom:
            self.origin = CGPointMake(oldP.x,  self.origin.y + CGRectGetHeight(frmae_o));
            [self animationOrigin:oldP show:true];
            break;
        case CFTransitionStyleSlideFromTop:
            self.origin = CGPointMake(oldP.x,  self.origin.y - CGRectGetHeight(frmae_o));
            [self animationOrigin:oldP show:true];
            break;
        case CFTransitionStyleSlideFromLeft:
            self.origin = CGPointMake(oldP.x - CGRectGetWidth(frmae_o),  self.origin.y);
            [self animationOrigin:oldP show:true];
            break;
        case CFTransitionStyleFade:
            [self animationFadeWithShow:true];
            break;
        case CFTransitionStyleBounce:
            [self animationBounceWithShow:true];
            break;
        case CFTransitionStyleDropDown:
            [self animationDropDwonWithShow:true];
            break;
        default:
            break;
    }
}
- (void)dismiss
{
    [self dismissWithAnimation:_animation];
}
- (void)dismissWithAnimation:(BOOL)animation
{
    if (!self.preView) return;
    //begin
    if (self.willDismissHandler) {
        self.willDismissHandler(self);
    }
    
    if (((CFiPhoneSuperView*)self.preView).willShowHandler) {
        ((CFiPhoneSuperView*)self.preView).willShowHandler(self.preView);
    }
    
    //move
    _animation = animation;
    CGPoint oldP = CGPointZero;
    CGRect frmae_o = [self fetchBounds];
    switch (_transitionOutStyle) {
        case CFTransitionStyleSlideFromRight:
            oldP = CGPointMake(self.origin.x + CGRectGetWidth(frmae_o),  self.origin.y);
            [self animationOrigin:oldP show:false];
            break;
        case CFTransitionStyleSlideFromBottom:
            oldP = CGPointMake(self.origin.x,  self.origin.y + CGRectGetHeight(frmae_o));
            [self animationOrigin:oldP show:false];
            break;
        case CFTransitionStyleSlideFromTop:
            oldP = CGPointMake(self.origin.x,  self.origin.y - CGRectGetHeight(frmae_o));
            [self animationOrigin:oldP show:false];
            break;
        case CFTransitionStyleSlideFromLeft:
            oldP = CGPointMake(self.origin.x - CGRectGetWidth(frmae_o),  self.origin.y);
            [self animationOrigin:oldP show:false];
            break;
        case CFTransitionStyleFade:
            [self animationFadeWithShow:false];
            break;
        case CFTransitionStyleBounce:
            [self animationBounceWithShow:false];
            break;
        case CFTransitionStyleDropDown:
            [self animationDropDwonWithShow:false];
            break;
        default:
            break;
    }
}

- (void)deallocc
{
    [_navigationSepreatorView removeFromSuperview];
    _navigationSepreatorView = NULL;
    
    [_navigationBackImageView removeFromSuperview];
    _navigationBackImageView = NULL;
    
    [_titleImageView removeFromSuperview];
    _titleImageView = NULL;
    
    [_titleLable removeFromSuperview];
    _titleLable = NULL;
    
    [self.navigationView removeFromSuperview];
    self.navigationView = nil;
    _navigationView = NULL;
    
    self.navigationColor = nil;
    _navigationColor = NULL;

    [self.preView removeFromSuperview];
    self.preView = nil;
        _preView = NULL;
    
    [self.nextView removeFromSuperview];
    self.nextView = nil;
        _nextView = NULL;

    self.navigationSepreatorColor = nil;
        _navigationSepreatorColor = NULL;

    self.title = nil;
        _title = NULL;

    self.titleColor = nil;
        _titleColor = NULL;

    self.titleImage = nil;
        _titleImage = NULL;

    self.navigationBackImage = nil;
        _navigationBackImage = NULL;
    
    [self.bottomView removeFromSuperview];
    self.bottomView=nil;
    _bottomView = NULL;
    
    [self.leftBarButton removeFromSuperview];
    self.leftBarButton = nil;
    _leftBarButton = NULL;
    
    [self.rightBarButton removeFromSuperview];
    self.rightBarButton = nil;
    _rightBarButton = NULL;
    
    [self.contentView removeFromSuperview];
    self.contentView = nil;
    _contentView = NULL;
    
    self.willShowHandler=nil;
    _willShowHandler = NULL;
    
    self.didShowHandler=nil;
    _didShowHandler = NULL;
    
    self.willDismissHandler=nil;
    _willDismissHandler = NULL;
    
    self.didDismissHandler=nil;
    _didDismissHandler = NULL;
    
    self.didRemoveHandle = nil;
    _didRemoveHandle = NULL;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NEED_REFRANSH_USERINFO object:NULL];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillChangeStatusBarOrientationNotification object:NULL];
}

@end
