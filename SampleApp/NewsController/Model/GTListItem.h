//
//  GTListItem.h
//  SampleApp
//
//  Created by mengtuosun on 2020/6/14.
//  Copyright © 2020 mengtuosun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN



/// 新闻列表对象
@interface GTListItem : NSObject

@property(nonatomic, copy, readwrite) NSString* category;
@property(nonatomic, copy, readwrite) NSString* picUrl;
@property(nonatomic, copy, readwrite) NSString* uniqueKey;
@property(nonatomic, copy, readwrite) NSString* title;
@property(nonatomic, copy, readwrite) NSString* date;
@property(nonatomic, copy, readwrite) NSString* authorName;
@property(nonatomic, copy, readwrite) NSString* articleUrl;

- (void)configWithDictionary:(NSDictionary*)dict;

@end

NS_ASSUME_NONNULL_END
