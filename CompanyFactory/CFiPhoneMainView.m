//
//  CFiPadMainView.m
//  CompanyFactory
//
//  Created by AmorYin on 14-4-12.
//  Copyright (c) 2014年 AmorYin. All rights reserved.
//

#import "CFiPhoneMainView.h"
#import "CFCheXingListView.h"

@interface CFiPhoneMainView()
@end
@implementation CFiPhoneMainView
-(void)drawRect:(CGRect)rect
{
    [super setupUI];
    
    CGFloat height = 100.;
    
    UIButton *view = [self getLable:1 withText:@"从右侧进入" placeholder:nil andMethod:@selector(open1) setTag:11];
    view.origin = CGPointMake(0, height-0.5);
    [self addMySubview:view];
    height = CGRectGetMaxY(view.frame);
    
    UIButton *view1 = [self getLable:1 withText:@"从左侧进入" placeholder:nil andMethod:@selector(open2) setTag:11];
    view1.origin = CGPointMake(0, height-0.5);
    [self addMySubview:view1];
    height = CGRectGetMaxY(view1.frame);
    
    UIButton *view2 = [self getLable:1 withText:@"从上方侧进入" placeholder:nil andMethod:@selector(open3) setTag:11];
    view2.origin = CGPointMake(0, height-0.5);
    [self addMySubview:view2];
    height = CGRectGetMaxY(view2.frame);
    
    UIButton *view3 = [self getLable:1 withText:@"开启向右滑动切换" placeholder:nil andMethod:@selector(open4) setTag:11];
    view3.origin = CGPointMake(0, height-0.5);
    [self addMySubview:view3];
    height = CGRectGetMaxY(view3.frame);
    
    UIButton *view4 = [self getLable:1 withText:@"带刷新" placeholder:nil andMethod:@selector(open4) setTag:11];
    view4.origin = CGPointMake(0, height-0.5);
    [self addMySubview:view4];
    height = CGRectGetMaxY(view4.frame);
    
    UIButton *view5 = [self getLable:1 withText:@"禁止切换动画" placeholder:nil andMethod:@selector(open5) setTag:11];
    view5.origin = CGPointMake(0, height-0.5);
    [self addMySubview:view5];
    height = CGRectGetMaxY(view5.frame);
}

- (void)open1
{
    __autoreleasing CFiPhoneMainView *newView = [[CFiPhoneMainView alloc] initWithFrame:self.bounds];
    newView.transitionInStyle = CFTransitionStyleSlideFromRight;
    newView.transitionOutStyle = CFTransitionStyleSlideFromRight;
    newView.swapEnable = false;
    newView.didRemoveHandle = ^(UIView *view){
        NSLog(@"执行的事3");
    };
    [newView presentOnView:self withAnimation:YES];
    newView.title = @"从右侧进入";
    newView = nil;
}

- (void)open2
{
    __autoreleasing CFiPhoneMainView *newView = [[CFiPhoneMainView alloc] initWithFrame:self.bounds];
    newView.transitionInStyle = CFTransitionStyleSlideFromLeft;
    newView.transitionOutStyle = CFTransitionStyleSlideFromLeft;
    newView.swapEnable = false;
    newView.didRemoveHandle = ^(UIView *view){
        NSLog(@"执行的事3");
    };
    [newView presentOnView:self withAnimation:YES];
    newView.title = @"从左侧进入";
    newView = nil;
}

- (void)open3
{
    __autoreleasing CFiPhoneMainView *newView = [[CFiPhoneMainView alloc] initWithFrame:self.bounds];
    newView.transitionInStyle = CFTransitionStyleSlideFromTop;
    newView.transitionOutStyle = CFTransitionStyleSlideFromTop;
    newView.swapEnable = false;
    newView.didRemoveHandle = ^(UIView *view){
        NSLog(@"执行的事3");
    };
    [newView presentOnView:self withAnimation:YES];
    newView.title = @"从上方进入";
    newView = nil;
}

- (void)open4
{
    __autoreleasing CFCheXingListView *newView = [[CFCheXingListView alloc] initWithFrame:self.bounds];
    newView.swapEnable = true;
    newView.didRemoveHandle = ^(UIView *view){
        NSLog(@"执行的事3");
    };
    [newView presentOnView:self withAnimation:YES];
    newView.title = @"刷新演示";
    newView = nil;
}

- (void)open5
{
    __autoreleasing CFCheXingListView *newView = [[CFCheXingListView alloc] initWithFrame:self.bounds];
    newView.swapEnable = false;
    newView.didRemoveHandle = ^(UIView *view){
        NSLog(@"执行的事3");
    };
    [newView presentOnView:self withAnimation:YES];
    newView.title = @"禁止切换动画";
    newView = nil;
}

- (void)addView:(id)sender
{

}

- (UIButton*)getLable:(int)label withText:(NSString*)str placeholder:(NSString*)holder andMethod:(SEL)method setTag:(int)tag
{
    CGSize size;
    CGFloat wi = 90;
    if (str==nil||[str isEqual:[NSNull null]]) {
        size = CGSizeMake(200, 20);
        wi = 320;
    }else{
        size = [str sizeWithFont:FZDTextFontSize(14.) constrainedToSize:CGSizeMake(190, 1000)];
    }
    CGFloat height=size.height;
    if (size.height<16) {
        height = 30;
    }else{
        height = height+12;
    }
    __autoreleasing UIButton *returnView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.width, height+14)];
    returnView.tag = tag;
    
    __autoreleasing UIView *seport1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0.5)];
    seport1.backgroundColor = RGBA(242, 0, 0, 1.);//FZDNavigationColor;
    [returnView addSubview:seport1];
    
    __autoreleasing UIView *seport2 = [[UIView alloc] initWithFrame:CGRectMake(0, height+13.5, self.width, 0.5)];
    seport2.backgroundColor = RGBA(242, 0, 0, 1.);//FZDNavigationColor;
    [returnView addSubview:seport2];
    
    __autoreleasing UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(self.width-50, height*0.5-15, 44, 44)];
    img.image = CFImage(@"返回图标.png");
    img.transform = CGAffineTransformMakeRotation(M_PI);
    img.contentMode = UIViewContentModeCenter;
    [returnView addSubview:img];
    img = nil;
    
    __autoreleasing UILabel *lal = [[UILabel alloc] initWithFrame:CGRectMake(10, 12.345, wi, 20)];
    lal.text = holder;
    lal.font = FZDTextFontSize(14.);
    if (!str) {
        lal.textAlignment = NSTextAlignmentLeft;
    }else{
        lal.textAlignment = NSTextAlignmentRight;
    }
    lal.backgroundColor = [UIColor clearColor];
    [returnView addSubview:lal];
    
    __autoreleasing UILabel *lal1 = [[UILabel alloc] initWithFrame:CGRectMake(100, height*0.5+7-size.height*0.5, size.width, size.height)];
    lal1.text = str;
    lal1.numberOfLines = 0;
    lal1.font = FZDTextFontSize(14.);
    lal1.backgroundColor = [UIColor clearColor];
    lal1.tag = tag;
    [returnView addSubview:lal1];
    
    
    returnView.backgroundColor = [UIColor whiteColor];
    [returnView addTarget:self action:method forControlEvents:UIControlEventTouchUpInside];
    
    return returnView;
}


-(void)selectImage:(NSInteger)currentPage
{
    [self addView:nil];
}

-(void)setSelectIndex:(NSInteger)currentPage
{
    
}
@end
