//
//  BaseModel.m
//  ADWelecomePage
//
//  Created by haorise on 15-12-8.
//  Copyright (c) 2015年 rise's company. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

+ (instancetype)modelWithDictionary: (NSDictionary *) data{
    
    return [[self alloc] initWithDictionary:data];
    
}

- (instancetype)initWithDictionary: (NSDictionary *) data{
    self = [super init];
    if (self) {
        [self assginToPropertyWithDictionary:data];
    }
    return self;
}

/************************************************************************
 *把字典赋值给当前实体类的属性
 *参数：字典
 *适用情况：当网络请求的数据的key与实体类的属性相同时可以通过此方法吧字典的Value
 *        赋值给实体类的属性
 ************************************************************************/

-(void) assginToPropertyWithDictionary: (NSDictionary *) data{
    
    if (data == nil) {
        return;
    }
    
    ///1.获取字典的key
    NSArray *dicKey = [data allKeys];
    
    ///2.循环遍历字典key, 并且动态生成实体类的setter方法，把字典的Value通过setter方法
    ///赋值给实体类的属性
    for (int i = 0; i < dicKey.count; i ++) {
        
        ///2.1 通过getSetterSelWithAttibuteName 方法来获取实体类的set方法
        SEL setSel = [self creatSetterWithPropertyName:dicKey[i]];
        
        if ([self respondsToSelector:setSel]) {
            ///2.2 获取字典中key对应的value
            
            NSString  *value = [NSString stringWithFormat:@"%@", data[dicKey[i]]];
            ///2.3 把值通过setter方法赋值给实体类的属性
            [self performSelectorOnMainThread:setSel
                                   withObject:value
                                waitUntilDone:[NSThread isMainThread]];
        }
        
    }
    
}


#pragma mark -- 通过字符串来创建该字符串的Setter方法，并返回
- (SEL) creatSetterWithPropertyName: (NSString *) propertyName{
    
    //1.首字母大写
    propertyName = propertyName.capitalizedString;
    
    //2.拼接上set关键字
    propertyName = [NSString stringWithFormat:@"set%@:", propertyName];
    
    //3.返回set方法
    return NSSelectorFromString(propertyName);
}


@end
