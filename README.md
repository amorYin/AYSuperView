# AYSuperView

AYSuperView是一个基于UIView的切换类，拥有以下特性
1。可定义返回按钮的导航栏
2。底部工具栏
3。内容视图自动调节contentSize
4。多种切换方式
5。支持手机旋转，横屏模式
6。丰富的回调支持，分时加载

使用方便

例如：

__autoreleasing CFiPhoneMainView *newView = [[CFiPhoneMainView alloc] initWithFrame:self.bounds];
newView.transitionInStyle = CFTransitionStyleSlideFromTop;
newView.transitionOutStyle = CFTransitionStyleSlideFromTop;
newView.swapEnable = false;
newView.didRemoveHandle = ^(UIView *view){
    
};
[newView presentOnView:self withAnimation:YES];
newView.title = @"从上方进入";
newView = nil;


可傻瓜式刷新：

__autoreleasing CFCheXingListView *newView = [[CFCheXingListView alloc] initWithFrame:self.bounds];
newView.swapEnable = true;
newView.didRemoveHandle = ^(UIView *view){

};
[newView presentOnView:self withAnimation:YES];
newView.title = @"刷新演示";
newView = nil;


你只需通过 - (void)setPerPage:(int)page; 定义好每页加载的数量，其余一切不用管
实现
- (void)reloadPage:(NSString*)page withRefresh:(MJRefreshBaseView*)refreshView
委托，也可以重载
- (void)setData:(NSArray*)data withRefrsh:(MJRefreshBaseView *)refreshView
来刷新界面


这个项目毕竟是很早之前写的，欢迎大家指正



