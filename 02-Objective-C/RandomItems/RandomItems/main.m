//
//  main.m
//  RandomItems
//
//  Created by Zeon Waa on 3/7/17.
//  Copyright © 2017 Zeon Waa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZWAItem.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {

        //p36
    
        NSMutableArray *items = [[NSMutableArray alloc]init];
        [items addObject:@"One"];
        [items addObject:@"Two"];
        [items addObject:@"Three"];
        
        [items insertObject:@"Zero" atIndex:0];
        
        //遍历数组
        //如果需要在循环中添加或删除对象，就不能使用枚举，否则程序会抛出异常。这时只能设置计数器并使用普通的for循环。
        for (NSString *item in items) {
            NSLog(@"%@",item);
        }
        
        // p45
      //  ZWAItem *item = [[ZWAItem alloc]init];
        
//        [item setItemName:@"Red Sofa"];
//        [item setSerialNumber:@"A1B2C"];
//        [item setValueInDollars:100];
        
        //使用点语法存取实例变量
//        item.itemName = @"Red Sofa";
//        item.serialNumber = @"A1B2C";
//        item.valueInDollars = 100;
        
       // NSLog(@"%@  %@  %@  %d",[item itemName],[item dateCreated],[item serialNumber],[item valueInDollars]);
       // NSLog(@"%@  %@  %@  %d",item.itemName,item.dateCreated,item.serialNumber,item.valueInDollars);
        
        // p54
        
//        ZWAItem *item = [[ZWAItem alloc]initWithItemName:@"Red Sofa" valueInDollars:100 serialNumber:@"A1B2C"];
//        NSLog(@"%@", item);
//        
//        ZWAItem *itemWithName = [[ZWAItem alloc]initWithItemName:@"Blue Sofa"];
//        NSLog(@"%@", itemWithName);
//        
//        ZWAItem *itemWithNoName = [[ZWAItem alloc]init];
//        NSLog(@"%@", itemWithNoName);

        for (int i = 0; i < 10; i++) {
            ZWAItem *item = [ZWAItem randomItem];
            [items addObject:item];
        }
        
        for (ZWAItem *item in items) {
            NSLog(@"%@", item);
        }
        
        items = nil;
    }
    return 0;
}
