//
//  GTUBS.h
//  SampleApp
//
//  Created by mengtuosun on 2020/6/14.
//  Copyright © 2020 mengtuosun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTUBS : NSObject

+ (instancetype)sharedInstance;

- (void)addPage:(NSString*)page;

- (void)removePage;

- (void)printPagePath;

@end

NS_ASSUME_NONNULL_END
