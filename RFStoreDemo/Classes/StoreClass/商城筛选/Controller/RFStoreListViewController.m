//
//  RFStoreListViewController.m
//  RFStoreDemo
//
//  Created by 便便出行 on 2019/1/23.
//  Copyright © 2019 bbcx. All rights reserved.
//

#import "RFStoreListViewController.h"

#import "RFSiftShoppingView.h"//筛选View
#import "InformationListCell.h"

@interface RFStoreListViewController ()<UITableViewDelegate, UITableViewDataSource, RFSiftShoppingViewDelegate>
@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;

@property (nonatomic, strong) RFSiftShoppingView *siftView;
@property (nonatomic, assign) NSInteger rfStyle;


@property (nonatomic, copy) NSArray *buttonArray;
@property (nonatomic, strong) UIButton *button_1;
@property (nonatomic, strong) UIButton *button_2;
@property (nonatomic, strong) UIButton *button_3;


@property (nonatomic, copy) NSString *listStr;
@property (nonatomic, copy) NSString *carStr;
@property (nonatomic, copy) NSString *priceStr;
@property (nonatomic, copy) NSString *speedStr;
@property (nonatomic, copy) NSString *displacementStr;
@property (nonatomic, copy) NSString *energystr;
@property (nonatomic, copy) NSString *intakeStr;

/** 选择更多 的 所有条件 */
@property (nonatomic, strong) NSMutableArray *conditionArray;

@end

@implementation RFStoreListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = white_Color;
    
    self.rfStyle = -1;
    
    self.listStr = @"智能排序";
    self.carStr = @"";
    self.priceStr = @"";
    self.speedStr = @"";
    self.displacementStr = @"";
    self.energystr = @"";
    self.intakeStr = @"";

    
    [self initSubViews];
}


-(void)loadData {
    self.conditionArray = [NSMutableArray array];
    
    if (!KStringIsEmpty(self.priceStr)) {
        [self.conditionArray addObject:self.priceStr];
    }
    if (!KStringIsEmpty(self.speedStr)) {
        [self.conditionArray addObject:self.speedStr];
    }
    if (!KStringIsEmpty(self.displacementStr)) {
        [self.conditionArray addObject:self.displacementStr];
    }
    if (!KStringIsEmpty(self.energystr)) {
        [self.conditionArray addObject:self.energystr];
    }
    if (!KStringIsEmpty(self.intakeStr)) {
        [self.conditionArray addObject:self.intakeStr];
    }
    
    
    
    NSString *type;// 1：智能排序   2:价格最低  3:价格最高
    if ([self.listStr isEqualToString:@"价格最低"]) {
        type = @"2";
    } else if ([self.listStr isEqualToString:@"价格最高"]) {
        type = @"3";
    } else {
        type = @"1";
    }
    NSDictionary *parame = @{@"type" : type,
                             @"rank" : self.carStr,
                             @"guidePrice" : self.priceStr,
                             @"gearbox" : self.self.speedStr,
                             @"displacementL" : self.displacementStr,
                             @"energyTypes" : self.energystr,
                             @"airIntakeForm" : self.intakeStr
                             };
    NSLog(@"%@", parame);
    //在这里进行网络请求，刷新数据
    
    
    self.dataArray = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
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
    [self.tableView reloadData];
}

-(void)initSubViews {
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, NavigationHieght, KWidthScreen, 120)];
    self.headerView.backgroundColor = white_Color;
    [self.view addSubview:self.headerView];
    
    UIButton *searchBar = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBar.frame = CGRectMake(15, 10, KWidthScreen -30, 30);
    [searchBar setBackgroundColor:UIColorFromHex(0xF0F1F2)];
    [searchBar setImage:ImageNamed(@"HomePage_navi_search") forState:UIControlStateNormal];
    [searchBar setTitle:@"请输入品牌和车型" forState:UIControlStateNormal];
    searchBar.titleLabel.font = Font(14);
    [searchBar setTitleColor:LightGray_text_color forState:UIControlStateNormal];
    searchBar.adjustsImageWhenHighlighted = NO;
    searchBar.layer.cornerRadius = 15;
