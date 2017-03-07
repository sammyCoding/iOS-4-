//
//  ZWAHypnosisView.m
//  Hypnosister
//
//  Created by Zeon Waa on 3/7/17.
//  Copyright © 2017 Zeon Waa. All rights reserved.
//

#import "ZWAHypnosisView.h"

@implementation ZWAHypnosisView

-(instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
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
    
    //设置绘制颜色为浅灰色
    [[UIColor lightGrayColor] setStroke];
    
    //绘制路径
    [path stroke];
    
    
}


@end
