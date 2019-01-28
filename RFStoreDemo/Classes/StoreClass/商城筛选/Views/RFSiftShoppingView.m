//
//  RFSiftShoppingView.m
//  BC_ConvenientTravel
//
//  Created by 便便出行 on 2019/1/19.
//  Copyright © 2019 Triple_L. All rights reserved.
//

#import "RFSiftShoppingView.h"

#import "RFListViewCell.h"
#import "RFCollectionViewCell.h"
#import "RFMultipleSelectionCell.h"

@interface RFSiftShoppingView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *bottomView;

/** 列表数据 */
@property (nonatomic, strong) NSMutableArray *listData;


/** 车型数据 */
@property (nonatomic, strong) NSMutableArray *carData;

/** 更多数据 */
@property (nonatomic, strong) NSMutableArray *multipleData;
@property (nonatomic, strong) NSArray *reusableData;

@end


@implementation RFSiftShoppingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromHexA(0x000000, 0.3);
        
        self.listData = [NSMutableArray array];
        self.carData = [NSMutableArray array];
        self.multipleData = [NSMutableArray array];
        self.listStr = @"智能排序";
        self.carStr = @"";
        self.priceStr = @"";
        self.speedStr = @"";
        self.displacementStr = @"";
        self.energystr = @"";
        self.intakeStr = @"";
        
        [self initializationData];
        [self setup];
       
    }
    return self;
}

//初始化数据
-(void)initializationData {
    self.listData = [NSMutableArray array];
    self.carData = [NSMutableArray array];
    self.multipleData = [NSMutableArray array];

    //
    NSArray *list = @[@"智能排序", @"价格最低", @"价格最高"];
    for (int i = 0; i < list.count; i++) {
        RFSiftShoppingModel *model = [RFSiftShoppingModel new];
        model.titleStr = list[i];
        model.selected = NO;
        model.tag = i;
        if ([model.titleStr isEqualToString:self.listStr]) {
            model.selected = YES;
        }
        [self.listData addObject:model];
    }
    
    //
    NSArray *car = @[@"两厢轿车", @"三厢轿车", @"SUV", @"MPV"];
    for (int i = 0; i < car.count; i++) {
        RFSiftShoppingModel *model = [RFSiftShoppingModel new];
        model.titleStr = car[i];
        model.imgNameStr = car[i];
        model.tag = i;
        if ([model.titleStr isEqualToString:self.carStr]) {
            model.selected = YES;
        }
        [self.carData addObject:model];
    }
    
    
    //
    self.reusableData = @[@"指导价", @"变速箱", @"排量", @"能源", @"进气形式"];
    NSArray *multiple = @[@[@"10万以下", @"10-15万", @"15-20万", @"20-30万", @"30-50万", @"50万以上"],
                          @[@"手动", @"自动"],
                          @[@"1.0L以下", @"1.0-2.0L", @"2.0-3.0L", @"3.0L以上"],
                          @[@"汽油", @"油电混合", @"新能源"],
                          @[@"自然吸气", @"涡轮增压"]
                          ];
    for (int i = 0; i < multiple.count; i++) {
        NSArray *arr = multiple[i];
        NSMutableArray *mutableArr = [NSMutableArray array];
        for (int j = 0; j < arr.count; j++) {
            RFSiftShoppingModel *model = [RFSiftShoppingModel new];
            model.titleStr = arr[j];
            model.selected = NO;
            model.tag = j;
            switch (i) {
                case 0:
                {
                    if ([model.titleStr isEqualToString:self.priceStr]) {
                        model.selected = YES;
                    }
                }
                    break;
                case 1:
                {
                    if ([model.titleStr isEqualToString:self.speedStr]) {
                        model.selected = YES;
                    }
                }
                    break;
                case 2:
                {
                    if ([model.titleStr isEqualToString:self.displacementStr]) {
                        model.selected = YES;
                    }
                }
                    break;
                case 3:
                {
                    if ([model.titleStr isEqualToString:self.energystr]) {
                        model.selected = YES;
                    }
                }
                    break;
                case 4:
                {
                    if ([model.titleStr isEqualToString:self.intakeStr]) {
                        model.selected = YES;
                    }
                }
                    break;
                default:
                    break;
            }
            [mutableArr addObject:model];
        }
        [self.multipleData addObject:mutableArr];
    }
    
    
}


