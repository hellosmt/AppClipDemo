//
//  UIViewController+Tracking.m
//  StackView-Demo
//
//  Created by mengtuosun on 2020/6/10.
//  Copyright © 2020 shangbin. All rights reserved.
//

#import "UIViewController+Tracking.h"
#import "objc/runtime.h"
#import "GTUBS.h"

@interface UIViewController ()

@property(nonatomic, strong) NSNumber* initialBeginTime;
@property(nonatomic, strong) NSNumber* viewWillAppearTime;

@end

@implementation UIViewController (Tracking)

+ (void)load
{
//    NSLog(@"!!!!!!!%@", self);
//    NSLog(@"-------%@", [self class]);
//    // 是否是元类
//    NSLog(@"is %s a meta-class", class_isMetaClass(self) ? "" : "not");
    [self replaceSelector:@selector(viewWillAppear:) bySelector:@selector(hook_viewWillAppear:)];
    [self replaceSelector:@selector(viewDidAppear:) bySelector:@selector(hook_viewDidAppear:)];
    [self replaceSelector:@selector(initWithNibName:bundle:) bySelector:@selector(hook_initWithNibName:bundle:)];
    [self replaceSelector:@selector(viewDidLoad) bySelector:@selector(hook_viewDidLoad)];
    [self replaceSelector:@selector(viewWillDisappear:) bySelector:@selector(hook_viewWillDisappear:)];
}

+ (void)replaceSelector:(SEL)originalSelector bySelector:(SEL)swizzlingSelector
{
    Class cls = [self class];
    Method originalMethod = class_getInstanceMethod(cls, originalSelector);
    Method swizzlingMethod = class_getInstanceMethod(cls, swizzlingSelector);
    BOOL isAddMethod = class_addMethod(cls, originalSelector, method_getImplementation(swizzlingMethod), method_getTypeEncoding(swizzlingMethod));
    if (isAddMethod) {
        class_replaceMethod(cls, swizzlingSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzlingMethod);
    }
}

- (void)hook_viewWillAppear:(BOOL)animated
{
    self.viewWillAppearTime = [NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]];
    [[GTUBS sharedInstance] addPage:[self pageEventId:YES]];
    [[GTUBS sharedInstance] printPagePath];
//    NSLog(@"%@",[self pageEventId:YES]);
    [self hook_viewWillAppear:animated];
}

- (void)hook_viewDidAppear:(BOOL)animated
{
    [self hook_viewDidAppear:animated];
    NSTimeInterval endTime = [[NSDate date] timeIntervalSince1970];
//    NSLog(@"%@ 页面展示耗时：%f ms", [self class] ,(endTime- [self.viewWillAppearTime doubleValue])*1000.0);
}

- (void)hook_viewWillDisappear:(BOOL)animated
{
    [[GTUBS sharedInstance] addPage:[self pageEventId:NO]];
//    NSLog(@"%@",[self pageEventId:NO]);
    [self hook_viewWillDisappear:animated];
}

- (instancetype)hook_initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self.initialBeginTime = [NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]];
    return [self hook_initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}

- (void)hook_viewDidLoad
{
    [self hook_viewDidLoad];
    NSTimeInterval endTime = [[NSDate date] timeIntervalSince1970];
//    NSLog(@"%@ 初始化耗时：%f ms", [self class],(endTime - [self.initialBeginTime doubleValue])*1000.0);
}

#pragma mark - inject

- (NSString*) pageEventId:(BOOL)bEnterPage
{
    NSString* selfClassName = NSStringFromClass([self class]);
    NSString* pageEventId = [NSString stringWithFormat:@"%@_%@", selfClassName, bEnterPage ? @"Enetr" : @"Leave" ];
    return pageEventId;
}

#pragma mark - property

- (void)setInitialBeginTime:(NSNumber *)initialBeginTime
{
    objc_setAssociatedObject(self, @selector(initialBeginTime), initialBeginTime, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber*)initialBeginTime
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setViewWillAppearTime:(NSNumber *)viewWillAppearTime
{
    objc_setAssociatedObject(self, @selector(viewWillAppearTime), viewWillAppearTime, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)viewWillAppearTime
{
    return objc_getAssociatedObject(self, _cmd);
}

@end
