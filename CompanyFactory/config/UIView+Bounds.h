//
//  UIView+Bounds.h
//  aiche
//
//  Created by AmorYin on 13-5-23.
//  Copyright (c) 2013年 AmorYin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Bounds)
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;
@end
