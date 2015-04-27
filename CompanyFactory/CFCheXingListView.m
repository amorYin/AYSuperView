//
//  CFCheXingListView.m
//  CompanyFactory
//
//  Created by amor on 14/8/18.
//  Copyright (c) 2014年 AmorYin. All rights reserved.
//

#import "CFCheXingListView.h"

@interface CFChexingView1 :UIButton
@property(nonatomic,strong,readonly)UILabel *showLable;
@property(nonatomic,strong,readonly)UIImageView *showImg;
- (void)setTitle:(NSString *)title withFont:(UIFont*)font;
- (void)setImage:(UIImage *)image;
- (NSString*)title;
@end
@implementation CFChexingView1
@synthesize showLable=_showLable;
@synthesize showImg=_showImg;

- (UILabel*)showLable
{
    if (!_showLable) {
        _showLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height-27, self.frame.size.width, 27)];
        _showLable.backgroundColor = [UIColor clearColor];
        _showLable.textColor = RGBA(0, 0, 0, 1.);
        _showLable.textAlignment = NSTextAlignmentCenter;
        _showLable.font = FZDTitleFontSize(14.);
        _showLable.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        if (DEVICE_VERSION_GREATER_THAN_OR_EQUAL_TO_iPhone_5) {
            _showLable.shadowColor = RGBA(240, 240, 240, 1.);
        }
        //        _showLable.backgroundColor = RGBA(10, 10, 10, 0.3);
        [self addSubview:_showLable];
    }
    return _showLable;
}

- (UIImageView*)showImg
{
    if (!_showImg) {
        _showImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-27)];
        _showImg.backgroundColor = FZDNavigationColor;
        [self addSubview:_showImg];
    }
    return _showImg;
}
- (void)setTitle:(NSString *)title withFont:(UIFont*)font
{
    self.showLable.text = title;
}

- (void)setImage:(UIImage *)image
{
    self.showImg.image = image;
}
- (NSString*)title
{
    return _showLable.text;
}

- (void)dealloc
{
    _showLable = nil;
    _showImg = nil;
}
@end

@interface CFCheXingListView()
@end

@implementation CFCheXingListView

- (void)setupUI
{
    [super setupUI];
    self.didShowHandler = ^(UIView *view){
        //初始化数据
        if (((CFCheXingListView*)view).dataBase.count<1) {
            [((CFCheXingListView*)view).refreshHeader beginRefreshing];
        }
    };
}

#pragma mark - 
- (void)loadAllView
{
    CGFloat pading = 5;
    CGFloat widthb = (CGRectGetWidth(self.frame)-pading*3)*0.5;
    CGFloat marginx = CGRectGetWidth(self.frame)-(pading+widthb);
    for (int i =0; i<self.dataBase.count; i++) {
        NSDictionary *dic = (NSDictionary*)[self.dataBase objectAtIndex:i];

        __autoreleasing CFChexingView1 *uibutn = [[CFChexingView1 alloc] initWithFrame:CGRectMake((i+1)%2*pading+i%2*marginx, i/2*(132+pading)+pading, widthb, 132)];

        uibutn.layer.borderWidth = 0.5;
        uibutn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [uibutn setTag:i+100];
        [uibutn addTarget:self action:@selector(addView:) forControlEvents:UIControlEventTouchUpInside];
        [uibutn setTitle:[dic objectForKey:@"modelname"] withFont:FZFont(16.)];
        [self addMySubview:uibutn];
        uibutn = nil;
    }
    CGSize m = self.contentView.contentSize;
    self.contentView.contentSize = CGSizeMake(m.width, m.height+5);
}

- (void)addView:(CFChexingView1*)btn
{

}

#pragma mark
#pragma mark -  CFiPhoneRefreshViewMethod
- (void)reloadPage:(NSString*)page withRefresh:(MJRefreshBaseView*)refreshView
{
    NSArray *arr = @[@{@"modelname":@"测试"},@{@"modelname":@"测试"},@{@"modelname":@"测试"},@{@"modelname":@"测试"},@{@"modelname":@"测试"},@{@"modelname":@"测试"},@{@"modelname":@"测试"}];
    [self setData:arr withRefrsh:refreshView];
    
}
- (void)setData:(NSArray*)data withRefrsh:(MJRefreshBaseView *)refreshView
{
    [super setData:data withRefrsh:refreshView];
    [self loadAllView];
}
- (void)deallocc
{
    [super deallocc];
}
@end
