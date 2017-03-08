//
//  ZWAItemStore.h
//  Homepwner
//
//  Created by Zeon Waa on 3/8/17.
//  Copyright © 2017 Zeon Waa. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZWAItem;

@interface ZWAItemStore : NSObject

//外部用的数组，只能访问
@property (nonatomic, readonly) NSArray *allItems;

+ (instancetype)sharedStore;
- (ZWAItem *)createItem;
@end
