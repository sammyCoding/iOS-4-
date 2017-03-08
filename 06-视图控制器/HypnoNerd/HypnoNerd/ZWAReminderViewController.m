//
//  ZWAReminderViewController.m
//  HypnoNerd
//
//  Created by Zeon Waa on 3/7/17.
//  Copyright © 2017 Zeon Waa. All rights reserved.
//

#import "ZWAReminderViewController.h"

@interface ZWAReminderViewController ()

@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;

@end

@implementation ZWAReminderViewController

//initWithNibName方法不应该访问view或view的任何子视图。
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UITabBarItem *tbi = self.tabBarItem;
        tbi.title = @"Reminder";
        UIImage *i = [UIImage imageNamed:@"Time.png"];
        tbi.image = i;
    }
    return self;
}

//凡是和view和view的子视图有关的初始化代码，都应该在viewDidLoad方法中实现。
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@ loaded its view.", NSStringFromClass(self.class));

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:60];
}

#pragma mark - action methods

- (IBAction)addReminder:(id)sender {
    //获取当前系统的准确事件(+8小时)
    NSDate *date = self.datePicker.date;
    NSLog(@"Setting a reminder for %@", date);
    
    //本地通知 ios8后要在didFinish注册registerUserNotificationSettings
    UILocalNotification *note = [[UILocalNotification alloc]init];
    note.alertBody = @"Hypnotize me!";
    note.alertTitle = @"title";
    note.fireDate = date;
    note.timeZone = [NSTimeZone systemTimeZone];
    
    [[UIApplication sharedApplication] scheduleLocalNotification:note];
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
