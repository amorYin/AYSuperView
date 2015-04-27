//
//  CFiPhoneOnloadView.m
//  CompanyFactory
//
//  Created by 91aiche on 14-5-27.
//  Copyright (c) 2014年 AmorYin. All rights reserved.
//

#import "CFiPhoneOnloadView.h"

@interface CFiPhoneOnloadView()<UITextFieldDelegate>
@property (nonatomic,strong)UIView *coverview;
@property (nonatomic,strong)UITextField *account;
@property (nonatomic,strong)UITextField *password;
@end
@implementation CFiPhoneOnloadView

- (void)setupUI
{
    [super setupUI];
    
    self.title = @"登录";
    
    float midx = self.centerX;
    
    if (!_coverview) {
        _coverview = [[UIView alloc] initWithFrame:CGRectMake(0, self.centerY-180, self.width, 360)];
        [self addMySubview:_coverview];
        

        __autoreleasing UIButton *alloc1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 7, 27, 27)];
        [alloc1 setImage:CFImage(@"登录关闭图标.png") forState:UIControlStateNormal];
        [alloc1 setImage:CFImage(@"登录关闭图标-选中.png") forState:UIControlStateHighlighted];
        [alloc1 addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        self.leftBarButton = alloc1;
        alloc1 = nil;
        
        __autoreleasing UIButton *alloc2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 7, 60, 44)];
        [alloc2 setImage:CFImage(@"注册图标.png") forState:UIControlStateNormal];
        [alloc2 setImage:CFImage(@"注册图标-选中.png") forState:UIControlStateHighlighted];
        [alloc2 addTarget:self action:@selector(rigister) forControlEvents:UIControlEventTouchUpInside];
        self.rightBarButton = alloc2;
        alloc2 = nil;
        
        __autoreleasing UIImageView *ingb = [[UIImageView alloc] initWithFrame:CGRectMake(midx-213*0.5, 0, 213, 63+57)];
        [ingb setImage:CFImage(@"LOCIN.png")];
        [_coverview addSubview:ingb];
        
        
        __autoreleasing UIImageView *lodb = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(ingb.frame), CGRectGetMaxY(ingb.frame)+25, 39, 17)];
        [lodb setImage:CFImage(@"登录图.png")];
        [_coverview addSubview:lodb];
        
        __autoreleasing UIImageView *ilodb = [[UIImageView alloc] initWithFrame:CGRectMake(midx-218*0.5, CGRectGetMaxY(lodb.frame)+5, 218, 84)];
        [ilodb setImage:CFImage(@"登录输入框背景.png")];
        [_coverview addSubview:ilodb];
        
        
        
        __autoreleasing UIButton *ipt = [[UIButton alloc] initWithFrame:CGRectMake( CGRectGetMaxX(ilodb.frame)-65, CGRectGetMaxY(ilodb.frame)+5, 65, 25)];
        [ipt setImage:CFImage(@"忘记密码图标.png") forState:UIControlStateNormal];
        [ipt setImage:CFImage(@"忘记密码图标-选中.png") forState:UIControlStateHighlighted];
        [ipt addTarget:self action:@selector(forgetpass) forControlEvents:UIControlEventTouchUpInside];
        [_coverview addSubview:ipt];
        
        
        __autoreleasing UIButton *iLodt = [[UIButton alloc] initWithFrame:CGRectMake(midx-218*0.5, CGRectGetMaxY(ipt.frame)+15, 218, 40)];
        [iLodt setImage:CFImage(@"登录按钮图标.png") forState:UIControlStateNormal];
        [iLodt setImage:CFImage(@"登录按钮图标-选中.png") forState:UIControlStateHighlighted];
        [iLodt addTarget:self action:@selector(loginPhone) forControlEvents:UIControlEventTouchUpInside];
        [_coverview addSubview:iLodt];
        
        //    __autoreleasing UIButton *iSinat = [[UIButton alloc] initWithFrame:CGRectMake(midx-212*0.5, CGRectGetMaxY(iLodt.frame)+15, 212, 50)];
        //    [iSinat setImage:CFImage(@"info/新浪登录按钮图标.png") forState:UIControlStateNormal];
        //    [iSinat setImage:CFImage(@"info/新浪登录按钮图标-选中.png") forState:UIControlStateHighlighted];
        //    [iSinat addTarget:self action:@selector(loginSina) forControlEvents:UIControlEventTouchUpInside];
        //    [self addMySubview:iSinat];
        //    iSinat = nil;
        
        ingb = nil;
        lodb = nil;
        ilodb = nil;
        ipt = nil;
        iLodt = nil;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationDismiss:) name:NEED_DISMISS_VIEW object:nil];
        
        __autoreleasing UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tag];
        tag = nil;
    }
    
    if (!_account) {
        __autoreleasing UITextField *accountf = [[UITextField alloc] initWithFrame:CGRectMake(midx-198*0.5, 97+57+20, 198, 40)];
        _account = accountf;
        accountf.keyboardType = UIKeyboardTypePhonePad;
        accountf.returnKeyType = UIReturnKeyNext;
        accountf.delegate = self;
        accountf.backgroundColor = [UIColor clearColor];
        accountf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [_coverview addSubview:accountf];
        accountf = nil;
    }
    
    if (!_password) {
        __autoreleasing UITextField *accountf = [[UITextField alloc] initWithFrame:CGRectMake(midx-198*0.5, 130+57+20, 198, 40)];
        _password = accountf;
        _password.keyboardType = UIKeyboardTypeNamePhonePad;
        accountf.returnKeyType = UIReturnKeyDone;
        accountf.secureTextEntry = YES;
        accountf.delegate = self;
        accountf.backgroundColor = [UIColor clearColor];
        accountf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [_coverview addSubview:accountf];
        accountf = nil;
    }
}

