//
//  NetworkTools.h
//  ADWelecomePage
//
//  Created by haorise on 15-12-3.
//  Copyright (c) 2015年 rise's company. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface NetworkTools : AFHTTPSessionManager

+ (instancetype)sharedNetworkTools;

+ (instancetype)sharedNetworkToolsWithoutUrl;

@end
