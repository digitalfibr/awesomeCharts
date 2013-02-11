//
//  SUGaugesHorizontal.m
//  awesomeCharts
//
//  Created by Antoine Lagadec on 04/02/13.
//  Copyright (c) 2013 Fabien. All rights reserved.
//

#import "SUGaugesView.h"

@interface SUGaugesView()
{
    float rectWidth;
    float rectHeight;
    
    float rectInnerWidth;
    float rectInnerHeight;
    
    float gaugeRealWidth;
    float gaugeRealHeight;
}
@end

@implementation SUGaugesView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _orientation   = GaugeOrientationVertical;
        
        _gaugeWidth    = 0.0;
        _gaugeHeight   = 0.0;
        _gaugeSpacing  = 0.0;
        
        _paddingTop    = 0.0;
        _paddingRight  = 0.0;
        _paddingBottom = 0.0;
        _paddingLeft   = 0.0;
        
        values = @[@[@"0.2", @"0.7", @"0.9", @"0.1", @"1", @"0.3798"]];
        
        [self refresh];
    }

    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    [self initTrackingArea];
    [self drawBackgroundWithColor:[NSColor colorWithSRGBRed:68/255.0f green:68/255.0F blue:80/255.0f alpha:1.0]];
    
    NSUInteger valuesCount = [[values objectAtIndex:0] count];
    
    rectWidth       = rect.size.width;
    rectHeight      = rect.size.height;
    
    rectInnerWidth  = ((_gaugeSpacing + _gaugeWidth) * valuesCount) + _paddingRight + _paddingLeft - _gaugeSpacing;
    rectInnerHeight = ((_gaugeSpacing + _gaugeHeight) * valuesCount) + _paddingTop + _paddingBottom - _gaugeSpacing;
    
    gaugeRealWidth  = _gaugeWidth ? _gaugeWidth : rectWidth;
    gaugeRealHeight = _gaugeHeight ? _gaugeHeight : rectHeight;
    
    // Fluid Gauges
    if (rectInnerWidth >= rectWidth) {
        gaugeRealWidth = (_gaugeWidth - ((rectInnerWidth - rectWidth) / valuesCount));
    }
    if (rectInnerHeight >= rectHeight) {
        gaugeRealHeight = (_gaugeHeight - ((rectInnerHeight - rectHeight) / valuesCount));
    }
    
    [self drawGauges];
}

-(void)refresh
{
    [self initGauges];
    [self setNeedsDisplay:YES];
}

-(void)initGauges
{
    _gauges = [NSMutableArray new];
    
    [values[0] enumerateObjectsUsingBlock:^(id value, NSUInteger index, BOOL *stop) {
        SUGauge *gauge = [SUGauge new];
        
        [gauge setValue:[value floatValue]];
        [gauge setBackgroundColor:[NSColor colorWithSRGBRed:85/255.0f green:85/255.0f blue:95/255.0f alpha:1.0f]];
        [gauge setForegroundColor:[NSColor colorWithSRGBRed:74/255.0f green:206/255.0f blue:183/255.0f alpha:1.0f]];
        [gauge setOrientation:_orientation];
        
        [_gauges addObject:gauge];
    }];
}

-(void)drawGauges
{
    CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
    
    [_gauges enumerateObjectsUsingBlock:^(SUGauge *gauge, NSUInteger index, BOOL *stop) {
        int x = 0; int y = 0;
        
        if (gauge.orientation == GaugeOrientationHorizontal) {
            x = _paddingLeft;
            y = _paddingBottom + ((_gaugeSpacing + gaugeRealHeight) * index);
            
            gauge.rect = CGRectMake(x, y, gaugeRealWidth, gaugeRealHeight);
        }
        
        if (gauge.orientation == GaugeOrientationVertical) {
            x = _paddingLeft + ((_gaugeSpacing + gaugeRealWidth) * index);
            y = _paddingBottom;
            
            gauge.rect = CGRectMake(x, y, gaugeRealWidth, gaugeRealHeight);
        }
        
        NSDictionary *userInfo = @{ @"value": @(gauge.value), @"x": @(x + 90.0f), @"y": @(y + 20.0f) };
        
        NSTrackingArea *trackingArea = [[NSTrackingArea alloc] initWithRect:gauge.rect
                                                                    options:NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved |NSTrackingActiveAlways
                                                                      owner:self
                                                                   userInfo:userInfo];
        
        [self addTrackingArea:trackingArea];
        
        [gauge drawInContext:context];
    }];
}

- (void)initTrackingArea {
    NSArray *trackingArea = [self trackingAreas];
    for (NSTrackingArea *area in trackingArea) {
        [self removeTrackingArea:area];
    }
}

- (void)mouseEntered:(NSEvent *)theEvent
{
    attachedWindow = nil;
    
    NSDictionary *data = [theEvent userData];
    
    NSNumber *theValue = data[@"value"];
    NSNumber *x        = data[@"x"];
    NSNumber *y        = data[@"y"];
    
    [self toggleAttachedWindowAtPoint:NSMakePoint([x floatValue], [y floatValue])
                             withText:[NSString stringWithFormat:@"%i", (int)([theValue floatValue] * 100)]];
}

- (void)mouseExited:(NSEvent *)theEvent
{
    [self toggleAttachedWindowAtPoint:NSMakePoint(0, 0) withText:@""];
}


@end
