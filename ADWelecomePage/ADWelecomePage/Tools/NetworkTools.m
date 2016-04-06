//
//  NetworkTools.m
//  ADWelecomePage
//
//  Created by haorise on 15-12-3.
//  Copyright (c) 2015年 rise's company. All rights reserved.
//
#import "NetworkTools.h"

@implementation NetworkTools

+ (instancetype)sharedNetworkTools{
    static NetworkTools *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:@"http://c.m.163.com/"];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        instance = [[self alloc] initWithBaseURL:url sessionConfiguration:config];
        
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
        
    });
    return instance;
}

+ (instancetype)sharedNetworkToolsWithoutUrl{
    static NetworkTools *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:@""];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        instance = [[self alloc] initWithBaseURL:url sessionConfiguration:config];
        
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
        
    });
    return instance;
}



@end