//    [searchBar addTarget:self action:@selector(searchBarClick) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:searchBar];
    searchBar.imageView.sd_layout
    .widthIs(searchBar.imageView.width)
    .heightIs(searchBar.imageView.height)
    .rightSpaceToView(searchBar.titleLabel, 8)
    .centerYEqualToView(searchBar);
    
    //
    NSArray *buttons = @[@"智能排序", @"车型", @"更多"];
    for (int i = 0; i < buttons.count; i++) {
        UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
        customButton.frame = CGRectMake(0, 0, 100, 40);
        [self.headerView addSubview:customButton];
        [customButton setBackgroundColor:white_Color];
        [customButton setTitle:buttons[i] forState:UIControlStateNormal];
        [customButton setTitleColor:Black_text_color forState:UIControlStateNormal];
        [customButton setImage:ImageNamed(@"Arrow_bottom_black") forState:UIControlStateNormal];
        customButton.titleLabel.font = Font(14);
        customButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        customButton.tag = i;
        [customButton addTarget:self action:@selector(selectSort:) forControlEvents:UIControlEventTouchUpInside];
        switch (i) {
            case 0:
                self.button_1 = customButton;
                break;
            case 1:
                self.button_2 = customButton;
                break;
            case 2:
                self.button_3 = customButton;
                break;
       
                
            default:
                break;
        }
        customButton.imageView.sd_layout
        .widthIs(customButton.imageView.width)
        .heightIs(customButton.imageView.height)
        .rightEqualToView(customButton)
        .centerYEqualToView(customButton);
        customButton.titleLabel.sd_layout
        .leftEqualToView(customButton)
        .rightSpaceToView(customButton.imageView, 3)
        .topEqualToView(customButton)
        .bottomEqualToView(customButton);
        
        
    }
    
    self.buttonArray = @[self.button_1, self.button_2, self.button_3];
    self.headerView.sd_equalWidthSubviews = self.buttonArray;
    self.button_1.sd_layout
    .leftSpaceToView(self.headerView, 15)
    .bottomEqualToView(self.headerView)
    .heightIs(40);
    self.button_2.sd_layout
    .leftSpaceToView(self.button_1, 15)
    .bottomEqualToView(self.button_1)
    .topEqualToView(self.button_1);
    self.button_3.sd_layout
    .leftSpaceToView(self.button_2, 15)
    .bottomEqualToView(self.button_1)
    .topEqualToView(self.button_1);
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.headerView.height -1, KWidthScreen, 1)];
    lineView.backgroundColor = DividingLine_color;
    [self.headerView addSubview:lineView];
    
    //
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.headerView.bottom, KWidthScreen, KHeightScreen -self.headerView.bottom) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
}

#pragma mark     排序 筛选 
-(void)selectSort:(UIButton *)sender {
    [self.button_1 setTitleColor:Black_text_color forState:UIControlStateNormal];
    [self.button_1 setImage:ImageNamed(@"Arrow_bottom_black") forState:UIControlStateNormal];
    [self.button_2 setTitleColor:Black_text_color forState:UIControlStateNormal];
    [self.button_2 setImage:ImageNamed(@"Arrow_bottom_black") forState:UIControlStateNormal];
    [self.button_3 setTitleColor:Black_text_color forState:UIControlStateNormal];
    [self.button_3 setImage:ImageNamed(@"Arrow_bottom_black") forState:UIControlStateNormal];
    
    
    if (_siftView) {
        [self.siftView removeFromSuperview];
    }
    
    
    
    switch (sender.tag) {
        case 0:
        {
            self.siftView.siftStyle = RFSiftListViewStyle;
        }
            break;
        case 1:
        {
            self.siftView.siftStyle = RFSiftCollectionViewStyle;
        }
            break;
        case 2:
        {
            self.siftView.siftStyle = RFSiftMultipleSelectionStyle;
        }
            break;
            
        default:
            break;
    }
    
   
    
    if (self.rfStyle == self.siftView.siftStyle) {
        self.rfStyle = -1;
        return;
    }
    
    [sender setTitleColor:main_Color forState:UIControlStateNormal];
    [sender setImage:ImageNamed(@"Arrow_top_orange") forState:UIControlStateNormal];
    
    self.rfStyle = self.siftView.siftStyle;
    [self.view addSubview:self.siftView];
    [self.siftView reloadView];
}



