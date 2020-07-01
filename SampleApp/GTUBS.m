//
//  GTUBS.m
//  SampleApp
//
//  Created by mengtuosun on 2020/6/14.
//  Copyright © 2020 mengtuosun. All rights reserved.
//

#import "GTUBS.h"

@interface GTUBS ()

@property(nonatomic, strong, readwrite) NSMutableArray* accessPathArray;

@end

@implementation GTUBS

static GTUBS* _sharedInstance = nil;

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init] ;
    }) ;
    return _sharedInstance ;
}

- (NSMutableArray *)accessPathArray
{
    if (!_accessPathArray) {
        _accessPathArray = [[NSMutableArray alloc]init];
    }
    return  _accessPathArray;
}

- (void)addPage:(NSString*)page
{
    [self.accessPathArray addObject:page];
}

- (void)removePage
{
    [self.accessPathArray removeLastObject];
}

- (void)printPagePath
{
    NSString* pagePath = nil;
    for (NSString* page in self.accessPathArray) {
        pagePath =  [NSString stringWithFormat:@"%@ --> %@", pagePath,page];
    }
    NSLog(@"%@", pagePath);
}

//+ (instancetype)allocWithZone:(struct _NSZone *)zone
//{
//    return [self sharedInstance];
//}

@end
