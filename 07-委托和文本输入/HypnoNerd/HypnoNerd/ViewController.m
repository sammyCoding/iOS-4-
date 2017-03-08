//
//  ViewController.m
//  HypnoNerd
//
//  Created by Zeon Waa on 3/7/17.
//  Copyright © 2017 Zeon Waa. All rights reserved.
//

#import "ViewController.h"
#import "ZWAHypnosisView.h"



@interface ViewController ()<UITextFieldDelegate>

@end

@implementation ViewController

/*
 目标-动作的工作方式为：当某个特定的事件发生时（例如按下按钮）,发生事件的一方会向指定的目标对象发送一个之前设定好的动作消息。
 
 协议：
    1.协议不是类，只是一组方法声明。不能为协议创建对象，或者添加实例变量。协议自身不会实现方法，需要由遵守协议的类来实现。
    2.协议所声明的方法可以是必需的或是可选的。协议方法默认都是必需的。使用@optional指令，可以将写在该指令之后的方法全部声明为可选的。
    3.发送方在发送可选方法前，会先向其委托发送另一个名为 respondsToSelector: 的消息。所有Objective-C对象都从NSObject继承了 respondsToSelector: 方法，该方法能在运行时检查对象是否实现了指定的方法。@selector()指令可以将选择器（selector）转换成数值，以便将其作为参数进行传递。
 
 
 
 
 */

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
    [self setupTextField];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTextField {
    UIView *selfView = self.view;
    UITextField *textField = [[UITextField alloc]init];
    textField.borderStyle = UITextBorderStyleRoundedRect;//default none
    textField.placeholder = @"Hypnotize me";
    textField.returnKeyType = UIReturnKeyDone;
    textField.delegate = self;
    textField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:textField];
    
    NSDictionary *viewsMap = NSDictionaryOfVariableBindings(textField,selfView);
    
    NSArray *textFieldHConstraints =  [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[textField]-|" options:0 metrics:nil views:viewsMap];
    NSArray *textFieldVConstraints =  [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-70-[textField(==30)]" options:0 metrics:nil views:viewsMap];
    [self.view addConstraints:textFieldHConstraints];
    [self.view addConstraints:textFieldVConstraints];


}

- (void)drawHypnoticMessage:(NSString *)message {
    for (int i = 0; i < 20; i++) {
        UILabel *messageLabel = [[UILabel alloc]init];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.text = message;
        
        [messageLabel sizeToFit];
        
        int width = (int)(self.view.bounds.size.width - messageLabel.bounds.size.width);
        int x = arc4random() % width;
        
        int height = (int)(self.view.bounds.size.height - messageLabel.bounds.size.height);
        int y = arc4random() % height;
        
        CGRect frame = messageLabel.frame;
        frame.origin = CGPointMake(x, y);
        messageLabel.frame = frame;
        [self.view addSubview:messageLabel];
        
        //为label分别添加水平和垂直方向的视差效果
        UIInterpolatingMotionEffect *motionEffect;
        motionEffect = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"centerx" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        [messageLabel addMotionEffect:motionEffect];
        
        motionEffect = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        [messageLabel addMotionEffect:motionEffect];
    }

}

#pragma mark - textField delegate methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"%@", textField.text);
    [self drawHypnoticMessage:textField.text];
    textField.text = @"";
    [textField resignFirstResponder];
    return YES;
}



@end
