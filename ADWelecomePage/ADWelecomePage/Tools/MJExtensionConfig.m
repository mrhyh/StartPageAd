//
//  MJExtensionConfig.m
//  ADWelecomePage
//
//  Created by haorise on 15-12-8.
//  Copyright (c) 2015年 rise's company. All rights reserved.
//

#import "MJExtensionConfig.h"
#import "MJExtension.h"
#import "WeatherModel.h"

@implementation MJExtensionConfig

+(void)load{
    [WeatherModel setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"detailArray" : @"北京|北京"
                 };
    }];
}

@end