- (void)rigister
{
    [self tapAction:nil];
    __autoreleasing UIAlertView *ap = [[UIAlertView alloc] initWithTitle:@"提示" message:@"打开注册页面" delegate:nil cancelButtonTitle:@"确定✅" otherButtonTitles: nil];
    [ap show];
}

- (void)forgetpass
{
    [self tapAction:nil];
    
    [self tapAction:nil];
    __autoreleasing UIAlertView *ap = [[UIAlertView alloc] initWithTitle:@"提示" message:@"忘记密码页面" delegate:nil cancelButtonTitle:@"确定✅" otherButtonTitles: nil];
    [ap show];
}

- (void)loginPhone
{
    [self dismiss];
}

- (void)loginSina
{
    [self dismiss];
}

- (void)notificationDismiss:(NSNotification*)notification
{
    NSString *obtin = [notification object];
    if ([obtin isEqual:@"CFiPhoneSuccessView"]) {
        [self dismiss];
    }
}

- (void)tapAction:(UITapGestureRecognizer*)ges
{
    [_account resignFirstResponder];
    [_password resignFirstResponder];
}

#pragma mark - 
#pragma mark uitextfeilddelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSTimeInterval duration = [[UIApplication sharedApplication] statusBarOrientationAnimationDuration];
    if ([textField isEqual:_account]) {
        [UIView animateWithDuration:duration animations:^{
            _coverview.origin = CGPointMake(0, self.centerY-200-57-20);
        } completion:^(BOOL finished) {}];
    }else{
        [UIView animateWithDuration:duration animations:^{
            _coverview.origin = CGPointMake(0, self.centerY-230-57-20);
        } completion:^(BOOL finished) {}];
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqual:@"\n"]) {
        return  [textField resignFirstResponder];
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSTimeInterval duration = [[UIApplication sharedApplication] statusBarOrientationAnimationDuration];
    [UIView animateWithDuration:duration animations:^{
        _coverview.origin = CGPointMake(0, self.centerY-180);
    } completion:^(BOOL finished) {}];
}
- (void)deallocc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NEED_DISMISS_VIEW object:nil];
    [super deallocc];
}

@end
