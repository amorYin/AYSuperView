//
//  CFiPhoneRefreshView.m
//  CompanyFactory
//
//  Created by AmorYin on 14-5-6.
//  Copyright (c) 2014年 AmorYin. All rights reserved.
//

#import "CFiPhoneRefreshView.h"

@interface CFiPhoneRefreshView()<MJRefreshBaseViewDelegate>
{
    BOOL             pageMore;
    int               perPage;
    int           currentPage;
    NSRecursiveLock *dataLock;
}
@end
@implementation CFiPhoneRefreshView

- (void)setupUI
{
    [super setupUI];
    //default
    pageMore = YES;
    perPage  = 6;
    currentPage = 1;
    dataLock = [[NSRecursiveLock alloc] init];
    
    if (!_refreshHeader) {
        // 下拉刷新
        MJRefreshHeaderView *header = [MJRefreshHeaderView header];
        header.scrollView = [self contentView];
        header.delegate = self;
        _refreshHeader = header;
    }

    if (!_refreshFooter) {
        //上拉加载更多
        MJRefreshFooterView *footer = [MJRefreshFooterView footer];
        footer.scrollView =[self contentView];
        footer.delegate = self;
        _refreshFooter= footer;
        _refreshFooter.hidden = YES;
    }
    
    if (!_dataBase) {
        _dataBase = [NSMutableArray arrayWithCapacity:0];
    }
    
//    [self showNONview];
}
/**
 *  设置翻页一页有到少数据
 *
 *  @param page
 */
- (void)setPerPage:(int)page
{
    perPage = page;
    pageMore = YES;
    currentPage =1;
}

/**
 *  设置如果没有数据
 *  展示提示页面
 */
- (void)showNONview
{
    if (self.dataBase.count<1) {
        if (!_nonView) {
            __autoreleasing UIView *non = [[UIView alloc] initWithFrame:self.contentView.bounds];
            _nonView = non;
            non.backgroundColor = [UIColor clearColor];
            [self.contentView addSubview:non];
            
            __autoreleasing UILabel *lal = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView.width*0.5-25, 150, 50, 50)];
            lal.text = @"!";
            lal.font = FZDTextFontSize(52.);
            lal.backgroundColor = [UIColor clearColor];
            lal.textColor = FZDNavigationTitleColor;
            lal.textAlignment = NSTextAlignmentCenter;
            [_nonView addSubview:lal];
            
            __autoreleasing UILabel *lal1 = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView.width*0.5-100, 205, 200, 24)];
            lal1.text = @"暂时没有数据";
            lal1.font = FZDTextFontSize(22.);
            lal1.backgroundColor = [UIColor clearColor];
            lal1.textColor = FZDNavigationTitleColor;
            lal1.textAlignment = NSTextAlignmentCenter;
            [_nonView addSubview:lal1];
        }
        [self.contentView sendSubviewToBack:_nonView];
    }else{
        [_nonView removeFromSuperview];
    }
}

// 开始进入刷新状态就会调用
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([self respondsToSelector:@selector(reloadPage:withRefresh:)]) {
        if ([refreshView isEqual:_refreshHeader]) {
            __autoreleasing NSString *page = @"1";
            [self performSelector:@selector(reloadPage:withRefresh:) withObject:page withObject:refreshView];
            page = nil;
        }else{
            __autoreleasing NSString *page = [NSString stringWithFormat:@"%d",currentPage];
            [self performSelector:@selector(reloadPage:withRefresh:) withObject:page withObject:refreshView];
            page = nil;
        }
    }
    NSLog(@"请求第%d页数据",currentPage);
}
// 刷新完毕就会调用
- (void)refreshViewEndRefreshing:(MJRefreshBaseView *)refreshView
{
    
}
// 刷新状态变更就会调用
- (void)refreshView:(MJRefreshBaseView *)refreshView stateChange:(MJRefreshState)state
{
    
}

- (void)setData:(NSArray*)data withRefrsh:(MJRefreshBaseView *)refreshView
{
    if (_isAddFromBottom) {
        //在这里没有页数，只有添加的位置，从哪里添加的，刷新所有界面的唯一办法就是重新刷新界面
        if (data.count>0) {
            if ([refreshView isEqual:_refreshHeader]) {
                [dataLock lock];
                [_dataBase insertObjects:data atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, data.count)]];
                [dataLock unlock];
            }else{
                [dataLock unlock];
                [dataLock lock];
                [_dataBase addObjectsFromArray:data];
                [dataLock unlock];
            }
        }
    }else{
        //获取到数据
        if ([refreshView isEqual:_refreshHeader]) {
            if (data.count>0) {
                currentPage = 0;
                [dataLock lock];
                [_dataBase removeAllObjects];
                [dataLock unlock];
                [dataLock lock];
                [_dataBase addObjectsFromArray:data];
                [dataLock unlock];
            }
        }else{
            if (data.count<1) {
                
            }else if(data.count==perPage){
                currentPage ++;
                [dataLock lock];
                [_dataBase addObjectsFromArray:data];
                [dataLock unlock];
            }else{
                int repeateCount = _dataBase.count%perPage;
                [dataLock lock];
                _refreshFooter.hidden = NO;
                while (repeateCount>0) {
                    [_dataBase removeLastObject];
                    repeateCount--;
                    _refreshFooter.hidden = YES;
                }
                [dataLock unlock];
                [dataLock lock];
                NSLog(@"--%ld",(unsigned long)self.dataBase.count);
                [_dataBase addObjectsFromArray:data];
                [dataLock unlock];
            }
        }
    }

    data = nil;
    [refreshView endRefreshing];
    [self showNONview];
}

- (void)deallocc
{
    dataLock= nil;
    self.dataBase = nil;
    _dataBase = NULL;
    [self.refreshHeader free];
    _refreshHeader = NULL;
    [self.refreshFooter free];
    _refreshFooter = NULL;
    [super deallocc];
}
@end
