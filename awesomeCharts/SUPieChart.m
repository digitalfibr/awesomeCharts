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
    /******** CONFIG *********/
    //// Color Declarations
    NSColor* color_1 = [NSColor colorWithCalibratedRed:181/255.0
                              green:224/255.0
                               blue:115/255.0
                              alpha:1];
    NSColor* color_2 = [NSColor lightGrayColor];
    NSColor* color_3 = [NSColor colorWithCalibratedRed:100/255.0
                                                 green:220/255.0
                                                  blue:150/255.0
                                                 alpha:1];
    NSColor* color_4 = [NSColor colorWithCalibratedRed:150/255.0
                                                          green:200/255.0
                                                           blue:150/255.0
                                                          alpha:1];
    NSColor* color_5 = [NSColor grayColor];
    NSColor* color_6 = [NSColor purpleColor];
    NSColor* color_7 = [NSColor blackColor];
    NSColor* color_8 = [NSColor blueColor];
    
    NSArray *colorArray = [NSArray arrayWithObjects:color_1,color_2,color_3,color_4,color_5,color_6,color_7,color_8, nil];
    
    // values
    NSArray *values = [NSArray arrayWithObjects:[NSNumber numberWithInt:30], [NSNumber numberWithInt:60],[NSNumber numberWithInt:80],[NSNumber numberWithInt:10], nil];
    
    // legend
    NSArray *keys = [NSArray arrayWithObjects:@"legend1",@"legend2",@"legend3",@"legend4", nil];

    NSColor* strokeColor = [NSColor colorWithCalibratedRed: 1 green: 1 blue: 1 alpha: 1];
    
    /*************************/
    
    // oval size;
    CGFloat ovalSize = (dirtyRect.size.width<dirtyRect.size.height)?dirtyRect.size.width*0.7:dirtyRect.size.height*0.7;
    CGFloat ovalPositionX = 0;
    CGFloat ovalPositionY = (dirtyRect.size.height - ovalSize)/2;
    
    NSRect ovalRect = NSMakeRect(ovalPositionX, ovalPositionY, ovalSize, ovalSize);
    
    // compute total
    CGFloat total = 0;
    
    for (NSNumber *value in values)
        if ([value floatValue]>0) total = total + [value floatValue];

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
    
/***    legend   ***/
    
    //// Rectangle Drawing
    CGFloat legendPositionX = ovalSize + (dirtyRect.size.width * 0.05);
    CGFloat legendPositionY = dirtyRect.size.height - (dirtyRect.size.height * 0.3);
    CGFloat legendSquareSize = 10;
    valueIndex = 0;
    
    for (NSString *key in keys){
        
        NSColor *fillColor = [colorArray objectAtIndex:valueIndex];
        NSBezierPath* rectanglePath = [NSBezierPath bezierPathWithRect: NSMakeRect(legendPositionX, legendPositionY, legendSquareSize, legendSquareSize)];
        [fillColor setFill];
        [rectanglePath fill];
        
        //// Text Drawing
        NSString* textContent = @"Hello, World!";
        NSRect textRect = NSMakeRect(legendPositionX + legendSquareSize, legendPositionY, 100, 16);
        NSColor *textColor = [NSColor blackColor];
        
        NSMutableParagraphStyle* textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        [textStyle setAlignment: NSCenterTextAlignment];
        
        NSDictionary* textFontAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                            [NSFont fontWithName: @"Helvetica" size: 12], NSFontAttributeName,
                                            textColor, NSForegroundColorAttributeName,
                                            textStyle, NSParagraphStyleAttributeName, nil];
        
        [textContent drawInRect: textRect withAttributes: textFontAttributes];
        
        legendPositionY = legendPositionY - legendSquareSize - 5;
        valueIndex++;
    }
}

@end
