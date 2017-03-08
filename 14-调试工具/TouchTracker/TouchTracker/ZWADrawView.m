//
//  ZWADrawView.m
//  TouchTracker
//
//  Created by Zeon Waa on 3/8/17.
//  Copyright © 2017 Zeon Waa. All rights reserved.
//

#import "ZWADrawView.h"
#import "ZWALine.h"

@interface ZWADrawView ()<UIGestureRecognizerDelegate>

//@property (nonatomic, strong) ZWALine *currentLine;
@property (nonatomic, strong) NSMutableArray *finishedLines;
@property (nonatomic, strong) NSMutableDictionary *linesInProgress;

@property (nonatomic, weak) ZWALine *selectedLine;
@property (nonatomic, strong) UIPanGestureRecognizer *moveRecognizer;
@end


@implementation ZWADrawView

- (instancetype)init {
    self  = [super init];
    if (self) {
        self.linesInProgress = [[NSMutableDictionary alloc] init];
        self.finishedLines = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor grayColor];
        self.multipleTouchEnabled = YES;
        
        //识别双击
        UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        doubleTapRecognizer.numberOfTapsRequired = 2;
        doubleTapRecognizer.delaysTouchesBegan = YES;
        [self addGestureRecognizer:doubleTapRecognizer];
        
        //识别单击
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        tapRecognizer.delaysTouchesBegan = YES;
        [tapRecognizer requireGestureRecognizerToFail:doubleTapRecognizer];
        [self addGestureRecognizer:tapRecognizer];
        
        //识别长按 默认0.5s
        UILongPressGestureRecognizer *pressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:pressRecognizer];
        
        //拖动
        self.moveRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveLine:)];
        self.moveRecognizer.delegate = self;
        //默认值为YES，如果是YES，会在识别特定的手势时，吃掉所有和该手势相关的UITouch对象
        self.moveRecognizer.cancelsTouchesInView = NO;
        [self addGestureRecognizer:self.moveRecognizer];
        
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

- (ZWALine *)lineAtPoint:(CGPoint)p {
    //找出离p最近的ZWALine对象
    for (ZWALine *l  in self.finishedLines) {
        CGPoint start = l.begin;
        CGPoint end = l.end;
        
        for (float t = 0.0; t <= 1.0; t += 0.05) {
            float x = start.x + t * (end.x - start.x);
            float y = start.y + t * (end.y - start.y);
            // 如果线条的某个点和p的距离在20以内，就返回相应的ZWALine 对象
            if (hypotf(x - p.x, y - p.y) < 20.0) {
                return l;
            }
        }
    }
    return nil;
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
    
    if (self.selectedLine) {
        [[UIColor greenColor] set];
        [self strokeLine:self.selectedLine];
    }
    
    //测试cpu占用量
//    float f = 0.0;
//    for (int i = 0; i < 1000000; i++) {
//        f = f + sin(sin(sin(time(NULL) + i)));
//    }
//    NSLog(@"f = %f", f);
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

//测试静态分析器
- (int)numberofLines {
    int count  = 0;
    if (self.linesInProgress && self.finishedLines) {
        count = [self.linesInProgress count] + [self.finishedLines count];
    }
    return count;
}

- (void)doubleTap:(UIGestureRecognizer *)gr {
    NSLog(@"Recognizer Double Tap");
    
    [self.linesInProgress removeAllObjects];
//    [self.finishedLines removeAllObjects];
    //引用循环测试

    self.finishedLines = [[NSMutableArray alloc] init];
    [self setNeedsDisplay];

}

- (void)tap:(UITapGestureRecognizer *)gr {
    NSLog(@"Recognizer tap");
    
    CGPoint point = [gr locationInView:self];
    self.selectedLine = [self lineAtPoint:point];
    
    if (self.selectedLine) {
        [self becomeFirstResponder];
        UIMenuController *menu = [UIMenuController sharedMenuController];
        UIMenuItem *deleteItem = [[UIMenuItem alloc] initWithTitle:@"Delete" action:@selector(deleteLine:)];
        menu.menuItems = @[deleteItem];
        [menu setTargetRect:CGRectMake(point.x, point.y, 2, 2) inView:self];
        [menu setMenuVisible:YES animated:YES];
        
    } else {
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    }
    
    [self setNeedsDisplay];
    
}

- (void)deleteLine:(id)sender {
    [self.finishedLines removeObject:self.selectedLine];
    //重画整个视图
    [self setNeedsDisplay];
    
}

- (void)longPress:(UIGestureRecognizer *)gr {
    if (gr.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [gr locationInView:self];
        self.selectedLine = [self lineAtPoint:point];
        if (self.selectedLine) {
            [self.linesInProgress removeAllObjects];
        }
    } else if(gr.state == UIGestureRecognizerStateEnded){
        self.selectedLine = nil;
    }
    [self setNeedsDisplay];
}

- (void)moveLine:(UIPanGestureRecognizer *)gr {
    if (!self.selectedLine) {
        return;
    }

    if (gr.state == UIGestureRecognizerStateChanged) {
        //获取手指的拖移距离
        CGPoint translation = [gr translationInView:self];
        CGPoint begin = self.selectedLine.begin;
        CGPoint end = self.selectedLine.end;
        begin.x += translation.x;
        begin.y += translation.y;
        end.x += translation.x;
        end.y += translation.y;
        
        //为选中的线条设置新的起点和终点
        self.selectedLine.begin = begin;
        self.selectedLine.end = end;
        [self setNeedsDisplay];
        
        [gr setTranslation:CGPointZero inView:self];
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
        //引用循环测试

        line.containingArray = self.finishedLines;
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

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (gestureRecognizer == self.moveRecognizer) {
        return YES;
    }
    return NO;
}

@end
