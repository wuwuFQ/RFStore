//
//  RFCollectionViewCell.m
//  BC_ConvenientTravel
//
//  Created by 便便出行 on 2019/1/19.
//  Copyright © 2019 Triple_L. All rights reserved.
//

#import "RFCollectionViewCell.h"
@interface RFCollectionViewCell ()
@property (nonatomic, strong) UILabel *tittle_label;

@property (nonatomic, strong) UIImageView *iconImgView;

@end

@implementation RFCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        
    }
    return self;
}

-(void)setup {
    self.iconImgView = [UIImageView new];
   [self.contentView addSubview:self.iconImgView];
    self.iconImgView.sd_layout
    .widthIs(50)
    .heightIs(20)
    .centerXEqualToView(self.contentView)
    .topSpaceToView(self.contentView, 20);
    
    self.tittle_label = [UILabel new];
    self.tittle_label.textAlignment = NSTextAlignmentCenter;
    self.tittle_label.textColor = Black_text_color;
    self.tittle_label.font = Font(14);
    [self.contentView addSubview:self.tittle_label];
    self.tittle_label.sd_layout
     .leftEqualToView(self.contentView)
     .rightEqualToView(self.contentView)
     .heightIs(15)
    .topSpaceToView(self.iconImgView, 5);
}

-(void)setModel:(RFSiftShoppingModel *)model{
    _model = model;
    
    self.iconImgView.image = [UIImage imageNamed:_model.imgNameStr];
    
    self.tittle_label.text = _model.titleStr;
}

@end
