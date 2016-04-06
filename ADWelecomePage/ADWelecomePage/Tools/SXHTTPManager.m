//
//  SXHTTPManager.m
//  ADWelecomePage
//
//  Created by haorise on 15-12-3.
//  Copyright (c) 2015年 rise's company. All rights reserved.
//

#import "SXHTTPManager.h"

@implementation SXHTTPManager

+ (instancetype)manager
{
    SXHTTPManager *mgr = [super manager];
    NSMutableSet *mgrSet = [NSMutableSet set];
    mgrSet.set = mgr.responseSerializer.acceptableContentTypes;
    
    [mgrSet addObject:@"text/html"];
    
    mgr.responseSerializer.acceptableContentTypes = mgrSet;
    
    return mgr;
}

@end
