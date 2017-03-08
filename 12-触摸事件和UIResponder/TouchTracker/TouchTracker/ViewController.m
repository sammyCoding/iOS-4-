//
//  ViewController.m
//  TouchTracker
//
//  Created by Zeon Waa on 3/8/17.
//  Copyright © 2017 Zeon Waa. All rights reserved.
//

#import "ViewController.h"
#import "ZWADrawView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)loadView {
    ZWADrawView *dv = [[ZWADrawView alloc] init];
    self.view = dv;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
