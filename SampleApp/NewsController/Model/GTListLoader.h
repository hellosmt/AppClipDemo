//
//  GTListLoader.h
//  SampleApp
//
//  Created by mengtuosun on 2020/6/14.
//  Copyright © 2020 mengtuosun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class GTListItem;
@interface GTListLoader : NSObject

typedef void (^GTListLoadFinishBlock)(BOOL success, NSArray<GTListItem *> *itemArray);

- (void)loadDataWithFinishBlock:(GTListLoadFinishBlock)block;

@end

NS_ASSUME_NONNULL_END
