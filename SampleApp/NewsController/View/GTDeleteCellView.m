//
//  GTDeleteCellView.m
//  SampleApp
//
//  Created by mengtuosun on 2020/6/13.
//  Copyright © 2020 mengtuosun. All rights reserved.
//

#import "GTDeleteCellView.h"

@interface GTDeleteCellView ()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) dispatch_block_t clickBlock;

@end

@implementation GTDeleteCellView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backgroundView];
        [self addSubview:self.deleteButton];
    }
    return self;
}

#pragma mark - action

- (void)clickButton
{
    if (self.clickBlock) {
        self.clickBlock();
    }
    [self dismissDeleteView];
}

#pragma mark - helper

- (void)showDeleteViewFromPoint:(CGPoint)point clickBlock:(dispatch_block_t)clickBlock
{
    self.deleteButton.frame = CGRectMake(point.x, point.y, 0, 0);
    self.clickBlock = [clickBlock copy];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.5 animations:^{
        self.deleteButton.frame = CGRectMake((self.bounds.size.width - 200) / 2, (self.bounds.size.height - 200) / 2, 200, 200);
    }];
}

- (void)dismissDeleteView
{
    [self removeFromSuperview];
}

#pragma mark - Getters

- (UIView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = ({
            UIView *view = [[UIView alloc] initWithFrame:self.bounds];
            view.backgroundColor = [UIColor grayColor];
            view.alpha = 0.5;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDeleteView)];
            [view addGestureRecognizer:tapGesture];
            view;
        });
    }
    return _backgroundView;
}

- (UIButton *)deleteButton
{
    if (!_deleteButton) {
        _deleteButton = ({
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
            button.backgroundColor = [UIColor blueColor];
            [button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _deleteButton;
}

@end
