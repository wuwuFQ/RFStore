//
//  InformationListCell.h
//  BC_ConvenientTravel
//
//  Created by 便便出行 on 2019/1/16.
//  Copyright © 2019 Triple_L. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "InformationModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface InformationListCell : UITableViewCell
@property (nonatomic, strong) InformationModel *model;
@end

NS_ASSUME_NONNULL_END
