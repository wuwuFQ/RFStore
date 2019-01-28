//
//  RFSiftShoppingModel.h
//  BC_ConvenientTravel
//
//  Created by 便便出行 on 2019/1/19.
//  Copyright © 2019 Triple_L. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RFSiftShoppingModel : NSObject
@property (nonatomic, assign) NSInteger tag;

@property (nonatomic, strong) NSString *titleStr;

@property (nonatomic, strong) NSString *imgNameStr;

@property (nonatomic, assign, getter=isSelected) BOOL selected;

@end

NS_ASSUME_NONNULL_END
