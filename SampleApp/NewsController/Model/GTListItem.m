//
//  GTListItem.m
//  SampleApp
//
//  Created by mengtuosun on 2020/6/14.
//  Copyright © 2020 mengtuosun. All rights reserved.
//

#import "GTListItem.h"

@implementation GTListItem


- (void)configWithDictionary:(NSDictionary *)dict
{
#warning 类型判断
    self.category = [dict objectForKey:@"category"];
    self.picUrl = [dict objectForKey:@"thumbnail_pic_s"];
    self.uniqueKey = [dict objectForKey:@"uniquekey"];
    self.title = [dict objectForKey:@"title"];
    self.date = [dict objectForKey:@"date"];
    self.authorName = [dict objectForKey:@"author_name"];
    self.articleUrl = [dict objectForKey:@"url"];
}

@end