-(RFSiftShoppingView *)siftView{
    if (_siftView == nil) {
        _siftView = [[RFSiftShoppingView alloc]initWithFrame:CGRectMake(0, self.headerView.bottom, KWidthScreen, KHeightScreen -self.headerView.bottom)];
        _siftView.rfDelegate = self;
    }
    return _siftView;
}



-(void)collectionViewDidSelectItemForRFStyle:(RFSiftStyle)style SortStr:(NSString *)sortStr CarStr:(NSString *)carStr PriceStr:(NSString *)priceStr SpeedStr:(NSString *)speedStr DisplacementStr:(NSString *)displacementStr EnergyStr:(NSString *)energystr IntakeStr:(NSString *)intakeStr {
    self.listStr = sortStr;
    self.carStr = carStr;
    self.priceStr = priceStr;
    self.speedStr = speedStr;
    self.displacementStr = displacementStr;
    self.energystr = energystr;
    self.intakeStr = intakeStr;
    
    self.rfStyle = -1;
    [self.siftView removeFromSuperview];
    
    
    [self.button_1 setTitleColor:Black_text_color forState:UIControlStateNormal];
    [self.button_1 setImage:ImageNamed(@"Arrow_bottom_black") forState:UIControlStateNormal];
    [self.button_2 setTitleColor:Black_text_color forState:UIControlStateNormal];
    [self.button_2 setImage:ImageNamed(@"Arrow_bottom_black") forState:UIControlStateNormal];
    [self.button_3 setTitleColor:Black_text_color forState:UIControlStateNormal];
    [self.button_3 setImage:ImageNamed(@"Arrow_bottom_black") forState:UIControlStateNormal];
    
    
    //刷新数;
    [self loadData];
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
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KWidthScreen, 30)];
    sectionView.backgroundColor = white_Color;
    [self.view addSubview:sectionView];
    
    CGFloat space = 8;
    CGFloat width = (KWidthScreen -space *6) /5.0;
    
    for (int i = 0; i < self.conditionArray.count; i++) {
        UIButton *conditionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        conditionBtn.frame = CGRectMake(space *(i+1) +width *i, 5, width, 20);
        [conditionBtn setTitle:self.conditionArray[i] forState:UIControlStateNormal];
        [conditionBtn setTitleColor:Black_text_color forState:UIControlStateNormal];
        conditionBtn.titleLabel.font = Font(10);
        conditionBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [conditionBtn setBackgroundColor:UIColorFromHex(0xF8F8F8)];
        [conditionBtn setImage:ImageNamed(@"like_delete") forState:UIControlStateNormal];
        conditionBtn.layer.cornerRadius = 10;
        conditionBtn.tag = i;
        [conditionBtn addTarget:self action:@selector(conditionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [sectionView addSubview:conditionBtn];
        
        conditionBtn.imageView.sd_layout
        .widthIs(conditionBtn.imageView.width)
        .heightIs(conditionBtn.imageView.height)
        .rightSpaceToView(conditionBtn, 3)
        .centerYEqualToView(conditionBtn);
        conditionBtn.titleLabel.sd_layout
        .leftEqualToView(conditionBtn)
        .rightSpaceToView(conditionBtn.imageView, 3)
        .topEqualToView(conditionBtn)
        .bottomEqualToView(conditionBtn);
        
        
    }
    
    return sectionView;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.f;
}



//点击筛选条件
-(void)conditionBtnClick:(UIButton *)sender {
    NSString *str = self.conditionArray[sender.tag];
    if ([str isEqualToString:self.priceStr]) {
        self.priceStr = @"";
        self.siftView.priceStr = @"";
    } else if ([str isEqualToString:self.speedStr]) {
        self.speedStr = @"";
        self.siftView.speedStr = @"";
    } else if ([str isEqualToString:self.displacementStr]) {
        self.displacementStr = @"";
        self.siftView.displacementStr = @"";
    } else if ([str isEqualToString:self.energystr]) {
        self.energystr = @"";
        self.siftView.energystr = @"";
    } else if ([str isEqualToString:self.intakeStr]) {
        self.intakeStr = @"";
        self.siftView.intakeStr = @"";
    }
    
    [self loadData];
    [self.siftView reloadMultipleData];
}

@end
