//
//  AppDelegate.m
//  SampleApp
//
//  Created by mengtuosun on 2020/6/11.
//  Copyright © 2020 mengtuosun. All rights reserved.
//

#import "AppDelegate.h"
#import "GTNewsViewController.h"
#import "GTVideoViewController.h"
#import "GTRecommendViewController.h"
#import "CoreAnimationTestViewController.h"


@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    UITabBarController* tabBarController = [[UITabBarController alloc]init];
    tabBarController.delegate = self;
    
    GTNewsViewController* newsViewController = [[GTNewsViewController alloc]init];

    GTVideoViewController* videoViewController = [[GTVideoViewController alloc]init];

    GTRecommendViewController* recommendViewController = [[GTRecommendViewController alloc]init];

    UIViewController* mineViewController = [[UIViewController alloc]init];
    mineViewController.view.backgroundColor = [UIColor purpleColor];
    mineViewController.tabBarItem.title = @"我的";
    mineViewController.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/home@2x.png"];
    mineViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle/home_selected@2x.png"];
    mineViewController.navigationItem.title = @"jddf";
    
    CoreAnimationTestViewController* controller = [CoreAnimationTestViewController new];

    tabBarController.viewControllers = @[newsViewController, videoViewController, recommendViewController, mineViewController, controller];
    
    UINavigationController* navController = [[UINavigationController alloc]initWithRootViewController:tabBarController];
    
    [self.window setRootViewController:navController];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"did select");
}

@end
