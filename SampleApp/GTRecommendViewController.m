//
//  GTRecommendViewController.m
//  SampleApp
//
//  Created by mengtuosun on 2020/6/12.
//  Copyright © 2020 mengtuosun. All rights reserved.
//

#import "GTRecommendViewController.h"

@interface GTRecommendViewController ()<UIScrollViewDelegate>

@property(nonatomic, strong)UIView* layerView;

@end

@implementation GTRecommendViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"推荐";
        self.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/like@2x.png"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle/like_selected@2x.png"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIScrollView* scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 5, self.view.bounds.size.height);
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    NSArray* colors = @[[UIColor redColor], [UIColor greenColor], [UIColor lightGrayColor], [UIColor redColor], [UIColor yellowColor]];
    for (int i = 0; i < 5; i++) {
        UIView* view = [[UIView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width * i, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        [view addSubview:({
            UIView* view = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
            view.backgroundColor = [UIColor greenColor];
            UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewClick)];
            [view addGestureRecognizer:tapGesture];
            view;
        })];
        
        [view.layer addSublayer:({
            CALayer* layer =  [[CALayer alloc] init];
            layer.frame = CGRectMake(300, 300, 100, 100);
            layer.backgroundColor = [UIColor blueColor].CGColor;
            layer;
        })];
        view.backgroundColor = colors[i];
        [scrollView addSubview:view];
    }
    [self.view addSubview:scrollView];
}

# pragma mark - tap
- (void) viewClick
{
    NSLog(@"viewClick");
}

@end
