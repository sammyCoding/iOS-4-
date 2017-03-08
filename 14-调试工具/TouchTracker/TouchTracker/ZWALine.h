//
//  ZWALine.h
//  TouchTracker
//
//  Created by Zeon Waa on 3/8/17.
//  Copyright © 2017 Zeon Waa. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface ZWALine : NSObject

@property (nonatomic) CGPoint begin;
@property (nonatomic) CGPoint end;


//引用循环测试
@property (nonatomic, weak) NSMutableArray *containingArray;

@end
