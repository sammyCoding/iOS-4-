//
//  ZWAImageViewController.m
//  Homepwner
//
//  Created by Zeon Waa on 3/10/17.
//  Copyright © 2017 Zeon Waa. All rights reserved.
//

#import "ZWAImageViewController.h"

@interface ZWAImageViewController ()

@end

@implementation ZWAImageViewController

- (void)loadView {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.view = imageView;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    UIImageView *imageView = (UIImageView *)self.view;
    imageView.image = self.image;

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
