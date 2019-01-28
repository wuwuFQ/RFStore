//
//  RFHomePageViewController.m
//  RFStoreDemo
//
//  Created by 便便出行 on 2019/1/22.
//  Copyright © 2019 bbcx. All rights reserved.
//

#import "RFHomePageViewController.h"

#import "RFBaseScrollView.h"
#import "RFScrollContentViewController.h"

#import "RFStoreListViewController.h"


#define PageViewTop 300

@interface RFHomePageViewController ()<WMPageControllerDelegate, WMPageControllerDataSource, UIScrollViewDelegate>
/** 主视图 */
@property (nonatomic, strong) RFBaseScrollView *mainScrollView;
/** 内容视图 */
@property (nonatomic, strong) UIView *contentView;
/** 是否可以滑动 */
@property (nonatomic, assign) BOOL canScroll;

@property (nonatomic, assign) BOOL changeStatusBarStyle;

@property (nonatomic, strong) NSArray *titles;
@end

@implementation RFHomePageViewController
-(NSArray *)titles{
    if (_titles == nil) {
        _titles = @[@"新闻", @"资讯", @"美食直播", @"广告"];
    }
    return _titles;
}
//...
-(RFBaseScrollView *)mainScrollView{
    if (_mainScrollView == nil) {
        _mainScrollView = [[RFBaseScrollView alloc]initWithFrame:CGRectMake(0, 0, KWidthScreen, KHeightScreen)];
        _mainScrollView.backgroundColor = Background_color;
        _mainScrollView.delegate = self;
        _mainScrollView.bounces = NO;
        [self.view addSubview:_mainScrollView];
    }
    return _mainScrollView;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"商城首页";
    
    //滚动监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollStatus) name:@"leaveTop" object:nil];
    
    [self setupSubViews];
}


-(void)setupSubViews {
    if (@available(iOS 11.0, *)) {
        self.mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.canScroll = YES;
    
    
    self.contentView = [[UIView alloc]initWithFrame:CGRectMake(0, PageViewTop +NavigationHieght, KWidthScreen, KHeightScreen -NavigationHieght)];
    self.contentView.backgroundColor = red_Color;
    [self.mainScrollView addSubview:self.contentView];
    [self.mainScrollView setupAutoContentSizeWithBottomView:self.contentView bottomMargin:0];
    
    
    WMPageController *_pageVC = [[WMPageController alloc]init];
    
    _pageVC.titleColorNormal = UIColorFromHex(0x999999);
    _pageVC.titleColorSelected = Black_text_color;
    _pageVC.titleSizeNormal = 14;
    _pageVC.titleSizeSelected = 14;
    _pageVC.menuViewStyle = WMMenuViewStyleLine;
    _pageVC.menuView.backgroundColor = white_Color;
//    _pageVC.menuViewLayoutMode = WMMenuViewLayoutModeLeft;
    _pageVC.pageAnimatable = YES;
    _pageVC.scrollEnable = YES;
    _pageVC.itemMargin = 20;
    _pageVC.automaticallyCalculatesItemWidths = YES;
    _pageVC.progressColor = main_Color;
    _pageVC.delegate = self;
    _pageVC.dataSource = self;
    [self addChildViewController:_pageVC];
    [self.contentView addSubview:_pageVC.view];
    
    
    
    UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [customButton setTitle:@"去购物" forState:UIControlStateNormal];
    [customButton setTitleColor:white_Color forState:UIControlStateNormal];
    customButton.titleLabel.font = Font(20);
    [customButton addTarget:self action:@selector(goShopping) forControlEvents:UIControlEventTouchUpInside];
    [customButton setBackgroundColor:main_Color];
    [self.mainScrollView addSubview:customButton];
    customButton.sd_layout
    .centerXEqualToView(self.mainScrollView)
    .widthIs(200)
    .heightIs(40)
    .topSpaceToView(self.mainScrollView, 200);
    customButton.sd_cornerRadiusFromHeightRatio = @(.25);

}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return self.titles.count;
}

/**
 *  Return a controller that you wanna to display at index. You can set properties easily if you implement this methods.
 *
 *  @param pageController The parent controller.
 *  @param index          The index of child controller.
 *
 *  @return The instance of a `UIViewController`.
 */
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    
    RFScrollContentViewController *vcClass = [RFScrollContentViewController new];
    vcClass.view.tag = index;
    return vcClass;
}

/**
 *  Each title you wanna show in the `WMMenuView`
 *
 *  @param pageController The parent controller.
 *  @param index          The index of title.
 *
 *  @return A `NSString` value to show at the top of `WMPageController`.
 */
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index{
    
    return self.titles[index];
}
/**
 Implement this datasource method, in order to customize your own contentView's frame
 
 @param pageController The container controller
 @param contentView The contentView, each is the superview of the child controllers
 @return The frame of the contentView
 */
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView{
    return CGRectMake(0, 40, KWidthScreen, KHeightScreen -NavigationHieght -40);
}

/**
 Implement this datasource method, in order to customize your own menuView's frame
 
 @param pageController The container controller
 @param menuView The menuView
 @return The frame of the menuView
 */
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView{
    return CGRectMake(0, 0, KWidthScreen, 40);
}


#pragma mark notify
- (void)changeScrollStatus//改变主视图的状态
{
    self.canScroll = YES;
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.mainScrollView) {
        CGFloat offeetY = scrollView.contentOffset.y;
        NSLog(@"offeetY == %lf", offeetY);
        if (offeetY >= 50) {
            self.mainScrollView.bounces = YES;
            self.changeStatusBarStyle = YES;
            [self setNeedsStatusBarAppearanceUpdate];
            
        } else {
            self.mainScrollView.bounces = NO;
            self.changeStatusBarStyle = NO;
            [self setNeedsStatusBarAppearanceUpdate];
            
        }
        
        CGFloat bottomCellOffset = PageViewTop;//需要悬停的偏移量
        //         NSLog(@"offeetY== %lf \n bottomCellOffset== %lf", offeetY, bottomCellOffset);
        if (scrollView.contentOffset.y >= bottomCellOffset) {
            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
            if (self.canScroll) {
                self.canScroll = NO;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"childViewCanScroll" object:nil userInfo:@{@"isCanScroll" : @"1"}];//通知子视图可以滚了
                
            }
        }else{//往下拉
            if (!self.canScroll) {//子视图没到顶部 没下拉完毕
                scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
            } else {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"childViewCanScroll" object:nil userInfo:@{@"isCanScroll" : @"0"}];//告诉子视图 不能滚了，老实点
            }
        }
        self.mainScrollView.showsVerticalScrollIndicator = _canScroll?YES:NO;
        
        
    }
}
#pragma mark - [self setNeedsStatusBarAppearanceUpdate]给这个方法就能回调到这里
- (UIStatusBarStyle)preferredStatusBarStyle
{
    if (self.changeStatusBarStyle)
    {
        return UIStatusBarStyleDefault;
    }
    else
    {
        return UIStatusBarStyleLightContent;
    }
}


//跳转页面
-(void)goShopping {
    RFStoreListViewController *vc = [RFStoreListViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
