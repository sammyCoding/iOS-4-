//
//  ZWADrawView.m
//  TouchTracker
//
//  Created by Zeon Waa on 3/8/17.
//  Copyright © 2017 Zeon Waa. All rights reserved.
//

#import "ZWADrawView.h"
#import "ZWALine.h"

@interface ZWADrawView ()

//@property (nonatomic, strong) ZWALine *currentLine;
@property (nonatomic, strong) NSMutableArray *finishedLines;
@property (nonatomic, strong) NSMutableDictionary *linesInProgress;

@end


@implementation ZWADrawView

- (instancetype)init {
    self  = [super init];
    if (self) {
        self.linesInProgress = [[NSMutableDictionary alloc] init];
        self.finishedLines = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor grayColor];
        self.multipleTouchEnabled = YES;
    }
    return self;
}

- (void)strokeLine:(ZWALine *)line {
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 10.0;
    path.lineCapStyle = kCGLineCapRound;
    
    [path moveToPoint:line.begin];
    [path addLineToPoint:line.end];
    [path stroke];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.*/
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [[UIColor blackColor] set];
    for (ZWALine *line in self.finishedLines) {
        [self strokeLine:line];
    }
//    if (self.currentLine) {
//        [[UIColor redColor] set];
//        [self strokeLine:self.currentLine];
//    }
    
    [[UIColor redColor] set];
    for (NSValue *key in self.linesInProgress) {
        [self strokeLine:self.linesInProgress[key]];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    UITouch *t = [touches anyObject];
//    //
//    CGPoint location = [t locationInView:self];
    
    
//    self.currentLine = [[ZWALine alloc] init];
//    self.currentLine.begin = location;
//    self.currentLine.end = location;
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t  in touches) {
        CGPoint location = [t locationInView:self];
        ZWALine *line = [[ZWALine alloc]init];
        line.begin = location;
        line.end = location;
        //使用内存地址分辨UITouch对象的原因是，在触摸事件开始 移动 结束的整个过程中，其内存地址是不会改变的。
        
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        self.linesInProgress[key] = line;
    }
    
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    UITouch *t = [touches anyObject];
//    CGPoint location = [t locationInView:self];
//    
//    self.currentLine.end = location;
    NSLog(@"%@", NSStringFromSelector(_cmd));

    for (UITouch *t  in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        ZWALine *line = self.linesInProgress[key];
        line.end = [t locationInView:self];
    }
    
    [self setNeedsDisplay];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.finishedLines addObject:self.currentLine];
//    self.currentLine = nil;
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
    for (UITouch *t  in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        ZWALine *line = self.linesInProgress[key];
        [self.finishedLines addObject:line];
        [self.linesInProgress removeObjectForKey:key];
    }
    
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t  in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        [self.linesInProgress removeObjectForKey:key];
    }
    [self setNeedsDisplay];
}

@end
