//
//  GTDeleteCellView.h
//  SampleApp
//
//  Created by mengtuosun on 2020/6/13.
//  Copyright © 2020 mengtuosun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTDeleteCellView : UIView


- (void)showDeleteViewFromPoint:(CGPoint)point clickBlock:(dispatch_block_t)clickBlock;

- (void) dismissDeleteView;

@end

NS_ASSUME_NONNULL_END
