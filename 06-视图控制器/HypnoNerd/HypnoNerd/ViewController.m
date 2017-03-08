//
//  ViewController.m
//  HypnoNerd
//
//  Created by Zeon Waa on 3/7/17.
//  Copyright © 2017 Zeon Waa. All rights reserved.
//

#import "ViewController.h"
#import "ZWAHypnosisView.h"



@interface ViewController ()

@end

@implementation ViewController

//当self.view为nil时，会调用loaView方法
- (void)loadView {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    ZWAHypnosisView *backgroundView = [[ZWAHypnosisView alloc]init];
    self.view = backgroundView;
}

//先调用init方法再调用initWithNibName再调用loadView
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    NSLog(@"%@",NSStringFromSelector(_cmd));

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"Hypnotize";
        UIImage *i = [UIImage imageNamed:@"Hypno.png"];
        self.tabBarItem.image = i;
    }
    
    return self;
}

- (instancetype)init {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@ loaded its view.", NSStringFromClass(self.class));
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
