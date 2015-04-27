//
//  ActivityIndicatorView.m
//  CompanyFactory
//
//  Created by zww on 15-1-4.
//  Copyright (c) 2015年 AmorYin. All rights reserved.
//

#import "ActivityIndicatorView.h"

@implementation ActivityIndicatorView

- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)aTitle andActivityIndicatorStyle:(UIActivityIndicatorViewStyle)style
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //添加黑色遮罩背景
        self.activityIndicatorViewStyle = style;
        
        UIView * view = [[UIView alloc] initWithFrame:frame];
        view.backgroundColor = [UIColor blackColor];
        view.alpha = .3;
        view.layer.cornerRadius = 10;
        [self addSubview:view];
        [self sendSubviewToBack:view];
        
        CGPoint centerP = CGPointMake(view.bounds.size.width/2, view.bounds.size.height/2-40);
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 25)];
        lab.textColor = [UIColor whiteColor];
        lab.backgroundColor = [UIColor clearColor];
        lab.center = centerP;
        lab.font = [UIFont boldSystemFontOfSize:20.0];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = aTitle;
        [self addSubview:lab];
    }
    return self;
}

@end
