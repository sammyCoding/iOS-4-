//
//  ZWAItem.h
//  RandomItems
//
//  Created by Zeon Waa on 3/7/17.
//  Copyright © 2017 Zeon Waa. All rights reserved.
//

#import <Foundation/Foundation.h>

//接口文件
/*  前缀@开头的是Objective-C特有的关键字
    Objective-C只允许单继承，所有的类只有一个父类
 
 instancetype只能用来表示方法返回类型，但是id还可以用来表示变量和方法参数的类型
 
 实例变量-类方法-初始化方法-其他方法
 
*/
@interface ZWAItem : NSObject
/*
{
    //实例变量
    NSString *_itemName;
    NSString *_serialNumber;
    int _valueInDollars;
    NSDate *_dateCreated;
    
    //演示强引用
    ZWAItem *_containedItem;
    __weak ZWAItem *_container;
}
*/

// @property (nonatomic, readwrite, strong) NSString *itemName;

@property (nonatomic, strong) ZWAItem *containedItem;
@property (nonatomic, weak) ZWAItem *container;

@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *serialNumber;
@property (nonatomic) int valueInDollars; //默认 unsafe_unretained

@property (nonatomic, readonly, strong) NSDate *dateCreated;


+ (instancetype)randomItem;

- (instancetype)initWithItemName:(NSString *)name
                  valueInDollars:(int)value
                    serialNumber:(NSString *)sNumber;

- (instancetype)initWithItemName:(NSString *)name;

/*
- (void)setContainedItem:(ZWAItem *)item;
- (ZWAItem *)containedItem;

- (void)setContainer:(ZWAItem *)item;
- (ZWAItem *)container;

- (void)setItemName:(NSString *)str;
- (NSString *)itemName;

- (void)setSerialNumber:(NSString *)str;
- (NSString *)serialNumber;

- (void)setValueInDollars:(int)v;
- (int)valueInDollars;

- (NSDate *)dateCreated;
*/

@end
