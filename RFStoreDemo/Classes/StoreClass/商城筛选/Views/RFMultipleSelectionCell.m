//
//  RFMultipleSelectionCell.m
//  BC_ConvenientTravel
//
//  Created by 便便出行 on 2019/1/19.
//  Copyright © 2019 Triple_L. All rights reserved.
//

#import "RFMultipleSelectionCell.h"
@interface RFMultipleSelectionCell ()
@property (nonatomic, strong) UILabel *tittle_label;

@end
@implementation RFMultipleSelectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        
    }
    return self;
}

-(void)setup {
    
    self.tittle_label = [UILabel new];
    self.tittle_label.textAlignment = NSTextAlignmentCenter;
    self.tittle_label.textColor = Black_text_color;
    self.tittle_label.font = Font(14);
    [self.tittle_label setBackgroundColor:UIColorFromHex(0xF8F8F8)];
    [self.contentView addSubview:self.tittle_label];
    self.tittle_label.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    self.tittle_label.sd_cornerRadiusFromHeightRatio = @(.25);
    self.tittle_label.layer.borderColor = main_Color.CGColor;
    
}

-(void)setModel:(RFSiftShoppingModel *)model{
    _model = model;
    
    self.tittle_label.text = _model.titleStr;
    
    if (_model.isSelected) {
        self.tittle_label.layer.borderWidth = 1;
        [self.tittle_label setBackgroundColor:UIColorFromHexA(0xFC5A14, 0.05)];
        
    } else {
        self.tittle_label.layer.borderWidth = 0;
        [self.tittle_label setBackgroundColor:UIColorFromHex(0xF8F8F8)];
    }
}
@end
