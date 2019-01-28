//
//  InformationListCell.m
//  BC_ConvenientTravel
//
//  Created by 便便出行 on 2019/1/16.
//  Copyright © 2019 Triple_L. All rights reserved.
//

#import "InformationListCell.h"

@interface InformationListCell ()

@property (nonatomic, strong) UILabel *title_label;

@property (nonatomic, strong) NSArray *imageViewsArray;

@property (nonatomic, strong) UILabel *companyName_label;

@property (nonatomic, strong) UILabel *timeStamp_label;

@property (nonatomic, strong) UILabel *modelName_label;


@end
@implementation InformationListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setup];
        
    }
    
    return self;
}


-(void)setup {
    self.title_label = [UILabel new];
    [self.contentView addSubview:self.title_label];
    self.title_label.textColor = UIColorFromHex(0x222222);
    self.title_label.font = Font(18);
    
    
    UIImageView * imageView0 = [UIImageView new];
    [self.contentView addSubview:imageView0];
    
    UIImageView * imageView1 = [UIImageView new];
    [self.contentView addSubview:imageView1];
    
    UIImageView * imageView2 = [UIImageView new];
    [self.contentView addSubview:imageView2];
    
    self.imageViewsArray = @[imageView0, imageView1, imageView2];
    
    // 设置等宽的子view
    self.contentView.sd_equalWidthSubviews = self.imageViewsArray;
    
    CGFloat margin = 15;
    UIView *contentView = self.contentView;
    
    self.title_label.sd_layout
    .leftSpaceToView(contentView, margin)
    .topSpaceToView(contentView, margin)
    .rightSpaceToView(contentView, margin)
    .autoHeightRatio(0);
    
    imageView0.sd_layout
    .topSpaceToView(self.title_label, 8)
    .leftSpaceToView(contentView, margin)
    .autoHeightRatio(0.6);
    
    imageView1.sd_layout
    .topSpaceToView(self.title_label, 8)
    .leftSpaceToView(imageView0, 3)
    .autoHeightRatio(0.6);
    
    imageView2.sd_layout
    .topSpaceToView(self.title_label, 8)
    .leftSpaceToView(imageView1, 3)
    .rightSpaceToView(contentView, margin)
    .autoHeightRatio(0.6);
    
    
    //
    UIImageView *hotImgView = [UIImageView new];
    hotImgView.image = ImageNamed(@"HomePage_hot");
    [self.contentView addSubview:hotImgView];
    
    self.companyName_label = [UILabel new];
    self.companyName_label.textColor = UIColorFromHex(0x999999);
    self.companyName_label.font = Font(12);
    [self.contentView addSubview: self.companyName_label];
    
    self.timeStamp_label = [UILabel new];
    self.timeStamp_label.textColor = UIColorFromHex(0x999999);
    self.timeStamp_label.font = Font(12);
    [self.contentView addSubview: self.timeStamp_label];
    
    UILabel *sign_label = [UILabel new];
    sign_label.text = @"#";
    sign_label.textColor = main_Color;
    sign_label.font = Font(11);
    [self.contentView addSubview:sign_label];
    
    self.modelName_label = [UILabel new];
    self.modelName_label.textColor = Gray_text_color;
    self.modelName_label.font = Font(12);
    [self.contentView addSubview: self.modelName_label];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = Background_color;
    [self.contentView addSubview:lineView];
    lineView.sd_layout.leftSpaceToView(contentView, margin).rightSpaceToView(contentView, margin).bottomEqualToView(contentView).heightIs(1);
    
    
    hotImgView.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .topSpaceToView(imageView0, 8)
    .widthIs(15)
    .heightEqualToWidth();
    
    self.companyName_label.sd_layout
    .leftSpaceToView(hotImgView, 8)
    .topEqualToView(hotImgView)
    .heightIs(15);
    [self.companyName_label setSingleLineAutoResizeWithMaxWidth:100];
    
    self.timeStamp_label.sd_layout
    .leftSpaceToView(self.companyName_label, 8)
    .topEqualToView(hotImgView)
    .heightIs(15);
    [self.timeStamp_label setSingleLineAutoResizeWithMaxWidth:100];
    
    sign_label.sd_layout
    .leftSpaceToView(self.timeStamp_label, 12)
    .topEqualToView(hotImgView)
    .heightIs(15);
    [sign_label setSingleLineAutoResizeWithMaxWidth:10];
    
    self.modelName_label.sd_layout
    .leftSpaceToView(sign_label, 0)
    .rightSpaceToView(self.contentView, 15)
    .topEqualToView(hotImgView)
    .heightIs(15);
    
    
    
    [self setupAutoHeightWithBottomView:hotImgView bottomMargin:10];
}

- (void)setModel:(InformationModel *)model{
    _model = model;
    
    self.title_label.text = _model.title;
    
    [model.image enumerateObjectsUsingBlock:^(NSString * _Nonnull str, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIImageView *imageView = self.imageViewsArray[idx];
        [imageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:ImageNamed(@"placeholderImage")];
        if (idx == 2) {
            *stop = YES;
        }
    }];
    
    
    self.companyName_label.text = _model.corporateName;
    
    self.timeStamp_label.text = @"10秒前";
    
    self.modelName_label.text = _model.modelName;
    
    
}


@end
