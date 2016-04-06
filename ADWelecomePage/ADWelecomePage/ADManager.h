//
//  ADManager.h
//  ADWelecomePage
//
//  Created by haorise on 15-12-3.
//  Copyright (c) 2015年 rise's company. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ADManager : NSObject

+ (BOOL)isShouldDisplayAd;
+ (UIImage *)getAdImage;
+ (void)loadLatestAdImage;

@end
