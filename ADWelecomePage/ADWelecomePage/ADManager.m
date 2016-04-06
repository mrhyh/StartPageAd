//
//  ADManager.m
//  ADWelecomePage
//
//  Created by haorise on 15-12-3.
//  Copyright (c) 2015年 rise's company. All rights reserved.
//

#import "ADManager.h"
#import "NetworkTools.h"

#define kCachedCurrentImage ([[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingString:@"/adcurrent.png"])
#define kCachedNewImage     ([[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingString:@"/adnew.png"])

@interface ADManager()

+ (void)downloadImage:(NSString *)imageUrl;

@end

@implementation ADManager

+ (BOOL)isShouldDisplayAd{
    return ([[NSFileManager defaultManager] fileExistsAtPath:kCachedCurrentImage isDirectory:NULL] || [[NSFileManager defaultManager] fileExistsAtPath:kCachedNewImage isDirectory:NULL]);
}

+ (UIImage *)getAdImage{
    if ([[NSFileManager defaultManager] fileExistsAtPath:kCachedNewImage isDirectory:NULL]) {
        [[NSFileManager defaultManager] removeItemAtPath:kCachedCurrentImage error:nil];
        [[NSFileManager defaultManager] moveItemAtPath:kCachedNewImage toPath:kCachedCurrentImage error:nil];
    }
    return [UIImage imageWithData:[NSData dataWithContentsOfFile:kCachedCurrentImage]];
}

+ (void)downloadImage:(NSString *)imageUrl{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:imageUrl]];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data) {
            [data writeToFile:kCachedNewImage atomically:YES];
            NSLog(@"图片下载成功");
        }
        
    }];
    [task resume];
}


+ (void)loadLatestAdImage{
    NSInteger now = [[[NSDate alloc] init] timeIntervalSince1970];
    NSString *path = [NSString stringWithFormat:@"http://g1.163.com/madr?app=7A16FBB6&platform=ios&category=startup&location=1&timestamp=%ld",(long)now];
    [[[NetworkTools sharedNetworkToolsWithoutUrl] GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *adArray = [responseObject valueForKey:@"ads"];
        NSString *imgUrl = adArray[0][@"res_url"][0];
        NSString *imgUrl2 = nil;
        if (adArray.count > 1) {
            imgUrl2 = adArray[1][@"res_url"][0];
        }
        BOOL one = [[NSUserDefaults standardUserDefaults]boolForKey:@"one"];
        if (imgUrl2.length > 0) {
            if (one) {
                [self downloadImage:imgUrl];
                [[NSUserDefaults standardUserDefaults]setBool:!one forKey:@"one"];
            }else{
                [self downloadImage:imgUrl2];
                [[NSUserDefaults standardUserDefaults]setBool:!one forKey:@"one"];
            }
        }else{
            [self downloadImage:imgUrl];
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }] resume];
}




@end
