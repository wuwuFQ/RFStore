//
//  RFSiftShoppingView.h
//  BC_ConvenientTravel
//
//  Created by 便便出行 on 2019/1/19.
//  Copyright © 2019 Triple_L. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    RFSiftListViewStyle,//多选列表
    RFSiftCollectionViewStyle,//区块
    RFSiftMultipleSelectionStyle,//多选
} RFSiftStyle;

@protocol RFSiftShoppingViewDelegate <NSObject>
@optional
-(void)collectionViewDidSelectItemForRFStyle:(RFSiftStyle)style
                                     SortStr:(NSString *)sortStr
                                     CarStr:(NSString *)carStr
                                     PriceStr:(NSString *)priceStr
                                     SpeedStr:(NSString *)speedStr
                                     DisplacementStr:(NSString *)displacementStr
                                     EnergyStr:(NSString *)energystr
                                     IntakeStr:(NSString *)intakeStr;

@end


@interface RFSiftShoppingView : UIView
@property (nonatomic, copy) NSString *listStr;

@property (nonatomic, copy) NSString *carStr;

/** 更多数据 */
@property (nonatomic, copy) NSString *priceStr;
@property (nonatomic, copy) NSString *speedStr;
@property (nonatomic, copy) NSString *displacementStr;
@property (nonatomic, copy) NSString *energystr;
@property (nonatomic, copy) NSString *intakeStr;
/** 更多数据 */



@property (nonatomic, assign) RFSiftStyle siftStyle;

@property (nonatomic, weak) id<RFSiftShoppingViewDelegate> rfDelegate;


-(void)reloadView;

-(void)reloadMultipleData;
@end

//筛选购物
