//
//  RFBaseScrollView.m
//  BC_ConvenientTravel
//
//  Created by 便便出行 on 2019/1/12.
//  Copyright © 2019 Triple_L. All rights reserved.
//

#import "RFBaseScrollView.h"

@implementation RFBaseScrollView

/**
 同时识别多个手势
 
 @param gestureRecognizer gestureRecognizer description
 @param otherGestureRecognizer otherGestureRecognizer description
 @return return value description
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


@end
