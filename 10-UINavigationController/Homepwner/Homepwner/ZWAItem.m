//
//  ZWAItem.m
//  RandomItems
//
//  Created by Zeon Waa on 3/7/17.
//  Copyright © 2017 Zeon Waa. All rights reserved.
//

#import "ZWAItem.h"

@implementation ZWAItem


+ (instancetype)randomItem {
    NSArray *randomAdjectiveList = @[@"Fluffy", @"Rusty", @"Shiny"];
    NSArray *randomNounList = @[@"Bear", @"Spork", @"Mac"];
    NSInteger adjustiveIndex = arc4random() % [randomAdjectiveList count];
    NSInteger nounIndex = arc4random() % [randomNounList count];
    NSString * randomName = [NSString stringWithFormat:@"%@ %@", randomAdjectiveList[adjustiveIndex], randomNounList[nounIndex]];
    int randomValue = arc4random() % 100;
    NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c",
                                    '0' + arc4random() % 10,
                                    'A' + arc4random() % 26,
                                    '0' + arc4random() % 10,
                                    'A' + arc4random() % 26,
                                    '0' + arc4random() % 10
                                    ];
    ZWAItem *newItem = [[self alloc]initWithItemName:randomName valueInDollars:randomValue serialNumber:randomSerialNumber];
    return newItem;
}

- (instancetype)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber {
    
    self = [super init];
    if (self) {
        _itemName = name;
        _serialNumber = sNumber;
        _valueInDollars = value;
        
        _dateCreated = [[NSDate alloc]init];
        
    }
    return  self;
}

-(instancetype)initWithItemName:(NSString *)name {
    return [self initWithItemName:name valueInDollars:0 serialNumber:@""];
}

- (instancetype)init {
    return [self initWithItemName:@"Item"];
}

//- (void)setContainedItem:(ZWAItem *)containedItem {
//    _containedItem = containedItem;
//    self.containedItem.container = self;
//}

/*
- (void)setContainedItem:(ZWAItem *)item {
    _containedItem = item;
    item.container = self;
}

- (ZWAItem *)containedItem {
    return  _containedItem;
}

- (void)setContainer:(ZWAItem *)item {
    _container = item;
}

- (ZWAItem *)container {
    return _container;
}

- (void)setItemName:(NSString *)str {
    _itemName = str;
}

- (NSString *)itemName {
    return _itemName;
}

- (void)setSerialNumber:(NSString *)str {
    _serialNumber = str;
}

- (NSString *)serialNumber {
    return _serialNumber;
}

- (void)setValueInDollars:(int)v {
    _valueInDollars = v;
}

- (int)valueInDollars {
    return _valueInDollars;
}

- (NSDate *)dateCreated {
    return _dateCreated;
}

*/

-(NSString *)description {
    NSString *descriptionString = [[NSString alloc]initWithFormat:@"%@(%@):Worth $%d, record on %@",self.itemName,self.serialNumber,self.valueInDollars,self.dateCreated ];
    return descriptionString;
}

-(void)dealloc {

    NSLog(@"Destroyed: %@",self);
}

@end
