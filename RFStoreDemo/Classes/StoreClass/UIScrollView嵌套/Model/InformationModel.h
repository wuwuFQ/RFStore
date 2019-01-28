//
//  InformationModel.h
//  RFStoreDemo
//
//  Created by 便便出行 on 2019/1/22.
//  Copyright © 2019 bbcx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface InformationModel : NSObject
@property (nonatomic, copy) NSString *model_id;

@property (nonatomic, copy) NSString *modelName;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *corporateName;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSArray *image;

@property (nonatomic, copy) NSString *createTime;//时间戳

@end

NS_ASSUME_NONNULL_END
