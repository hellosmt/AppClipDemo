//
//  CoreAnimationTestViewController.m
//  SampleApp
//
//  Created by mengtuosun on 2020/6/26.
//  Copyright © 2020 mengtuosun. All rights reserved.
//

#import "CoreAnimationTestViewController.h"

@interface CoreAnimationTestViewController ()

@property(nonatomic, strong)UIView* layerView1;
@property(nonatomic, strong)UIView* layerView2;
@property(nonatomic, strong)UIView* shadowView;

@end

@implementation CoreAnimationTestViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"动画";
        self.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/home@2x.png"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle/home_selected@2x.png"];
        self.navigationItem.title = @"动画";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.layerView1];
    [self.view addSubview:self.shadowView];
    [self.view addSubview:self.layerView2];
    
    [self testMask];
//    [self testTransform];
    [self test3D];
    
    // Do any additional setup after loading the view.
}

-(void)testMask
{
    CALayer* maskLayer = [CALayer layer];
    maskLayer.frame = self.layerView1.bounds;
    UIImage* maskImage = [UIImage imageNamed:@"icon.bundle/home@2x.png"];
    maskLayer.contents = (__bridge id)maskImage.CGImage;
    
    self.layerView1.layer.mask = maskLayer;
}

-(void)testTransform
{
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformScale(transform, 0.5, 0.5);
    transform = CGAffineTransformRotate(transform, M_PI_4);
    transform = CGAffineTransformTranslate(transform, 0, 200);
    self.layerView2.layer.affineTransform = transform;
    self.shadowView.layer.affineTransform = transform;
}

-(void)test3D
{
//    CATransform3D transform = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0/100.0;
    transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
    
    self.layerView2.layer.transform = transform;
    self.shadowView.layer.transform = transform;
}

- (UIView *)layerView1
{
    if (!_layerView1) {
        _layerView1 = [[UIView alloc]initWithFrame:CGRectMake(100, 300, 100, 100)];
        _layerView1.backgroundColor = [UIColor whiteColor];
        UIView* view = [[UIView alloc]initWithFrame:CGRectMake(-50, -50, 100, 100)];
        view.backgroundColor = [UIColor blueColor];
        [_layerView1 addSubview:view];
        _layerView1.layer.cornerRadius = 20.0f;
    }
    return _layerView1;
}

- (UIView *)layerView2
{
    if (!_layerView2) {
        _layerView2 = [[UIView alloc]initWithFrame:CGRectMake(300, 300, 100, 100)];
        _layerView2.backgroundColor = [UIColor redColor];
        UIView* view = [[UIView alloc]initWithFrame:CGRectMake(-50, -50, 100, 100)];
        view.backgroundColor = [UIColor blueColor];
        [_layerView2 addSubview:view];
        _layerView2.layer.cornerRadius = 20.0f;
        _layerView2.layer.masksToBounds = YES;
        
//        _layerView2.layer.shadowOpacity = 0.5f;
//        _layerView2.layer.shadowOffset = CGSizeMake(0.0f, 3.0f);
//        _layerView2.layer.shadowRadius = 5.0f;
        
        _layerView2.layer.borderWidth = 5.0f;
    }
    return _layerView2;
}

- (UIView *)shadowView
{
    if (!_shadowView) {
        _shadowView = [[UIView alloc] initWithFrame:CGRectMake(300, 300, 100, 100)];
        _shadowView.backgroundColor = [UIColor whiteColor];
        _shadowView.layer.shadowOpacity = 0.5f;
        _shadowView.layer.shadowOffset = CGSizeMake(0.0f, 3.0f);
        _shadowView.layer.shadowRadius = 5.0f;
        
        _shadowView.layer.cornerRadius = 20.0f;
    }
    return _shadowView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
