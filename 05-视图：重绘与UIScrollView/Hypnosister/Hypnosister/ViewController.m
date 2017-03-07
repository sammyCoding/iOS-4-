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
   // [self setupViews];
    [self setupScrollView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)setupViews {
    ZWAHypnosisView *firstView = [[ZWAHypnosisView alloc]init];
    ZWAHypnosisView *secondView = [[ZWAHypnosisView alloc]init];
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    UIView *container = [[UIView alloc]init];
    UIView *selfView = self.view;

    
    NSDictionary *viewsMap = @{@"redView": firstView,@"blueView":secondView, @"container": container, @"selfView": selfView, @"scroll": scrollView};

    
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:scrollView];
    //1.scrollView与scrollView的superview的约束关系用来确定scrollView的frame
    
    NSArray *scrollHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[scroll]-0-|" options:0 metrics:nil views:viewsMap];
    NSArray *scrollVConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[scroll]-0-|" options:0 metrics:nil views:viewsMap];
    [self.view addConstraints:scrollHConstraints];
    [self.view addConstraints:scrollVConstraints];
    
    
    
    container.translatesAutoresizingMaskIntoConstraints = NO;
    [scrollView addSubview:container];
    //2.scrollView中的[contentView]的约束关系用来确定scrollView的contentInsets
    NSArray *containerHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[container]-0-|" options:0 metrics:nil views:viewsMap];
     NSArray *containerVConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[container]-0-|" options:0 metrics:nil views:viewsMap];
    [scrollView addConstraints:containerHConstraints];
    [scrollView addConstraints:containerVConstraints];
    
    // 3.contentView的宽度和高度用来确定scrollView的contentSize
    //把要显示的view加入到container中，以要加入的view的宽高来确保scrollview的contentSize
    
//    firstView.backgroundColor = [UIColor redColor];
    firstView.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.view addSubview:firstView];
    [container addSubview:firstView];
    
//    NSArray *firstViewHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[redView(==200)]" options:0 metrics:nil views:viewsMap];
//    NSArray *firstViewVConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[redView(==250)]" options:0 metrics:nil views:viewsMap];
//    [self.view addConstraints:firstViewHConstraints];
//    [self.view addConstraints:firstViewVConstraints];
    
    
    NSArray *firstViewHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[redView]-0-|" options:0 metrics:nil views:viewsMap];
    NSArray *firstViewVConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[redView]-0-|" options:0 metrics:nil views:viewsMap];
//    [self.view addConstraints:firstViewHConstraints];
//    [self.view addConstraints:firstViewVConstraints];
    
    NSLayoutConstraint *firstViewWidthConstraint = [NSLayoutConstraint constraintWithItem:firstView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:selfView attribute:NSLayoutAttributeWidth multiplier:2.0 constant:0.0];
    NSLayoutConstraint *firstViewHeightConstraint = [NSLayoutConstraint constraintWithItem:firstView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:selfView attribute:NSLayoutAttributeHeight multiplier:2.0 constant:0.0];
    [selfView addConstraint:firstViewWidthConstraint];
    [selfView addConstraint:firstViewHeightConstraint];
    
    [container addConstraints:firstViewHConstraints];
    [container addConstraints:firstViewVConstraints];
    
    
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

-(void)setupScrollView {
    //一个scrollview显示多个view

    
    ZWAHypnosisView *firstView = [[ZWAHypnosisView alloc]init];
    ZWAHypnosisView *secondView = [[ZWAHypnosisView alloc]init];
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.pagingEnabled = YES;//设置为YES时，scrollview不会停在view的交界处
    UIView *container = [[UIView alloc]init];
    UIView *selfView = self.view;
    
    
    NSDictionary *viewsMap = @{@"redView": firstView,@"blueView":secondView, @"container": container, @"selfView": selfView, @"scroll": scrollView};
    
    
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:scrollView];
    //1.scrollView与scrollView的superview的约束关系用来确定scrollView的frame
    
    NSArray *scrollHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[scroll]-0-|" options:0 metrics:nil views:viewsMap];
    NSArray *scrollVConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[scroll]-0-|" options:0 metrics:nil views:viewsMap];
    [self.view addConstraints:scrollHConstraints];
    [self.view addConstraints:scrollVConstraints];
    
    
    
    container.translatesAutoresizingMaskIntoConstraints = NO;
    [scrollView addSubview:container];
    //2.scrollView中的[contentView]的约束关系用来确定scrollView的contentInsets
    NSArray *containerHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[container]-0-|" options:0 metrics:nil views:viewsMap];
    NSArray *containerVConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[container]-0-|" options:0 metrics:nil views:viewsMap];
    [scrollView addConstraints:containerHConstraints];
    [scrollView addConstraints:containerVConstraints];
    
    // 3.contentView的宽度和高度用来确定scrollView的contentSize
    //把要显示的view加入到container中，以要加入的view的宽高来确保scrollview的contentSize
    
    firstView.translatesAutoresizingMaskIntoConstraints = NO;
    [container addSubview:firstView];
    
    NSArray *firstViewVConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[redView]-0-|" options:0 metrics:nil views:viewsMap];
    
    NSLayoutConstraint *firstViewWidthConstraint = [NSLayoutConstraint constraintWithItem:firstView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:selfView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0];
    NSLayoutConstraint *firstViewHeightConstraint = [NSLayoutConstraint constraintWithItem:firstView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:selfView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0];
    [selfView addConstraint:firstViewWidthConstraint];
    [selfView addConstraint:firstViewHeightConstraint];
    
    [container addConstraints:firstViewVConstraints];
    
    
   
     secondView.translatesAutoresizingMaskIntoConstraints = NO;
     [container addSubview:secondView];
     
     NSArray *secondViewHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[redView]-0-[blueView]-0-|" options:0 metrics:nil views:viewsMap];
     NSArray *secondViewVConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[blueView]-0-|" options:0 metrics:nil views:viewsMap];
     [container addConstraints:secondViewHConstraints];
     [container addConstraints:secondViewVConstraints];
    
    NSLayoutConstraint *secondViewWidthConstraint = [NSLayoutConstraint constraintWithItem:secondView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:selfView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0];
    NSLayoutConstraint *secondViewHeightConstraint = [NSLayoutConstraint constraintWithItem:secondView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:selfView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0];
    [selfView addConstraint:secondViewWidthConstraint];
    [selfView addConstraint:secondViewHeightConstraint];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
