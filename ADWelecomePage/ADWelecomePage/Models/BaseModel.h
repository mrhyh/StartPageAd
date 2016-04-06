//
//  BaseModel.h
//  ADWelecomePage
//
//  Created by haorise on 15-12-8.
//  Copyright (c) 2015年 rise's company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

+ (instancetype)modelWithDictionary: (NSDictionary *) data;

-(void) assginToPropertyWithDictionary: (NSDictionary *) data;
- (SEL) creatSetterWithPropertyName: (NSString *) propertyName;

@end
