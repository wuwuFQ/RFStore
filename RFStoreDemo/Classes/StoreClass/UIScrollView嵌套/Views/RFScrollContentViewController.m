//
//  RFScrollContentViewController.m
//  BC_ConvenientTravel
//
//  Created by 便便出行 on 2019/1/12.
//  Copyright © 2019 Triple_L. All rights reserved.
//

#import "RFScrollContentViewController.h"



@interface RFScrollContentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign) BOOL vcCanScroll;
@property (nonatomic, strong) UITableView *tableView;

/** 是否用户操作亦或是惯性 */
@property (nonatomic, assign) BOOL fingerIsTouch;

//数据
@property (strong, nonatomic) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger pageIndex;
@end

@implementation RFScrollContentViewController
-(NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(childViewCanScroll:) name:@"childViewCanScroll" object:nil];
    
    self.view.backgroundColor = white_Color;
    
    self.vcCanScroll = YES;//第一次初始化可以滑动，因为这之前你收不到任何通知
    
    self.pageIndex = 1;
    
    [self setupSubViews];
    
    [self loadData];
}

-(void)loadData {
    if (self.pageIndex == 1) {
        [self.dataArray removeAllObjects];
    }
    
    
    for (int i = 0; i < 2; i++) {
        InformationModel *model_1 = [InformationModel new];
        model_1.title = @"资讯title";
        model_1.corporateName = @"谈笑风生";
        model_1.modelName = @"若我于你有帮助，请你帮助其他人";
        model_1.image = @[@"http://b-ssl.duitang.com/uploads/item/201701/20/20170120183149_FJ34B.png", @"http://img5.duitang.com/uploads/blog/201308/10/20130810191015_PjnNw.thumb.224_0.jpeg", @"http://img4.duitang.com/uploads/item/201305/29/20130529050226_JiNNN.thumb.224_0.jpeg"];
        InformationModel *model_2 = [InformationModel new];
        model_2.title = @"新闻资讯：这里做了UITableViewCell高度自适应，可以根据自己的需求调整，哼哼哼~~~";
        model_2.corporateName = @"作客他乡";
        model_2.modelName = @"若我于你有帮助，请你帮助其他人";
        model_2.image = @[@"http://cdn.duitang.com/uploads/item/201609/30/20160930193329_jNUc5.png", @"http://img4q.duitang.com/uploads/item/201506/01/20150601192408_dAEBi.jpeg"];
        [self.dataArray addObject:model_1];
        [self.dataArray addObject:model_2];
    }
    
    //模拟加载延迟...
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                       [self.tableView reloadData];
                       [self.tableView.mj_footer endRefreshing];
                       
                   });
    
}



- (void)setupSubViews
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KWidthScreen, KHeightScreen -NavigationHieght -40) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (@available(iOS 11.0, *)) {
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight=0;
        self.tableView.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
        
    }
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.pageIndex++;
        [self loadData];
    }];

 
}
#pragma mark UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InformationListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([InformationListCell class])];
    if (!cell) {
        cell = [[InformationListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([InformationListCell class])];
    }
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    InformationModel *model = self.dataArray[indexPath.row];
    
    // 推荐使用此普通简化版方法（一步设置搞定高度自适应，性能好，易用性好）
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[InformationListCell class] contentViewWidth:KWidthScreen];
}







#pragma mark UIScrollView
//判断屏幕触碰状态
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    NSLog(@"接触屏幕");
    self.fingerIsTouch = YES;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
//    NSLog(@"离开屏幕");
    self.fingerIsTouch = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.vcCanScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    if (scrollView.contentOffset.y <= 0) {
        //        if (!self.fingerIsTouch) {//这里的作用是在手指离开屏幕后也不让显示主视图，具体可以自己看看效果
        //            return;
        //        }
        self.vcCanScroll = NO;
        scrollView.contentOffset = CGPointZero;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"leaveTop" object:nil];//到顶通知父视图改变状态
    }
    self.tableView.showsVerticalScrollIndicator = _vcCanScroll?YES:NO;
}
-(void)childViewCanScroll:(NSNotification *)noti {
    NSString *isCanScroll = [noti.userInfo objectForKey:@"isCanScroll"];
    if ( [isCanScroll isEqualToString:@"1"] ) {
        self.vcCanScroll = YES;
    } else {
        self.tableView.contentOffset = CGPointZero;
    }
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
