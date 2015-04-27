//
//  CFiPadMainView.m
//  CompanyFactory
//
//  Created by AmorYin on 14-4-12.
//  Copyright (c) 2014年 AmorYin. All rights reserved.
//

#import "CFiPadMainView.h"

@interface CFiPadMainView()
@end
@implementation CFiPadMainView
-(void)drawRect:(CGRect)rect
{
    [super setupUI];
}

- (void)addView:(id)sender
{
    CFiPadMainView *newView = [[CFiPadMainView alloc] initWithFrame:self.bounds];
    [newView presentOnView:self withAnimation:YES];
    newView.title = @"测试界面";
    
    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 100, 20)];
    la.text = @"测试位置";
    [newView addMySubview:la];
    newView= nil;
    la = nil;
}

-(void)selectImage:(NSInteger)currentPage
{
    [self addView:nil];
}

-(void)setSelectIndex:(NSInteger)currentPage
{
    
}
@end
