//
//  AppDelegate.m
//  MySampleAppClip
//
//  Created by mengtuosun on 2020/6/27.
//  Copyright © 2020 mengtuosun. All rights reserved.
//

#import "AppDelegate.h"
#import "GTNewsViewController.h"
#import "CoreAnimationTestViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <StoreKit/StoreKit.h>

@interface AppDelegate ()

@property(nonatomic, strong)UINavigationController* rootViewController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    [self.window setRootViewController:self.rootViewController];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler
{
    if ([userActivity.activityType isEqualToString:NSUserActivityTypeBrowsingWeb]) {
        NSURL* url = userActivity.webpageURL;
        if (url == nil) {
            return YES;
        }
        NSURLComponents* components = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
        if ([components.path isEqualToString:@"/News"]) {
            GTNewsViewController* newsViewController = [[GTNewsViewController alloc]init];
            [self.rootViewController pushViewController:newsViewController animated:NO];
        }else if ([components.path isEqualToString:@"/CoreAnimation"]){
            CoreAnimationTestViewController* controller = [CoreAnimationTestViewController new];
            [self.rootViewController pushViewController:controller animated:NO];
        }
    }
    
//    [self testTemporaryNotification];
    [self testSKOverlayWithMyApp];
//    [self testSKOverlayWithOtherApp];
    
    return YES;
}

- (UINavigationController *)rootViewController
{
    if (!_rootViewController) {
        _rootViewController = [UINavigationController new];
    }
    return _rootViewController;
}

- (void)testTemporaryNotification
{
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            if (settings.authorizationStatus ==UNAuthorizationStatusEphemeral ) {
                NSLog(@"获得临时八小时本地通知授权");
            }
    }];
}

- (void)testSKOverlayWithOtherApp
{
    SKOverlayAppConfiguration* config = [[SKOverlayAppConfiguration alloc] initWithAppIdentifier:@"" position:SKOverlayPositionBottom];
    SKOverlay* overlay = [[SKOverlay alloc]initWithConfiguration:config];
    [overlay presentInScene:self.window.windowScene];
}

- (void)testSKOverlayWithMyApp
{
    SKOverlayAppClipConfiguration* config = [[SKOverlayAppClipConfiguration alloc]initWithPosition:SKOverlayPositionBottomRaised];
    SKOverlay* overlay = [[SKOverlay alloc]initWithConfiguration:config];
    [overlay presentInScene:self.window.windowScene];
}

@end