-(void)reloadListData {
    self.listData = [NSMutableArray array];
    
    //
    NSArray *list = @[@"智能排序", @"价格最低", @"价格最高"];
    for (int i = 0; i < list.count; i++) {
        RFSiftShoppingModel *model = [RFSiftShoppingModel new];
        model.titleStr = list[i];
        model.selected = NO;
        model.tag = i;
        if ([model.titleStr isEqualToString:self.listStr]) {
            model.selected = YES;
        }
        [self.listData addObject:model];
    }
    [self.collectionView reloadData];
}
-(void)reloadMultipleData {
    self.multipleData = [NSMutableArray array];
    
    //
    self.reusableData = @[@"指导价", @"变速箱", @"排量", @"能源", @"进气形式"];
    NSArray *multiple = @[@[@"10万以下", @"10-15万", @"15-20万", @"20-30万", @"30-50万", @"50万以上"],
                          @[@"手动", @"自动"],
                          @[@"1.0L以下", @"1.0-2.0L", @"2.0-3.0L", @"3.0L以上"],
                          @[@"汽油", @"油电混合", @"新能源"],
                          @[@"自然吸气", @"涡轮增压"]
                          ];
    for (int i = 0; i < multiple.count; i++) {
        NSArray *arr = multiple[i];
        NSMutableArray *mutableArr = [NSMutableArray array];
        for (int j = 0; j < arr.count; j++) {
            RFSiftShoppingModel *model = [RFSiftShoppingModel new];
            model.titleStr = arr[j];
            model.selected = NO;
            model.tag = j;
            switch (i) {
                case 0:
                {
                    if ([model.titleStr isEqualToString:self.priceStr]) {
                        model.selected = YES;
                    }
                }
                    break;
                case 1:
                {
                    if ([model.titleStr isEqualToString:self.speedStr]) {
                        model.selected = YES;
                    }
                }
                    break;
                case 2:
                {
                    if ([model.titleStr isEqualToString:self.displacementStr]) {
                        model.selected = YES;
                    }
                }
                    break;
                case 3:
                {
                    if ([model.titleStr isEqualToString:self.energystr]) {
                        model.selected = YES;
                    }
                }
                    break;
                case 4:
                {
                    if ([model.titleStr isEqualToString:self.intakeStr]) {
                        model.selected = YES;
                    }
                }
                    break;
                default:
                    break;
            }
            [mutableArr addObject:model];
        }
        [self.multipleData addObject:mutableArr];
    }
    [self.collectionView reloadData];
}

-(void)reloadView{
    
    self.bottomView.hidden = YES;
    CGFloat height;
    switch (self.siftStyle) {
        case RFSiftListViewStyle:
        {
            height = 120;
        }
            break;
        case RFSiftCollectionViewStyle:
        {
            height = 200;
        }
            break;
        case RFSiftMultipleSelectionStyle:
        {
            height = self.height -50;
            self.bottomView.hidden = NO;
        }
            break;
    }
    self.collectionView.frame = CGRectMake(0, 0, KWidthScreen, height);
    [self.collectionView reloadData];
}

