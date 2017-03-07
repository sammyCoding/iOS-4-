//
//  ViewController.m
//  Hypnosister
//
//  Created by Zeon Waa on 3/7/17.
//  Copyright © 2017 Zeon Waa. All rights reserved.
//

#import "ViewController.h"
#import "ZWAHypnosisView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)setupViews {
    ZWAHypnosisView *firstView = [[ZWAHypnosisView alloc]init];
    ZWAHypnosisView *secondView = [[ZWAHypnosisView alloc]init];

    
//    firstView.backgroundColor = [UIColor redColor];
    firstView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:firstView];
    
    NSDictionary *viewsMap = @{@"redView": firstView,@"blueView":secondView};
    
//    NSArray *firstViewHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[redView(==200)]" options:0 metrics:nil views:viewsMap];
//    NSArray *firstViewVConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[redView(==250)]" options:0 metrics:nil views:viewsMap];
//    [self.view addConstraints:firstViewHConstraints];
//    [self.view addConstraints:firstViewVConstraints];
    
    
    NSArray *firstViewHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[redView]-0-|" options:0 metrics:nil views:viewsMap];
    NSArray *firstViewVConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[redView]-0-|" options:0 metrics:nil views:viewsMap];
    [self.view addConstraints:firstViewHConstraints];
    [self.view addConstraints:firstViewVConstraints];
    
    /*
    secondView.backgroundColor = [UIColor blueColor];
    secondView.translatesAutoresizingMaskIntoConstraints = NO;
    [firstView addSubview:secondView];
    
    NSArray *secondViewHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[blueView(==50)]" options:0 metrics:nil views:viewsMap];
    NSArray *secondViewVConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[blueView(==50)]" options:0 metrics:nil views:viewsMap];
    [firstView addConstraints:secondViewHConstraints];
    [firstView addConstraints:secondViewVConstraints];
    
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
