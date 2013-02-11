//
//  SUGauge.m
//  awesomeCharts
//
//  Created by Antoine Lagadec on 06/02/13.
//  Copyright (c) 2013 Fabien. All rights reserved.
//

#import "SUGauge.h"

@implementation SUGauge

- (id)init
{
    if (self = [super init]) {
        _displayBackground = NO;
    }
    
    return self;
}

- (void)drawInContext:(CGContextRef)context
{
    CGRect foregroundRect = _rect;
    
    if (_orientation == GaugeOrientationHorizontal) {
        foregroundRect.size.width = _rect.size.width * _value;
    }
    else {
        foregroundRect.size.height = _rect.size.height * _value;
    }
    
    if (_displayBackground) {
        [self drawRect:_rect withColor:_backgroundColor inContext:context];
    }
    [self drawRect:foregroundRect withColor:_foregroundColor inContext:context];
}

- (void)drawRect:(CGRect)rect withColor:(NSColor*)color inContext:(CGContextRef)context
{
    CGContextBeginPath(context);
    CGContextSetRGBFillColor(context, [color redComponent], [color greenComponent], [color blueComponent], [color alphaComponent]);
    CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGContextAddLineToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGContextClosePath(context);
    CGContextFillPath(context);
}

@end