-(void)setup {
    
    
    /**
     创建layout
     */
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    /**
     创建collectionView
     */
    CGFloat height;
    switch (self.siftStyle) {
        case RFSiftListViewStyle:
        {
            height = 120;
        }
            break;
        case RFSiftCollectionViewStyle:
        {
            height = 200;
        }
             break;
        case RFSiftMultipleSelectionStyle:
        {
            height = self.height -50;
        }
             break;
    }
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KWidthScreen, height) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    //    collectionView.alwaysBounceVertical = YES;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.backgroundColor = white_Color;
    [collectionView registerClass:[RFListViewCell class] forCellWithReuseIdentifier:NSStringFromClass([RFListViewCell class])];
    [collectionView registerClass:[RFCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([RFCollectionViewCell class])];
    [collectionView registerClass:[RFMultipleSelectionCell class] forCellWithReuseIdentifier:NSStringFromClass([RFMultipleSelectionCell class])];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
    //    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter"];
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height -50, KWidthScreen, 50)];
    bottomView.backgroundColor = white_Color;
    [self addSubview:bottomView];
    self.bottomView = bottomView;
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KWidthScreen, 1)];
    lineView.backgroundColor = DividingLine_color;
    [bottomView addSubview:lineView];
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setTitle:@"重置" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:white_Color forState:UIControlStateNormal];
    cancleBtn.titleLabel.font = Font(16);
    [cancleBtn setBackgroundColor:UIColorFromHex(0xCCCCCC)];
    cancleBtn.tag = 100;
    cancleBtn.layer.cornerRadius = 5;
    [cancleBtn addTarget:self action:@selector(lookOrCancle:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:cancleBtn];
    UIButton *lookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [lookBtn setTitle:@"查看" forState:UIControlStateNormal];
    [lookBtn setTitleColor:white_Color forState:UIControlStateNormal];
    lookBtn.titleLabel.font = Font(16);
    [lookBtn setBackgroundColor:main_Color];
    lookBtn.tag = 200;
    lookBtn.layer.cornerRadius = 5;
    [lookBtn addTarget:self action:@selector(lookOrCancle:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:lookBtn];
    
    bottomView.sd_equalWidthSubviews = @[cancleBtn, lookBtn];
    cancleBtn.sd_layout
    .leftSpaceToView(bottomView, 50)
    .centerYEqualToView(bottomView)
    .heightIs(40);
    lookBtn.sd_layout
    .leftSpaceToView(cancleBtn, 30)
    .rightSpaceToView(bottomView, 50)
    .centerYEqualToView(bottomView)
    .heightIs(40);
    
    
}


#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (self.siftStyle == RFSiftMultipleSelectionStyle) {
        return self.reusableData.count;
    }
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    switch (self.siftStyle) {
        case RFSiftListViewStyle:
        {
            return self.listData.count;
        }
        case RFSiftCollectionViewStyle:
        {
            return self.carData.count;
        }
        case RFSiftMultipleSelectionStyle:
        {
            return [[self.multipleData objectAtIndex:section] count];
        }
    }
    return 0;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (self.siftStyle) {
        case RFSiftListViewStyle:
        {
            RFListViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([RFListViewCell class]) forIndexPath:indexPath];
            cell.model = self.listData[indexPath.item];
            return cell;
        }
        case RFSiftCollectionViewStyle:
        {
            RFCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([RFCollectionViewCell class]) forIndexPath:indexPath];
            cell.model = self.carData[indexPath.item];
            return cell;
        }
        case RFSiftMultipleSelectionStyle:
        {
            RFMultipleSelectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([RFMultipleSelectionCell class]) forIndexPath:indexPath];
            cell.model = [[self.multipleData objectAtIndex:indexPath.section] objectAtIndex:indexPath.item];
            return cell;        }
        }
    
    return nil;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader){
        UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
        UILabel *label = [reusableView viewWithTag:100];
        if (!label) {
            label = [[UILabel alloc]init];
            label.tag = 100;
            label.textColor = Black_text_color;
            label.font = [UIFont systemFontOfSize:14];
            [reusableView addSubview:label];
            
            label.sd_layout
            .leftSpaceToView(reusableView, 15)
            .topEqualToView(reusableView)
            .bottomEqualToView(reusableView)
            .widthIs(200);
        }
        label.text = self.reusableData[indexPath.section];
        return reusableView;
    }else if(kind == UICollectionElementKindSectionFooter){
        return nil;
    }
    return nil;
    
    
}


