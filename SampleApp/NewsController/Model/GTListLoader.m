//
//  GTListLoader.m
//  SampleApp
//
//  Created by mengtuosun on 2020/6/14.
//  Copyright © 2020 mengtuosun. All rights reserved.
//

#import "GTListLoader.h"
#import "GTListItem.h"

@implementation GTListLoader

- (void)loadDataWithFinishBlock:(GTListLoadFinishBlock)block
{
    NSString* urlString = @"http://v.juhe.cn/toutiao/index?type=top&key=97ad001bfcc2082e2eeaf798bad3d54e";
    NSURL* url = [NSURL URLWithString:urlString];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    NSURLSession* session = [NSURLSession sharedSession];
    NSURLSessionTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError* jsonError;
        id jsonObjct = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
#warning 类型检查
        NSDictionary* dict = (NSDictionary*)[[(NSDictionary*)jsonObjct objectForKey:@"result"] objectForKey:@"data"];
        NSMutableArray* itemArray = [[NSMutableArray alloc]init];
        for (NSDictionary* dataDict in dict) {
            GTListItem* item = [[GTListItem alloc]init];
            [item configWithDictionary:dataDict];
            [itemArray addObject:item];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block) {
                block(jsonError == nil, [itemArray copy]);
            };
        });
        
        NSLog(@"");
    }];
    [task resume];
    [self _logSandBoxPath];
 
//    [[AFHTTPSessionManager manager]GET:@"http://www.scut.edu.cn/vpn/" parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"");
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"");
//    }];
}

- (void) _logSandBoxPath
{
    NSArray* array = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString* cachePath = [array firstObject];
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSString* dataPath = [cachePath stringByAppendingPathComponent:@"GTData"];
    NSError* error = nil;
    [fileManager createDirectoryAtPath:dataPath withIntermediateDirectories:YES attributes:nil error:&error];
    
    NSString* listDataPath = [dataPath stringByAppendingPathComponent:@"list"];
    NSData* listData = [@"abc" dataUsingEncoding:NSUTF8StringEncoding];
    [fileManager createFileAtPath:listDataPath contents:listData attributes:nil];
    NSLog(@"");
}

@end
