//
//  CFiPadSuperView.m
//  CompanyFactory
//
//  Created by AmorYin on 14-4-12.
//  Copyright (c) 2014年 AmorYin. All rights reserved.
//

#import "CFiPadSuperView.h"
#import "CFViewController.h"

@interface CFiPadSuperView()
{
    UIImageView *_titleImageView;
    UIImageView *_navigationBackImageView;
    UILabel *_titleLable;
    UIView *_navigationSepreatorView;
    BOOL _animation;
    UIInterfaceOrientation orient;
}
@property(nonatomic,strong)UIView *navigationView;
@end
@implementation CFiPadSuperView
@synthesize statusBarHidden=_statusBarHidden;
@synthesize userLoaded=_userLoaded;
@synthesize navigationBarHidden=_navigationBarHidden;
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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _navigationSepreatorColor = FZDNavigationSepColor;
        _titleColor = FZDNavigationTitleColor;
        _navigationColor = FZDNavigationColor;
        _transitionInStyle = CFPadTransitionStyleSlideFromRight;
        _transitionOutStyle = CFPadTransitionStyleSlideFromRight;
        _supportInterface = YES;
        _autoContentSize = YES;
        _duration = [[UIApplication sharedApplication] statusBarOrientationAnimationDuration];
        self.layer.cornerRadius =5.;
        self.backgroundColor = FZDViewBackgroundColor;
        //rigister REFRANSH_LOAD_SUCCESS
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(needFranshUserInfo:)
                                                     name:NEED_REFRANSH_USERINFO
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(supportedInterfaceOrientationsForWindow:)
                                                     name:UIApplicationWillChangeStatusBarOrientationNotification
                                                   object:nil];
        
        [self setupUI];
    }
    return self;
}

- (CGRect)fetchBounds
{
    UIView *pview = [(CFViewController*)[CFViewController shareMainViewController] view];
    return  pview.bounds;
}
- (CGRect)fetchFrame
{
    UIView *pview = [(CFViewController*)[CFViewController shareMainViewController] view];
    return  pview.frame;
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
- (BOOL)isSupportInterface
{
    return _supportInterface;
}
- (BOOL)isAutoContentSize
{
    return _autoContentSize;
}
- (void)setAutoContentSize:(BOOL)autoContentSize
{
    _autoContentSize = autoContentSize;
    [[self contentView] setScrollEnabled:_autoContentSize];
}
- (UIView*)_navigationSepreatorView
{
    if (!_navigationSepreatorView) {
        _navigationSepreatorView = [[UIView alloc]init];
    }
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        _navigationSepreatorView.frame = CGRectMake(0, 64, CGRectGetWidth([self fetchBounds]), 1);
    }else{
        _navigationSepreatorView.frame = CGRectMake(0, 44, CGRectGetWidth([self fetchBounds]), 1);
    }
    _navigationSepreatorView.backgroundColor = _navigationSepreatorColor;
    return _navigationSepreatorView;
}
- (UIImageView*)_navigationBackImageView
{
    if (!_navigationBackImageView) {
        CGRect frame = [[self navigationView] bounds];
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
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
        _titleLable.font =  FZDButtonFont;
        _titleLable.textColor = _titleColor;
        if (DEVICE_VERSION_GREATER_THAN_OR_EQUAL_TO_iPhone_5) {
            _titleLable.shadowColor = RGBA(0, 0, 0, 1.);
            _titleLable.shadowOffset = CGSizeMake(0, 1);
        }
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
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
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
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
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
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
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
            if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
                _contentView.frame = CGRectMake(CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - 65);
            }else{
                _contentView.frame = CGRectMake(CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)- 45);
            }
        }
        _contentView.backgroundColor = self.backgroundColor;
    }
    return _contentView;
}
- (void)setStatusBarHidden:(BOOL)statusBarHidden
{
    
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
    _statusBarHidden = statusBarHidden;
}

