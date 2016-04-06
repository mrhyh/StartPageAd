//
//  PM2d5Model.h
//  ADWelecomePage
//
//  Created by haorise on 15-12-8.
//  Copyright (c) 2015年 rise's company. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface PM2d5Model : NSObject

@property(nonatomic,copy)NSString *nbg1;

/** 这个是真正的背景图*/
@property(nonatomic,copy)NSString *nbg2;

@property(nonatomic,copy)NSString *aqi;

@property(nonatomic,copy)NSString *pm2_5;



@end
