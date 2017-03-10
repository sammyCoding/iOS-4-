//
//  ZWAWebViewController.m
//  Nerdfeed
//
//  Created by Zeon Waa on 3/10/17.
//  Copyright © 2017 Zeon Waa. All rights reserved.
//

#import "ZWAWebViewController.h"

@interface ZWAWebViewController ()

@end

@implementation ZWAWebViewController

- (void)loadView {
    UIWebView *webView = [[UIWebView alloc]  init];
    webView.scalesPageToFit = YES;
    self.view = webView;

}

- (void)setUrl:(NSURL *)url {

    _url = url;
    if (_url) {
        NSURLRequest *req = [[NSURLRequest alloc] initWithURL:_url];
        [(UIWebView *)self.view loadRequest:req];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
