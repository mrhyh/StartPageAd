//
//  MoreView.h
//  ADWelecomePage
//
//  Created by haorise on 15-12-7.
//  Copyright (c) 2015年 rise's company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherModel.h"

@interface MoreView : UIView
@property (strong, nonatomic) IBOutlet MoreView *picView;

+ (instancetype)view;
- (void)setWeatherModel:(WeatherModel *)weatherModel;
- (void)addAnimate;

@property (strong, nonatomic) IBOutlet UILabel *nowTempure;
@property (strong, nonatomic) IBOutlet UILabel *timeLable;
@property (strong, nonatomic) IBOutlet UILabel *airQuality;
@property (strong, nonatomic) IBOutlet UILabel *weatherLabel;
@property (strong, nonatomic) IBOutlet UILabel *placeLabel;

@end
