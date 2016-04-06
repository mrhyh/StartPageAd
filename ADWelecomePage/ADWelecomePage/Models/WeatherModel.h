//
//  WeatherModel.h
//  ADWelecomePage
//
//  Created by haorise on 15-12-8.
//  Copyright (c) 2015年 rise's company. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PM2d5Model.h"
#import "BaseModel.h"

@interface WeatherModel : NSObject

@property(nonatomic,strong)NSArray *detailArray;
@property(nonatomic,strong)PM2d5Model *pm2d5;
@property(nonatomic,copy)NSString *dt;
@property(nonatomic,assign)int rt_temperature;

@end
