//
//  GTNormalTableViewCell.m
//  SampleApp
//
//  Created by mengtuosun on 2020/6/12.
//  Copyright © 2020 mengtuosun. All rights reserved.
//

#import "GTNormalTableViewCell.h"
#import "GTListItem.h"

@interface GTNormalTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *soureceLabel;
@property (nonatomic, strong) UILabel *commentLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIButton *deleteButton;

@property (nonatomic, strong) GTListItem *item;

@end

@implementation GTNormalTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.soureceLabel];
        [self.contentView addSubview:self.commentLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.rightImageView];
//        [self.contentView addSubview:self.deleteButton];
    }
    return self;
}

- (void)layoutTableViewCellWithItem:(GTListItem *)item
{
    self.item = item;
    self.titleLabel.text = self.item.title;

    self.soureceLabel.text = self.item.authorName;
    [self.soureceLabel sizeToFit];

    self.commentLabel.text = self.item.category;
    [self.commentLabel sizeToFit];
    self.commentLabel.frame = CGRectMake(self.soureceLabel.frame.origin.x +  self.soureceLabel.frame.size.width + 15, self.soureceLabel.frame.origin.y, self.commentLabel.frame.size.width, self.commentLabel.frame.size.height);

    self.timeLabel.text = self.item.date;
    [self.timeLabel sizeToFit];
    self.timeLabel.frame = CGRectMake(self.commentLabel.frame.origin.x +  self.commentLabel.frame.size.width + 15, self.commentLabel.frame.origin.y, self.timeLabel.frame.size.width, self.timeLabel.frame.size.height);

#warning  不规范的写法
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.item.picUrl]]];
    self.rightImageView.image = image;
}

#pragma mark - action

- (void)deleteButtonClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableViewCell:clickDeleteButton:)]) {
        [self.delegate tableViewCell:self clickDeleteButton:self.deleteButton];
    }
}

#pragma mark - getters

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 270, 40)];
            label.font = [UIFont systemFontOfSize:15];
            label.textColor = [UIColor blackColor];
            label.numberOfLines = 2;
            label.lineBreakMode = NSLineBreakByTruncatingTail;
            label;
        });
    }
    return _titleLabel;
}

- (UILabel *)soureceLabel
{
    if (!_soureceLabel) {
        _soureceLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, 50, 20)];
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = [UIColor grayColor];
            label;
        });
    }
    return _soureceLabel;
}

- (UILabel *)commentLabel
{
    if (!_commentLabel) {
        _commentLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 70, 50, 20)];
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = [UIColor grayColor];
            label;
        });
    }
    return _commentLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(150, 70, 50, 20)];
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = [UIColor grayColor];
            label;
        });
    }
    return _timeLabel;
}

- (UIImageView *)rightImageView
{
    if (!_rightImageView) {
        _rightImageView = ({
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(300, 15, 100, 70)];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView;
        });
    }
    return _rightImageView;
}

- (UIButton *)deleteButton
{
    if (!_deleteButton) {
        _deleteButton = ({
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(290, 80, 30, 20)];
//            button.backgroundColor = [UIColor blueColor];
            [button setTitle:@"X" forState:UIControlStateNormal];
            [button setTitle:@"V" forState:UIControlStateHighlighted];
            button.layer.cornerRadius = 10;
            button.layer.masksToBounds = YES;
            button.layer.borderColor = [UIColor lightGrayColor].CGColor;
            button.layer.borderWidth = 2;
            [button addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _deleteButton;
}

@end
