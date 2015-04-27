//
//  CFiPhoneRefreshView.h
//  CompanyFactory
//
//  Created by AmorYin on 14-5-6.
//  Copyright (c) 2014年 AmorYin. All rights reserved.
//

#import "CFiPhoneSuperView.h"
#import "MJRefresh.h"
@protocol CFiPhoneRefreshViewMethod<NSObject>
- (void)reloadPage:(NSString*)page withRefresh:(MJRefreshBaseView*)refreshView;
@end
@interface CFiPhoneRefreshView : CFiPhoneSuperView
@property(nonatomic,weak)MJRefreshHeaderView *refreshHeader;
@property(nonatomic,weak)MJRefreshFooterView *refreshFooter;
@property(nonatomic,weak)UIView              *nonView;
@property(nonatomic,assign)BOOL isAddFromBottom;
@property(nonatomic,strong)NSMutableArray *dataBase;
- (void)setPerPage:(int)page;
- (void)setData:(NSArray*)data withRefrsh:(MJRefreshBaseView *)refreshView;
/**
 * 可重写来覆盖这个方法
 */
- (void)showNONview;
@end
