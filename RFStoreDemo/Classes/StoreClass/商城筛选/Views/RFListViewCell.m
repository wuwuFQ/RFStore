//
//  RFListViewCell.m
//  BC_ConvenientTravel
//
//  Created by 便便出行 on 2019/1/19.
//  Copyright © 2019 Triple_L. All rights reserved.
//

#import "RFListViewCell.h"

@interface RFListViewCell ()
@property (nonatomic, strong) UILabel *tittle_label;

@property (nonatomic, strong) UIImageView *selectImgView;

@end
@implementation RFListViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
       
    }
    return self;
}

-(void)setup {
    
    self.selectImgView = [UIImageView new];
    self.selectImgView.hidden = YES;
    self.selectImgView.image = [UIImage imageNamed:@"RF_sift_select"];
    [self.contentView addSubview:self.selectImgView];
    self.selectImgView.sd_layout
    .rightSpaceToView(self.contentView, 25)
    .centerYEqualToView(self.contentView)
    .widthIs(15)
    .heightEqualToWidth();
    
    
    self.tittle_label = [UILabel new];
    self.tittle_label.textColor = Black_text_color;
    self.tittle_label.font = Font(14);
    [self.contentView addSubview:self.tittle_label];
    self.tittle_label.sd_layout
    .leftSpaceToView(self.contentView, 25)
    .rightSpaceToView(self.selectImgView, 15)
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView);
    
    
}

- (void)setModel:(RFSiftShoppingModel *)model{
    _model = model;
    
    self.tittle_label.text = _model.titleStr;
   
    self.selectImgView.hidden = !_model.isSelected;
    
    self.tittle_label.textColor = Black_text_color;
    if (_model.isSelected) {
        self.tittle_label.textColor = main_Color;
    }
}

@end