- (void)setWantsFullscreen:(BOOL)wantsFullscreen
{
    _wantsFullscreen = wantsFullscreen;
    if (_wantsFullscreen) {
        [[self contentView] setOrigin:CGPointMake(0, 0)];
    }else{
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
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
- (void)setTitle:(NSString *)title
{
    _title = title;
    [self _titleLable].text = _title;
    _title = nil;
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
- (void)setRightBarButton:(UIButton *)rightBarButton
{
    _rightBarButton = rightBarButton;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        _rightBarButton.frame = CGRectMake(CGRectGetWidth([self fetchBounds])-60, 22, 58, 40);
    }else{
        _rightBarButton.frame = CGRectMake(CGRectGetWidth([self fetchBounds])-60, 2, 58, 40);
    }
    [[self navigationView] addSubview:rightBarButton];
    rightBarButton = nil;
}
- (void)addMySubview:(UIView*)view;
{
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
- (void)addMySublayer:(CALayer*)layer
{
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
- (void)resetContentSize
{
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
- (void)setupUI
{
    [self setWantsFullscreen:_wantsFullscreen];
    [self setNavigationBarHidden:_navigationBarHidden];
    [self addSubview:[self contentView]];
}
- (void)dealloc
{
    _navigationSepreatorView = nil;
    _navigationBackImageView = nil;
    _titleImageView = nil;
    _titleLable = nil;
    _navigationView = nil;
    _navigationColor = nil;
    _nextView = nil;
    _preView = nil;
    _navigationSepreatorColor = nil;
    _contentView = nil;
    _title = nil;
    _titleColor = nil;
    _titleImage = nil;
    _navigationBackImage = nil;
    _leftBarButton = nil;
    _rightBarButton = nil;
    [self.layer removeAllAnimations];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NEED_REFRANSH_USERINFO object:NULL];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillChangeStatusBarOrientationNotification object:NULL];
}
#pragma mark -
- (void)viewWilChangeInterfaceOrientation:(UIInterfaceOrientation)orgin
{
    
}
- (void)viewWilChangeInterfaceOr:(UIInterfaceOrientation)orgin
{
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
                    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
                        _contentView.frame = CGRectMake(CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - 65);
                    }else{
                        _contentView.frame = CGRectMake(CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)- 45);
                    }
                }
                
                if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
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
                _titleImageView.frame = _titleLable.bounds;
                _rightBarButton.frame = CGRectMake(CGRectGetWidth(_navigationView.bounds)-60, 22, 58, 40);
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
                    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
                        _contentView.frame = CGRectMake(CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - 65);
                    }else{
                        _contentView.frame = CGRectMake(CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)- 45);
                    }
                }
                
                if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
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
                _titleImageView.frame = _titleLable.bounds;
                _rightBarButton.frame = CGRectMake(CGRectGetWidth(_navigationView.bounds)-60, 22, 58, 40);
            }
        }
            break;
        default:
            break;
    }
    
    [self addSubview:[self contentView]];
    [self addSubview:[self navigationView]];
    orient = orgin;
    [self viewWilChangeInterfaceOrientation:orient];
    [self resetContentSize];
}
- (void)viewWillChangeInterface:(NSNumber*)orginNum
{
    [self viewWilChangeInterfaceOr:[orginNum intValue]];
}
- (void)supportedInterfaceOrientationsForWindow:(NSNotification*)noti
{
    NSNumber *orginNum = (NSNumber*)[[noti userInfo] objectForKey:UIApplicationStatusBarOrientationUserInfoKey];
    [self performSelector:@selector(viewWillChangeInterface:) withObject:orginNum afterDelay:0.];
}
#pragma mark - action
- (void)needFranshUserInfo:(NSNotification*)noti
{
    
}
#pragma mark - animation delegate
- (void)animationDidStart:(CAAnimation *)anim
{
    
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
}
#pragma mark - animation in and out
- (void)animationOrigin:(CGPoint)oldP show:(BOOL)animation
{
    if (animation) {
        if (_animation) {
            //animation
            [UIView animateWithDuration:_duration animations:^{
                self.preView.alpha = 0.0;
                self.preView.layer.transform = CATransform3DMakeScale(0.93,0.93,1.0);
                self.origin = oldP;
            } completion:^(BOOL finished) {
                
                UISwipeGestureRecognizer *ges = [[UISwipeGestureRecognizer alloc]
                                                 initWithTarget:self
                                                 action:@selector(dismiss)];
                [self addGestureRecognizer:ges];
                //noti
                
                //end
                if (self.didShowHandler) {
                    self.didShowHandler(self);
                }
            }];
        }else{
            //animation
            [UIView animateWithDuration:_duration animations:^{
                self.origin = oldP;
            } completion:^(BOOL finished) {
                
                UISwipeGestureRecognizer *ges = [[UISwipeGestureRecognizer alloc]
                                                 initWithTarget:self
                                                 action:@selector(dismiss)];
                [self addGestureRecognizer:ges];
                ges = nil;
                //noti
                
                //end
                if (self.didShowHandler) {
                    self.didShowHandler(self);
                }
            }];
        }
    }else{
        if (_animation) {
            //animation
            [UIView animateWithDuration:_duration animations:^{
                //animation
                self.origin = oldP;
                self.preView.layer.transform = CATransform3DMakeScale(1.0,1.0,1.0);
                self.preView.origin = CGPointZero;
                self.preView.alpha = 1.0;
            } completion:^(BOOL finished) {
                [self.preView.layer removeAllAnimations];
                [self.layer removeAllAnimations];
                [self removeFromSuperview];
                //noti
                
                //end
                if (self.didDismissHandler) {
                    self.didDismissHandler(self);
                }
            }];
        }else{
            //remove
            self.preView.layer.transform = CATransform3DMakeScale(1.0,1.0,1.0);
            [self.preView setFrame:[self fetchFrame]];
            self.preView.alpha = 1.0;
            //animation
            [UIView animateWithDuration:_duration animations:^{
                self.origin = oldP;
            } completion:^(BOOL finished) {
                
                [self.preView.layer removeAllAnimations];
                [self.layer removeAllAnimations];
                [self removeFromSuperview];
                //noti
                
                //end
                if (self.didDismissHandler) {
                    self.didDismissHandler(self);
                }
            }];
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
#pragma mark - navogation
- (void)presentOnView:(UIView*)handler
{
    [self presentOnView:handler withAnimation:_animation];
}
- (void)presentOnView:(UIView*)handler withAnimation:(BOOL)animation
{
    if (!handler)return;
    //begin
    if (self.willShowHandler) {
        self.willShowHandler(self);
    }
    //move
    _animation = animation;
    self.preView = handler;
    UIView *pview = [(CFViewController*)[CFViewController shareMainViewController] view];
    CGPoint oldP = handler.origin;
    //add
    [pview addSubview:self];
    //add back button
    [[self navigationView] addSubview:[self leftBarButton]];
    CGRect frmae_o = [self fetchBounds];
    switch (_transitionInStyle) {
        case CFPadTransitionStyleSlideFromRight:
            self.origin = CGPointMake(oldP.x + CGRectGetWidth(frmae_o),  self.origin.y);
            [self animationOrigin:oldP show:true];
            break;
        case CFPadTransitionStyleSlideFromBottom:
            self.origin = CGPointMake(oldP.x,  self.origin.y + CGRectGetHeight(frmae_o));
            [self animationOrigin:oldP show:true];
            break;
        case CFPadTransitionStyleSlideFromTop:
            self.origin = CGPointMake(oldP.x,  self.origin.y - CGRectGetHeight(frmae_o));
            [self animationOrigin:oldP show:true];
            break;
        case CFPadTransitionStyleSlideFromLeft:
            self.origin = CGPointMake(oldP.x - CGRectGetWidth(frmae_o),  self.origin.y);
            [self animationOrigin:oldP show:true];
            break;
        case CFPadTransitionStyleFade:
            [self animationFadeWithShow:true];
            break;
        case CFPadTransitionStyleBounce:
            [self animationBounceWithShow:true];
            break;
        case CFPadTransitionStyleDropDown:
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
    //move
    _animation = animation;
    CGPoint oldP = CGPointZero;
    CGRect frmae_o = [self fetchBounds];
    switch (_transitionOutStyle) {
        case CFPadTransitionStyleSlideFromRight:
            oldP = CGPointMake(self.origin.x + CGRectGetWidth(frmae_o),  self.origin.y);
            [self animationOrigin:oldP show:false];
            break;
        case CFPadTransitionStyleSlideFromBottom:
            oldP = CGPointMake(self.origin.x,  self.origin.y + CGRectGetHeight(frmae_o));
            [self animationOrigin:oldP show:false];
            break;
        case CFPadTransitionStyleSlideFromTop:
            oldP = CGPointMake(self.origin.x,  self.origin.y - CGRectGetHeight(frmae_o));
            [self animationOrigin:oldP show:false];
            break;
        case CFPadTransitionStyleSlideFromLeft:
            oldP = CGPointMake(self.origin.x - CGRectGetWidth(frmae_o),  self.origin.y);
            [self animationOrigin:oldP show:false];
            break;
        case CFPadTransitionStyleFade:
            [self animationFadeWithShow:false];
            break;
        case CFPadTransitionStyleBounce:
            [self animationBounceWithShow:false];
            break;
        case CFPadTransitionStyleDropDown:
            [self animationDropDwonWithShow:false];
            break;
        default:
            break;
    }
}
@end
