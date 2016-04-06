//
//  RootViewController.m
//  ADWelecomePage
//
//  Created by haorise on 15-12-3.
//  Copyright (c) 2015年 rise's company. All rights reserved.
//

#import "RootViewController.h"
#import "AdManager.h"
#import "MoreView.h"
#import "SXHTTPManager.h"
#import "PM2d5Model.h"
#import "WeatherModel.h"
#import "MJExtension.h"

#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

@interface RootViewController ()

@property (nonatomic,assign) BOOL pageShow;
@property(nonatomic,strong)UIButton *rightItem;
@property (nonatomic, strong)WeatherModel *weatherModel;
@property (nonatomic, strong)MoreView *weatherView;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.pageShow = NO;
    [ADManager loadLatestAdImage];
    
    UIView *adView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    UIImageView *adImg = [[UIImageView alloc]init];
    UIImageView *adBottomImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"adBottom.png"]];
    [adView addSubview:adBottomImg];
    [adView addSubview:adImg];
    
    adBottomImg.frame = CGRectMake(0, SCREENHEIGHT - 135, SCREENWIDTH, 135);
    adImg.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 135);
    if ([ADManager isShouldDisplayAd]) {
        adImg.image = [ADManager getAdImage];
    }else{
        adImg.backgroundColor = RGBColor(246, 246, 246);
    }
    adView.alpha = 0.99f;
    [self.view addSubview:adView];
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
    
    [UIView animateWithDuration:3 animations:^{
        adView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [[UIApplication sharedApplication]setStatusBarHidden:NO];
        [UIView animateWithDuration:0.5 animations:^{
            adView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [adView removeFromSuperview];
            self.navigationController.navigationBarHidden = NO;
        }];
        //继续加载viewdidload中的内容
        [self configurePage];
    }];
}

- (void)configurePage{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"homePagePic"];
    [self.view addSubview:imageView];
    
    UIImageView *titleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 24)];
    titleView.image = [UIImage imageNamed:@"titleImage"];
    self.navigationItem.titleView = titleView;
    
    UIButton *rightItem = [[UIButton alloc]init];
    self.rightItem = rightItem;
    UIWindow *win = [UIApplication sharedApplication].windows.firstObject;
    [win addSubview:rightItem];
    rightItem.y = 20;
    rightItem.width = 45;
    rightItem.height = 45;
    [rightItem addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    rightItem.x = [UIScreen mainScreen].bounds.size.width - rightItem.width;
    NSLog(@"%@",NSStringFromCGRect(rightItem.frame));
    [rightItem setImage:[UIImage imageNamed:@"top_navigation_square"] forState:UIControlStateNormal];

    
    [self sendWeatherRequest];
    
}


- (void)sendWeatherRequest
{
    NSString *url = @"http://c.3g.163.com/nc/weather/5YyX5LqsfOWMl%2BS6rA%3D%3D.html";
    [[SXHTTPManager manager]GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        WeatherModel *model = [WeatherModel objectWithKeyValues:responseObject];
        self.weatherModel = model;
        [self addWeather];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure %@",error);
    }];
}

- (void)addWeather{
    self.weatherView = [MoreView view];
    self.weatherView.frame = [[UIScreen mainScreen] bounds];
    self.weatherView.y = 64;
    self.weatherView.height -= 64;
    self.weatherView.alpha = 0.9;
    [self.weatherView setWeatherModel:self.weatherModel];
    self.weatherView.hidden = YES;
    UIWindow *win = [UIApplication sharedApplication].windows.firstObject;
    [win addSubview:self.weatherView];
}


- (void)rightItemClick{
    if (!self.pageShow) {
        self.weatherView.hidden = NO;
        [self.weatherView addAnimate];
        [self.rightItem setImage:[UIImage imageNamed:@"223"] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.2 animations:^{
            self.rightItem.transform = CGAffineTransformRotate(self.rightItem.transform, -M_1_PI * 6);
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.1 animations:^{
                self.rightItem.transform = CGAffineTransformRotate(self.rightItem.transform, M_1_PI );
            }];
        }];
    }else{
        self.weatherView.hidden = YES;
        [UIView animateWithDuration:0.1 animations:^{
            self.rightItem.transform = CGAffineTransformRotate(self.rightItem.transform, M_1_PI * 5);
            
        } completion:^(BOOL finished) {
            [self.rightItem setImage:[UIImage imageNamed:@"top_navigation_square"] forState:UIControlStateNormal];
        }];
    }
    self.pageShow = !self.pageShow;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
