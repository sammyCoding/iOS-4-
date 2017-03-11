//
//  ZWAHypnosisView.m
//  Hypnosister
//
//  Created by Zeon Waa on 3/7/17.
//  Copyright © 2017 Zeon Waa. All rights reserved.
//

#import "ZWAHypnosisView.h"

@interface ZWAHypnosisView ()
//  只会在类的内部使用的属性和方法应当志声明在类扩展中。子类同样无法访问父类在类扩展中声明的属性和方法。
@property (nonatomic, strong) UIColor *circleColor;

@end

@implementation ZWAHypnosisView

-(instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.circleColor = [UIColor lightGrayColor];
    }
    return self;
}

-(void)setCircleColor:(UIColor *)circleColor {
    _circleColor = circleColor;
    [self setNeedsDisplay];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@ was touched",self);

    //获取三个0到1之间的数字
    float red = (arc4random() % 100) / 100.0;
    float green = (arc4random() % 100) / 100.0;
    float blue = (arc4random() % 100) / 100.0;
    
    UIColor *randomColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    self.circleColor = randomColor;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.*/
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGRect bounds = self.bounds;
    
    //根据bounds计算中心点
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    //根据视图宽和高之间的较小值计算圆形的半径
//    float radius = (MIN(bounds.size.width, bounds.size.height) / 2.0);
    
    //使最外层圆形成为视图的外接圆，hypot结果是三角形的斜边长
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    UIBezierPath *path = [[UIBezierPath alloc]init];
    
    //画同心圆
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
        //画完圆抬起笔，再画下一个
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        [path addArcWithCenter:center radius:currentRadius startAngle:0.0 endAngle:M_PI * 2.0 clockwise:YES];
    }
    
    //以中心点为圆心，radius为半径，定义一个0到M_PI * 2.0弧度的路径（整圆）
//    [path addArcWithCenter:center radius:radius startAngle:0.0 endAngle:M_PI * 2.0 clockwise:YES];
    
    
    
    
    
    //设置线条宽度为10点
    path.lineWidth = 10;
    
    //根据circleColor设置绘制颜色
    [self.circleColor setStroke];
    
    //绘制路径
    [path stroke];
    
    
}


@end
