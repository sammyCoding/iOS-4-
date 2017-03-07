//
//  ViewController.m
//  01-Quiz
//
//  Created by  Zeon Waa on 3/7/17.
//  Copyright © 2017 Zeon Waa. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, weak) UILabel *questionLabel;
@property (nonatomic, weak) UILabel *answerLabel;
@property (nonatomic, weak) UIButton *questionButton;
@property (nonatomic, weak) UIButton *answerButton;

@property (nonatomic, unsafe_unretained) int currentQuestionIndex;
@property (nonatomic, copy) NSArray *questions;
@property (nonatomic, copy) NSArray *answers;

@end

@implementation ViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.questions = @[
                           @"From what is cognac made?",
                           @"What is 7+7?",
                           @"What is the capital of Vermont?"
                           ];
        self.answers = @[
                         @"Grapes",
                         @"14",
                         @"Montpelier"
                         ];
    }
    return self;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - helper methods
- (void)setupViews {
    UILabel *qLabel = [[UILabel alloc]init];
    qLabel.translatesAutoresizingMaskIntoConstraints = NO;
    qLabel.numberOfLines = 0;
    qLabel.backgroundColor = [UIColor lightGrayColor];
    qLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:qLabel];
    self.questionLabel = qLabel;
    
    UILabel *aLabel = [[UILabel alloc]init];
    aLabel.translatesAutoresizingMaskIntoConstraints = NO;
    aLabel.numberOfLines = 0;
    aLabel.backgroundColor = [UIColor lightGrayColor];
    aLabel.textAlignment = NSTextAlignmentCenter;
    aLabel.text = @"???";
    
    [self.view addSubview:aLabel];
    self.answerLabel = aLabel;
    
    UIButton *qButton = [[UIButton alloc]init];
    qButton.translatesAutoresizingMaskIntoConstraints = NO;
    [qButton addTarget:self action:@selector(showQuestion:) forControlEvents:UIControlEventTouchUpInside];
    [qButton setTitle:@"Show Question" forState:UIControlStateNormal];

    qButton.backgroundColor = [UIColor lightGrayColor];

    [self.view addSubview:qButton];
    self.questionButton = qButton;
    
    UIButton *aButton = [[UIButton alloc]init];
    aButton.translatesAutoresizingMaskIntoConstraints = NO;
    [aButton addTarget:self action:@selector(showAnswer:) forControlEvents:UIControlEventTouchUpInside];
    [aButton setTitle:@"Show Answer" forState:UIControlStateNormal];
    aButton.backgroundColor = [UIColor lightGrayColor];

    [self.view addSubview:aButton];
    self.answerButton = aButton;

    NSDictionary *viewsMap = @{
                               @"questionLabel" : self.questionLabel,
                               @"questionButton" : self.questionButton,
                               @"answerLabel" : self.answerLabel,
                               @"answerButton" : self.answerButton
                                };
    
    NSArray *questionLabelHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[questionLabel]-|" options:0 metrics:nil views:viewsMap];
    NSArray *questionButtonHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[questionButton]-|" options:0 metrics:nil views:viewsMap];
    NSArray *answerLabelHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[answerLabel]-|" options:0 metrics:nil views:viewsMap];
    NSArray *answerButtonHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[answerButton]-|" options:0 metrics:nil views:viewsMap];
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[questionLabel(>=40)]-[questionButton]-20-[answerLabel(==questionLabel)]-[answerButton]" options:NSLayoutFormatAlignAllCenterX metrics:nil views:viewsMap];

    [self.view addConstraints:questionLabelHConstraints];
    [self.view addConstraints:questionButtonHConstraints];
    [self.view addConstraints:answerLabelHConstraints];
    [self.view addConstraints:answerButtonHConstraints];
    [self.view addConstraints:verticalConstraints];
    
}


#pragma mark - action methods

- (void)showQuestion:(id)sender {
    self.currentQuestionIndex++;
    
    if (self.currentQuestionIndex == [self.questions count]) {
        self.currentQuestionIndex = 0;
    }

    NSString *question = self.questions[self.currentQuestionIndex];
    self.questionLabel.text = question;
    self.answerLabel.text = @"???";
    
//    [self.view setNeedsLayout];
}

- (void)showAnswer:(id)sender {
    NSString *answer = self.answers[self.currentQuestionIndex];
    self.answerLabel.text = answer;
//    [self.view setNeedsLayout];

}

@end