//动态设置每个Item的尺寸大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (self.siftStyle) {
        case RFSiftListViewStyle:
        {
            return CGSizeMake(KWidthScreen, 40);
        }
        case RFSiftCollectionViewStyle:
        {
            return CGSizeMake(80, 80);
        }
        case RFSiftMultipleSelectionStyle:
        {
            return CGSizeMake(105, 35);
        }
    }
    return CGSizeZero;
}
//动态设置每个分区的EdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    switch (self.siftStyle) {
        case RFSiftListViewStyle:
        {
            return UIEdgeInsetsZero;
        }
        case RFSiftCollectionViewStyle:
        {
            CGFloat width = (KWidthScreen -80 *3) *0.25;
            return UIEdgeInsetsMake(0, width, 0, width);
        }
        case RFSiftMultipleSelectionStyle:
        {
            CGFloat width = (KWidthScreen -105 *3) *0.25;
            return UIEdgeInsetsMake(0, width, 0, width);
        }
    }

    return UIEdgeInsetsZero;
}
//动态设置每行的间距大小
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    switch (self.siftStyle) {
        case RFSiftListViewStyle:
        {
            return 0;
        }
        case RFSiftCollectionViewStyle:
        {
            return 10;
        }
        case RFSiftMultipleSelectionStyle:
        {
            return 10;
        }
    }
    return 0;
}
//动态设置每列的间距大小
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    switch (self.siftStyle) {
        case RFSiftListViewStyle:
        {
            return 0;
        }
        case RFSiftCollectionViewStyle:
        {
            CGFloat width = (KWidthScreen -80 *3) *0.25;
            return width;
        }
        case RFSiftMultipleSelectionStyle:
        {
            CGFloat width = (KWidthScreen -105 *3) *0.25;
            return width;
        }
    }
    return 0;
}
//动态设置某个分区头视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (self.siftStyle == RFSiftMultipleSelectionStyle) {
        return CGSizeMake(KWidthScreen, 40);
    }
    return CGSizeZero;
}
//动态设置某个分区尾视图大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (self.siftStyle) {
        case RFSiftListViewStyle:
        {
            RFSiftShoppingModel *model = self.listData[indexPath.item];
            self.listStr = model.titleStr;
            if ([self.rfDelegate respondsToSelector:@selector(collectionViewDidSelectItemForRFStyle:SortStr:CarStr:PriceStr:SpeedStr:DisplacementStr:EnergyStr:IntakeStr:)]) {
                [self.rfDelegate collectionViewDidSelectItemForRFStyle:RFSiftMultipleSelectionStyle
                                                               SortStr:self.listStr
                                                                CarStr:self.carStr
                                                              PriceStr:self.priceStr
                                                              SpeedStr:self.speedStr
                                                       DisplacementStr:self.displacementStr
                                                             EnergyStr:self.energystr
                                                             IntakeStr:self.intakeStr];
            }
            
            [self reloadListData];
            
        }
            break;
        case RFSiftCollectionViewStyle:
        {
            RFSiftShoppingModel *model = self.carData[indexPath.item];
            self.carStr = model.titleStr;
            if ([self.rfDelegate respondsToSelector:@selector(collectionViewDidSelectItemForRFStyle:SortStr:CarStr:PriceStr:SpeedStr:DisplacementStr:EnergyStr:IntakeStr:)]) {
                [self.rfDelegate collectionViewDidSelectItemForRFStyle:RFSiftMultipleSelectionStyle
                                                               SortStr:self.listStr
                                                                CarStr:self.carStr
                                                              PriceStr:self.priceStr
                                                              SpeedStr:self.speedStr
                                                       DisplacementStr:self.displacementStr
                                                             EnergyStr:self.energystr
                                                             IntakeStr:self.intakeStr];
            }

        }
            break;
        case RFSiftMultipleSelectionStyle:
        {
            RFSiftShoppingModel *model = [[self.multipleData objectAtIndex:indexPath.section] objectAtIndex:indexPath.item];
            switch (indexPath.section) {
                case 0:
                {
                    self.priceStr = model.titleStr;
                }
                    break;
                case 1:
                {
                    self.speedStr = model.titleStr;
                }
                    break;
                case 2:
                {
                    self.displacementStr = model.titleStr;
                }
                    break;
                case 3:
                {
                    self.energystr = model.titleStr;
                }
                    break;
                case 4:
                {
                    self.intakeStr = model.titleStr;
                }
                    break;
                    
                default:
                    break;
            }
            [self reloadMultipleData];;
        }
            break;
    }
}
//重置  查看
-(void)lookOrCancle:(UIButton *)sender {
    if (sender.tag == 100) {
        self.priceStr = @"";
        self.speedStr = @"";
        self.displacementStr = @"";
        self.energystr = @"";
        self.intakeStr = @"";
        [self reloadMultipleData];
    } else {

        if ([self.rfDelegate respondsToSelector:@selector(collectionViewDidSelectItemForRFStyle:SortStr:CarStr:PriceStr:SpeedStr:DisplacementStr:EnergyStr:IntakeStr:)]) {
            [self.rfDelegate collectionViewDidSelectItemForRFStyle:RFSiftMultipleSelectionStyle
                                                           SortStr:self.listStr
                                                            CarStr:self.carStr
                                                          PriceStr:self.priceStr
                                                          SpeedStr:self.speedStr
                                                   DisplacementStr:self.displacementStr
                                                         EnergyStr:self.energystr
                                                         IntakeStr:self.intakeStr];
        }
    }
}

@end
