//
//  UIViewController+Tracking.h
//  StackView-Demo
//
//  Created by mengtuosun on 2020/6/10.
//  Copyright © 2020 shangbin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Tracking)

//@property CFAbsoluteTime initBeginTime;
//@property CFAbsoluteTime initEndTime;

+ (void)replaceSelector:(SEL)originalSelector bySelector:(SEL)swizzlingSelector;

@end

NS_ASSUME_NONNULL_END
