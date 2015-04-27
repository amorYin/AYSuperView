//
//  CFViewController.m
//  CompanyFactory
//
//  Created by 91aiche on 14-4-12.
//  Copyright (c) 2014年 AmorYin. All rights reserved.
//

#import "CFViewController.h"
#import "CFiPadMainView.h"
#import "CFiPhoneMainView.h"
#import "CFiPhoneOnloadView.h"

static CFViewController * deviceManagerInstance=nil;
@interface CFViewController ()
{
    CFiPadMainView *iPadView;
    CFiPhoneMainView *iPhoneView;
    UIImageView    *freshView;
}
@end

@implementation CFViewController
+ (instancetype)allocWithZone:(NSZone *)zone;
{
    if(deviceManagerInstance==nil)
    {
        deviceManagerInstance=[super allocWithZone:zone];
    }
    return deviceManagerInstance;
}
-(instancetype)copyWithZone:(NSZone *)zone
{
    return deviceManagerInstance;
}
- (instancetype)init
{
    @synchronized(deviceManagerInstance) {
        if (!deviceManagerInstance) {
            return [CFViewController shareMainViewController];
        }
        return deviceManagerInstance;
    }
}

+ (instancetype)shareMainViewController
{
    @synchronized(self){
        deviceManagerInstance = [[[self class] alloc] init];
    }
    return deviceManagerInstance;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        if (!iPadView) {
            iPadView = [[CFiPadMainView alloc] initWithFrame:self.view.bounds];
        }
        [self.view addSubview:iPadView];
    }else{
        if (!iPhoneView) {
            iPhoneView = [[CFiPhoneMainView alloc] initWithFrame:self.view.bounds];
        }
        [self.view addSubview:iPhoneView];

        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(loadViewNoti:)
                                                     name:NEED_LOAD_USERINFO
                                                   object:nil];
        
        [self showOnLoadView];

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - need load
- (void)loadViewNoti:(NSNotification*)noti
{
    [self showOnLoadView];
}
- (void)showOnLoadView
{
    __autoreleasing CFiPhoneOnloadView *newView = [[CFiPhoneOnloadView alloc] initWithFrame:iPhoneView.bounds];
    newView.transitionInStyle = CFTransitionStyleSlideFromBottom;
    newView.transitionOutStyle = CFTransitionStyleSlideFromBottom;
    newView.swapEnable = false;
    newView.didRemoveHandle = ^(UIView *view){
        NSLog(@"执行的事3");
        if (iPadView) {
            
        }else if(iPhoneView){
            //检查更新
            [self checkVersion:nil];
        }else{
            
        }
    };
    [newView presentOnView:iPhoneView withAnimation:YES];
    newView.title = @"登录";
    newView = nil;
}
#pragma mark - cover imageview

- (void)setupCoverImge
{
    //查询目前是否可以展示动画
    [self showCoverImageView];
}

- (void)showCoverImageView
{
    //查询图片是否存在
    __block UIImage *image = nil;
    //不存在返回
    if (!image){
        NSLog(@"执行的事2");
        if (iPadView) {
    
        }else if(iPhoneView){
            //检查更新
            [self checkVersion:nil];
        }else{
            
        }
        return;
    }else{
        //添加动画
        if (!freshView) {
            __autoreleasing UIImageView *img = [[UIImageView alloc] initWithFrame:self.view.bounds];
            freshView = img;
            freshView.userInteractionEnabled = YES;
            freshView.multipleTouchEnabled = YES;
            freshView.contentMode = UIViewContentModeScaleToFill;
            [self.view addSubview:img];
        }
        //设置图片
        freshView.image = image;
        //延迟隐藏
        [self performSelector:@selector(removeCoverView)
                   withObject:nil afterDelay:6.];
    }
}
#pragma mark - cover animation
- (void)removeCoverView
{
    if (freshView) {
        CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
        opacityAnimation.toValue = [NSNumber numberWithFloat:0];
        
        CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        rotateAnimation.fromValue = [NSNumber numberWithFloat:1.0];
        rotateAnimation.toValue = [NSNumber numberWithFloat:2.0];
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.beginTime = CACurrentMediaTime();
        group.duration = 2.;
        group.animations = [NSArray arrayWithObjects:opacityAnimation,rotateAnimation,nil];
        group.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        group.delegate = self;
        group.fillMode = kCAFillModeForwards;
        group.removedOnCompletion = NO;
        group.autoreverses= NO;
        [freshView.layer addAnimation:group forKey:@"opacity"];
    }
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (freshView&&flag) {
        [freshView removeFromSuperview];
        freshView = nil;
        NSLog(@"执行的事1");
        if (iPadView) {
            
        }else if(iPhoneView){
            
            //检查更新
            [self checkVersion:nil];
        }else{
            
        }
    }
}
#pragma mark -下载闪屏动画
//开始下载动画
- (void)downloadFlashView
{

}
#pragma mark --
- (BOOL)supportedInterfaceeStatusBarFrame
{
    return YES;
}

#pragma mark-- 检测更新

#pragma mark - UIImagePickerController
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    [self write:image];
    if (_imagePickerSelect) {
        _imagePickerSelect(image);
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    [self write:img];
    if (_imagePickerSelect) {
        _imagePickerSelect(img);
    }
    
    [picker dismissViewControllerAnimated:YES completion:^(void){
        if (_imagePickerClosed) {
            _imagePickerClosed(nil);
        }
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^(void){
        if (_imagePickerClosed) {
            _imagePickerClosed(nil);
        }
    }];
}
- (void)write:(UIImage*)img
{
    NSData *imgData = UIImageJPEGRepresentation(img,.6f);
    [imgData writeToFile:HEAD_PAHT atomically:YES];
}

- (void)checkVersion:(id)sender
{

}

- (void)compareVersion
{

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex!=alertView.cancelButtonIndex){
        if (alertView.tag == 1009) {
            NSString *url = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
            NSString *str = [NSString stringWithFormat:@"tel://%@",url];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }else{
            NSString *url = [[NSUserDefaults standardUserDefaults] objectForKey:@"url"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        }
    }
}

@end
