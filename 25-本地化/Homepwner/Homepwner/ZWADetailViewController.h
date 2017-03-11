//
//  ZWADetailViewController.h
//  Homepwner
//
//  Created by Zeon Waa on 3/8/17.
//  Copyright © 2017 Zeon Waa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZWAItem;

@interface ZWADetailViewController : UIViewController<UIViewControllerRestoration>

@property (nonatomic, strong) ZWAItem *item;
@property (nonatomic, copy) void (^dismissBlock)(void);

- (instancetype)initForNewItem:(BOOL)isNew;

@end
