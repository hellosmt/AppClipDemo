//
//  GTNormalTableViewCell.h
//  SampleApp
//
//  Created by mengtuosun on 2020/6/12.
//  Copyright © 2020 mengtuosun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GTNormalTableViewCellDelegate <NSObject>

- (void)tableViewCell:(UITableViewCell*)tableViewCell clickDeleteButton:(UIButton*)deleteButton;

@end


@class GTListItem;
@interface GTNormalTableViewCell : UITableViewCell

@property(nonatomic, weak, readwrite)id<GTNormalTableViewCellDelegate> delegate;

- (void)layoutTableViewCellWithItem:(GTListItem*)item;

@end

NS_ASSUME_NONNULL_END
