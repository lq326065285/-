//
//  LQDrawView.m
//  画板
//
//  Created by 李强 on 2017/4/11.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "LQDrawView.h"
#import "LQBezierPath.h"
@interface LQDrawView ()

@property (nonatomic,strong) NSMutableArray * arrPaths;

@property (nonatomic,strong) UIBezierPath * path;

@end

@implementation LQDrawView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        self.userInteractionEnabled = YES;
        UIPanGestureRecognizer * pgr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
        [self addGestureRecognizer:pgr];
        self.lineWidth = 20;
    }
    return self;
}

//清除
-(void)erase{
    self.lineColor = self.backgroundColor;
}

-(void)revoke{
    [self.arrPaths removeLastObject];
    [self setNeedsDisplay];
}

-(void)restart{
    [self.arrPaths removeAllObjects];
    [self setNeedsDisplay];
}

-(void)panGesture:(UIPanGestureRecognizer *)pgr{
    CGPoint point = [pgr locationInView:pgr.view];
    if (pgr.state == UIGestureRecognizerStateBegan) {
        LQBezierPath * p = [LQBezierPath bezierPath];
        [p moveToPoint:point];
        p.lineCapStyle = kCGLineCapRound;
        p.lineJoinStyle = kCGLineJoinRound;
        p.color = self.lineColor;
        p.lineWidth = self.lineWidth;
        self.path = p;
        [self.arrPaths addObject:p];
    }else if(pgr.state == UIGestureRecognizerStateChanged){
        [self.path addLineToPoint:point];
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect {
    for(LQBezierPath * p in self.arrPaths){
        [p.color set];
        [p stroke];
    }
}

-(NSMutableArray *)arrPaths{
    if (!_arrPaths) {
        _arrPaths = [[NSMutableArray alloc] init];
    }
    return _arrPaths;
}

@end
