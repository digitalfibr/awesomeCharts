//
//  SULineGraph.m
//  essai
//
//  Created by Fabien on 30/01/13.
//  Copyright (c) 2013 Fabien. All rights reserved.
//

#import "SULineGraph.h"
@interface SULineGraph()
{
    BOOL hasPoints;
    BOOL displayValues;
}
@end

@implementation SULineGraph

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        _lineWidth = [NSNumber numberWithFloat:4.0];
        hasPoints = YES;
        displayValues = YES;
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    // reset tracking area when resizing
    [self initTrackingArea];
    
    [self drawLineGraph];
}

-(void)setValues:(NSArray*)val andXLabels:(NSArray*)xlab
{
    values = val;
    xLabels = xlab;
}

-(void)hasPoints:(BOOL)val
{
    hasPoints=val;
}

-(void)mouseDisplayValues:(BOOL)val
{
    displayValues = val;
}

- (void)drawLineGraph
{
    CGContextRef myContext = [[NSGraphicsContext currentContext] graphicsPort];
    CGContextSetLineWidth(myContext, [_lineWidth floatValue]);
    CGContextSetStrokeColorWithColor(myContext, [_lineColor CGColor]);
    CGContextSetLineJoin(myContext, kCGLineJoinRound);
    CGContextBeginPath(myContext);
    
    for (NSArray* items in values)
    {
        
        CGContextMoveToPoint(myContext, originX, originY);
        
        // define space between points
        float spaceBetweenPoints = (rect.size.width-(kOffsetX*2))/nbOfItems;
        float currentStep = originX + spaceBetweenPoints;
        
        // define amplitude
        float scale = rect.size.height /(maxValue-minValue+kOffsetY+kOffsetY);
        
        for (NSString *value in items)
        {
            // draw the line
            CGContextAddLineToPoint(myContext, currentStep, ([value floatValue]*scale)+originY);
            
            currentStep = currentStep+spaceBetweenPoints;
        }
        CGContextDrawPath(myContext, kCGPathStroke);
        
        
        // draw point and display area
        if (hasPoints){
            CGContextMoveToPoint(myContext, originX, originY);
            currentStep = originX + spaceBetweenPoints;
        }
        for (NSString *value in items)
        {
            float x = currentStep;
            float y = ([value floatValue]*scale)+originY;
            if (hasPoints){
                CGRect rect1 = CGRectMake(x - kCircleRadius, y - kCircleRadius, 2 * kCircleRadius, 2 * kCircleRadius);
                CGContextAddEllipseInRect(myContext, rect1);
                currentStep = currentStep+spaceBetweenPoints;
            }
            
            if (displayValues){
                NSTrackingArea *trackingArea = [[NSTrackingArea alloc] initWithRect:NSMakeRect(x-10, y-10, 20, 20)
                                                                            options:NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved |NSTrackingActiveAlways
                                                                              owner:self
                                                                           userInfo:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                                     value,@"value",
                                                                                     [NSNumber numberWithFloat:x],@"x",
                                                                                     [NSNumber numberWithFloat:y],@"y",
                                                                                     nil]];
                
                [self addTrackingArea:trackingArea];
            }
        }
        if (hasPoints)
            CGContextDrawPath(myContext, kCGPathFillStroke);
    }
}

#pragma mark-display point
-(void)initTrackingArea
{
    NSArray *trackingArea = [self trackingAreas];
    for (NSTrackingArea * area in trackingArea)
        [self removeTrackingArea:area];
}

- (void)mouseEntered:(NSEvent *)theEvent
{
    NSString *theText = [(NSDictionary*)[theEvent userData]objectForKey:@"value"];
    NSNumber *xPos = [(NSDictionary*)[theEvent userData]objectForKey:@"x"];
    NSNumber *yPos = [(NSDictionary*)[theEvent userData]objectForKey:@"y"];
    
    if (theText)
        [self toggleAttachedWindowAtPoint:NSMakePoint([xPos floatValue], [yPos floatValue]) withText:theText];
}

- (void)mouseExited:(NSEvent *)theEvent
{
    [self toggleAttachedWindowAtPoint:NSMakePoint(0, 0) withText:@""];
}

@end
