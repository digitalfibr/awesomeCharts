//
//  SUPieChart.m
//  awesomeCharts
//
//  Created by Fabien Charbit on 16/02/13.
//  Copyright (c) 2013 Fabien. All rights reserved.
//

#import "SUPieChart.h"

@implementation SUPieChart

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


- (void)drawRect:(NSRect)dirtyRect
{
    //// Color Declarations
    NSColor* color_1 = [NSColor blueColor];
    NSColor* color_2 = [NSColor redColor];
    NSColor* color_3 = [NSColor greenColor];
    NSColor* color_4 = [NSColor yellowColor];
    NSColor* color_5 = [NSColor grayColor];
    NSColor* color_6 = [NSColor purpleColor];
    NSColor* color_7 = [NSColor blackColor];
    NSColor* color_8 = [NSColor blueColor];
    
    NSArray *colorArray = [NSArray arrayWithObjects:color_1,color_2,color_3,color_4,color_5,color_6,color_7,color_8, nil];

    NSColor* strokeColor = [NSColor colorWithCalibratedRed: 1 green: 1 blue: 1 alpha: 1];
    
    // oval size;
    CGFloat ovalSize = (dirtyRect.size.width<dirtyRect.size.height)?dirtyRect.size.width*0.7:dirtyRect.size.height*0.7;
    CGFloat ovalPositionX = 0;
    CGFloat ovalPositionY = (dirtyRect.size.height - ovalSize)/2;
    
    NSRect ovalRect = NSMakeRect(ovalPositionX, ovalPositionY, ovalSize, ovalSize);
    
    // values
    NSArray *values = [NSArray arrayWithObjects:[NSNumber numberWithInt:30], [NSNumber numberWithInt:60],[NSNumber numberWithInt:80],[NSNumber numberWithInt:10], nil];
    
    // compute total
    CGFloat total = 0;
    
    for (NSNumber *value in values)
        total = total + [value floatValue];

    float startAngle = 180;
    int valueIndex = 0;
    
    for (NSNumber* value in values)
    {
        // retrieve color
        NSColor* fillColor = [colorArray objectAtIndex:valueIndex];
        
        // compute angle
        float currentValue = [value floatValue];
        CGFloat endAngle = startAngle - ((currentValue * 360)/total);
        
        //// Oval Drawing
        NSBezierPath* ovalPath = [NSBezierPath bezierPath];
        [ovalPath appendBezierPathWithArcWithCenter: NSMakePoint(NSMidX(ovalRect), NSMidY(ovalRect)) radius: NSWidth(ovalRect) / 2 startAngle: startAngle endAngle: endAngle clockwise: YES];
        [ovalPath lineToPoint: NSMakePoint(NSMidX(ovalRect), NSMidY(ovalRect))];
        [ovalPath closePath];
        
        [fillColor setFill];
        [ovalPath fill];
        [strokeColor setStroke];
        [ovalPath setLineWidth: 2];
        [ovalPath stroke];
        
        startAngle = endAngle;
        valueIndex++;
    }
    
    //// Rectangle Drawing
    CGFloat legendPositionX = dirtyRect.size.width - (dirtyRect.size.width * 0.2);
    CGFloat legendPositionY = dirtyRect.size.height - (dirtyRect.size.height * 0.2);
    
    NSColor *fillColor = [colorArray objectAtIndex:0];
    NSBezierPath* rectanglePath = [NSBezierPath bezierPathWithRect: NSMakeRect(legendPositionX, legendPositionY, 20, 20)];
    [fillColor setFill];
    [rectanglePath fill];
}

@end
