//
//  CFViewController.h
//  CompanyFactory
//
//  Created by 91aiche on 14-4-12.
//  Copyright (c) 2014年 AmorYin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CFImagePickerControllerBlock) (UIImage *img);
@interface CFViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,copy)CFImagePickerControllerBlock imagePickerSelect;
@property (nonatomic,copy)CFImagePickerControllerBlock imagePickerClosed;
+ (instancetype)shareMainViewController;
@end
