//
//  SUGraphView.m
//  essai
//
//  Created by Fabien on 26/01/13.
//  Copyright (c) 2013 Fabien. All rights reserved.
//

#import "SUGraphView.h"
#import "MAAttachedWindow.h"
#import "NSColor+CGColor.h"

@interface SUGraphView ()
{
    BOOL _hasXAxis;
    BOOL _hasYAxis;
    BOOL _hasXGrid;
    BOOL _hasYGrid;
    int _gridType;
    BOOL _hasXDescription;
    BOOL _hasYDescription;
    MAAttachedWindow *attachedWindow;
}
@end
@implementation SUGraphView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        _backgroundColor = [NSColor whiteColor];
        _axisColor = [NSColor blackColor];
        _gridColor = [NSColor lightGrayColor];
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    rect = dirtyRect;
    
    [self drawBackgroundWithColor:_backgroundColor];
    
    // grid
    [self drawGridWithX_Axis:_hasXAxis y_axis:_hasYAxis x_grid:_hasXGrid y_grid:_hasYGrid gridType:_gridType x_description:_hasXDescription y_description:_hasYDescription];
}

-(void)drawBackgroundWithColor:(NSColor*)color
{
    CGContextRef myContext = [[NSGraphicsContext currentContext] graphicsPort];
    CGContextSetFillColorWithColor(myContext, [color CGColor]);
    CGContextFillRect(myContext, rect);
}

#pragma mark- Grid Creation
-(void)drawGridWithX_Axis:(BOOL)hasXAxis y_axis:(BOOL)hasYAxis x_grid:(BOOL)hasXGrid y_grid:(BOOL)hasYGrid gridType:(int)gridType x_description:(BOOL)hasXDescription y_description:(BOOL)hasYDescription
{
    
    _hasXAxis = hasXAxis;
    _hasYAxis = hasYAxis;
    _hasXGrid = hasXGrid;
    _hasYGrid = hasYGrid;
    _gridType = gridType;
    _hasXDescription = hasXDescription;
    _hasYDescription = hasYDescription;
    
    nbOfItems = [[values objectAtIndex:0]count];
    maxValue = [self maxValue];
    minValue = [self minValue];
    maxHorizontGridValue = [self maxHorizontalGridValue];
    minHorizontGridValue = [self minHorizontalGridValue];
    
    // draw axis
    if (hasXAxis)
        [self drawXAxis];
    if (hasYAxis)
        [self drawYAxis];

    // draw grid
    if (hasXGrid)
        [self drawXGrid];
    if (hasYGrid)
        [self drawYGrid];

    // draw text
    if (hasXDescription)
        [self drawXTextAxis];
    if (hasYDescription)
        [self drawYTextAxis];
}

-(void)drawAxisAndGrid
{
    nbOfItems = [values count];
    maxValue = [self maxValue];
    minValue = [self minValue];
    maxHorizontGridValue = [self maxHorizontalGridValue];
    minHorizontGridValue = [self minHorizontalGridValue];
    
    // draw axis
    [self drawXAxis];
    [self drawYAxis];
    
    // draw grid
    [self drawXGrid];
    [self drawYGrid];
    
    // draw text
    [self drawYTextAxis];
    [self drawXTextAxis];
}

-(void)drawXAxis
{
    // find origin
    if (minHorizontGridValue==0)
        originY = kOffsetY;
    else{
        float scale = rect.size.height /(maxValue-minValue+kOffsetY+kOffsetY);
        originY = ((-minValue +kOffsetY) * scale);
    }
    originX = kOffsetX;
    
    if (originY>=kOffsetY && originY<=(rect.size.height-kOffsetY)){
        CGContextRef myContext = [[NSGraphicsContext currentContext] graphicsPort];
        CGContextSetLineWidth(myContext, 1);
        CGContextSetStrokeColorWithColor(myContext, [_axisColor CGColor]);
        CGContextMoveToPoint(myContext, originX, originY);
        CGContextAddLineToPoint(myContext, rect.size.width-(rect.size.width*0.02), originY);
        CGContextStrokePath(myContext);
    }
}

-(void)drawYAxis
{
    CGContextRef myContext = [[NSGraphicsContext currentContext] graphicsPort];
    CGContextSetLineWidth(myContext, 1);
    CGContextSetStrokeColorWithColor(myContext, [_axisColor CGColor]);

    CGContextMoveToPoint(myContext, originX, kOffsetY);
    CGContextAddLineToPoint(myContext, originX, rect.size.height-kOffsetY);
    
    CGContextStrokePath(myContext);
}

-(void)drawYGrid
{
    CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
    CGContextSetLineWidth(context, 0.6);
    CGContextSetStrokeColorWithColor(context, [_gridColor CGColor]);
    // line dash
    CGFloat dash[] = {2.0, 2.0};
    CGContextSetLineDash(context, 0.0, dash, 2);

    float scale = rect.size.height /(maxValue-minValue+kOffsetY+kOffsetY);
    
    if (maxValue>-minValue)
    {
        int howManyHorizontalGrid = [self nbHorizontalGridAfterOrigin];
        
        float step = (scale * maxHorizontGridValue)/howManyHorizontalGrid;
        
        // draw positive grid
        for (int i = 0; i < howManyHorizontalGrid; i++)
        {
            float ref;
            ref=(originY + step) +(i * step);
            
            if (ref>=rect.size.height-kOffsetY)
                break;
            if (ref>kOffsetY && ref<(rect.size.height-kOffsetY)){
                CGContextMoveToPoint(context, kOffsetX, ref);
                CGContextAddLineToPoint(context, rect.size.width-(kOffsetX),ref);
            }
        }
        
        // draw negative Grid
        float yPos = originY - step;
        while (yPos>kOffsetY) {
            CGContextMoveToPoint(context, kOffsetX, yPos);
            CGContextAddLineToPoint(context, rect.size.width-(kOffsetX),yPos);
            yPos = yPos - step;
        }
    }
    else
    {
        int howManyHorizontalGrid = [self nbHorizontalGridBeforeOrigin];
        
        float step = (scale * minHorizontGridValue)/howManyHorizontalGrid;
        
        for (int i = 0; i < howManyHorizontalGrid; i++)
        {
            float ref;
            ref=(originY - step) -(i * step);
            
            if (ref<kOffsetY)
                break;
            
            if (ref>kOffsetY && ref<(rect.size.height-kOffsetY)){
                CGContextMoveToPoint(context, kOffsetX, ref);
                CGContextAddLineToPoint(context, rect.size.width-(kOffsetX),ref);
            }
        }
        
        // draw positve Grid
        float yPos = originY + step;
        while (yPos<rect.size.height-kOffsetY) {
            CGContextMoveToPoint(context, kOffsetX, yPos);
            CGContextAddLineToPoint(context, rect.size.width-(kOffsetX),yPos);
            yPos = yPos + step;
        }
        
    }
    
    CGContextStrokePath(context);
    CGContextSetLineDash(context, 0, NULL, 0); // Remove the dash
}

-(void)drawXGrid
{
    CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
    CGContextSetLineWidth(context, 0.6);
    CGContextSetStrokeColorWithColor(context, [_gridColor CGColor]);
    // line dash
    CGFloat dash[] = {2.0, 2.0};
    CGContextSetLineDash(context, 0.0, dash, 2);
    
    NSUInteger step = (rect.size.width-(2*kOffsetX))/nbOfItems;
    
    for (int i = 0; i < nbOfItems; i++)
    {
        CGContextMoveToPoint(context, (kOffsetX + step) + i * step, rect.size.height-kOffsetY);
        CGContextAddLineToPoint(context, (kOffsetX + step) + i * step, kOffsetY);
    }
    CGContextStrokePath(context);
    CGContextSetLineDash(context, 0, NULL, 0); // Remove the dash
}

-(void)drawYTextAxis
{
    // Drawing text
    NSFont *font = [NSFont fontWithName:@"Helvetica" size:10];
    NSDictionary *attributedString = [NSDictionary dictionaryWithObjectsAndKeys:
                                      _axisColor, NSForegroundColorAttributeName,
                                      font, NSFontAttributeName,
                                      nil];
    
    
    float scale = rect.size.height /(maxValue-minValue+kOffsetY+kOffsetY);
    
    if (maxValue>-minValue)
    {
        int howManyHorizontalGrid = [self nbHorizontalGridAfterOrigin];
        float step = (scale * maxHorizontGridValue)/howManyHorizontalGrid;
        float stepValue = maxHorizontGridValue/howManyHorizontalGrid;
        
        // positive text values
        for (int i = 0; i < howManyHorizontalGrid; i++)
        {
            float ref;
            ref=(originY + step) +(i * step);
            
            if (ref>rect.size.height-kOffsetY)
                break;
            
            if (ref>kOffsetY && ref<(rect.size.height-kOffsetY)){
                int value = floor(stepValue + (i*stepValue));
                NSString *theText = [NSString stringWithFormat:@"%i",value];
                [theText drawAtPoint:NSMakePoint(kOffsetX/3, ref) withAttributes:attributedString];
            }
        }
        
        // negative text values
        float yPos = originY - step;
        int i = 0;
        while (yPos>kOffsetY) {
            int value = floor(stepValue + (i*stepValue));
            NSString *theText = [NSString stringWithFormat:@"-%i",value];
            [theText drawAtPoint:NSMakePoint(kOffsetX/3, yPos) withAttributes:attributedString];
            i++;
            yPos = yPos - step;
        }
    }
    else
    {
        int howManyHorizontalGrid = [self nbHorizontalGridBeforeOrigin];
        float step = (scale * minHorizontGridValue)/howManyHorizontalGrid;
        float stepValue = minHorizontGridValue/howManyHorizontalGrid;
        
        for (int i = 0; i < howManyHorizontalGrid; i++)
        {
            float ref;
            ref=(originY - step) -(i * step);
            
            if (ref<kOffsetY)
                break;
            
            if (ref>kOffsetY && ref<(rect.size.height-kOffsetY)){
                int value = floor(stepValue + (i*stepValue));
                NSString *theText = [NSString stringWithFormat:@"-%i",value];
                [theText drawAtPoint:NSMakePoint(kOffsetX/3, ref) withAttributes:attributedString];
            }
        }
        
        // draw positve Grid
        float yPos = originY + step;
        int i = 0;
        while (yPos<rect.size.height-kOffsetY) {
            int value = floor(stepValue + (i*stepValue));
            NSString *theText = [NSString stringWithFormat:@"%i",value];
            [theText drawAtPoint:NSMakePoint(kOffsetX/3, yPos) withAttributes:attributedString];
            i++;
            yPos = yPos + step;
        }
        
    }
}

-(void)drawXTextAxis
{
//    XLabels
    CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
    // Drawing text
    CGContextSelectFont(context, "Helvetica", 1, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGContextSetFillColorWithColor(context, [_axisColor CGColor]);

    NSUInteger step = (rect.size.width-(2*kOffsetX))/nbOfItems;
    NSUInteger nbOfTextElements = [xLabels count];
    
    for (int i = 0; i < nbOfItems; i++)
    {
        if (nbOfTextElements>i){
            NSString *theText = [xLabels objectAtIndex:i];
            int textWidth = [self calcSizeWithFontName:@"Helvetica" FontSize:1 andString:theText];
            CGContextShowTextAtPoint(context,(kOffsetX + step - (textWidth*5)) + i * step, originY - kOffsetY/2 , [theText cStringUsingEncoding:NSUTF8StringEncoding], [theText length]);
        }
    }
}

#pragma mark - utilities Tools
-(int)calcSizeWithFontName:(NSString*)fontName FontSize:(int)fontSize andString:(NSString*)string
{
    NSDictionary* attrs = [[NSDictionary alloc] initWithObjectsAndKeys:[NSFont fontWithName:fontName size:fontSize], NSFontAttributeName, nil];
    NSSize strSize = [string sizeWithAttributes:attrs];;
    return (strSize.width);
}

-(float)maxValue
{
    if ([values count]>0)
    {
        for (NSArray *items in values){
            maxValue = [[items objectAtIndex:0]floatValue];
            for(NSString *value in items)
                if([value floatValue]>maxValue)
                    maxValue = [value floatValue];
        }
    }
    else
        maxValue = 0;
    return maxValue;
}

-(float)minValue
{
    if ([values count]>0)
    {
        for (NSArray *items in values){
            minValue = [[items objectAtIndex:0]floatValue];
            for(NSString *value in items)
                if([value floatValue]<minValue)
                    minValue = [value floatValue];
        }
    }
    else
        minValue = 0;
    
    if (minValue<0)
        return minValue;
    else
        return 0;
}

-(int)maxHorizontalGridValue
{
    int maxValueFloor = floor(maxValue);
    NSString *numberString = [NSString stringWithFormat:@"%i",maxValueFloor];
    NSUInteger nbOfChar = [numberString length];
    NSUInteger firstDigit = [[numberString substringWithRange:NSMakeRange(0, 1)]intValue];
    
    int toReturn = firstDigit * pow(10, nbOfChar-1);
    
    return toReturn;
}

-(int)minHorizontalGridValue
{
    int toReturn;
    if (minValue<-1){
        int minValueFloor = floor(minValue);
        NSString *numberString = [NSString stringWithFormat:@"%i",minValueFloor];
        NSUInteger nbOfChar = [numberString length];
        NSUInteger firstDigit = [[numberString substringWithRange:NSMakeRange(1, 1)]intValue];
        toReturn = firstDigit * pow(10, nbOfChar-2);
    }
    else
        toReturn = 0;
    
    return toReturn;
}

-(int)nbHorizontalGridAfterOrigin
{
    int maxValueFloor = floor(maxValue);
    
    NSString *numberString = [NSString stringWithFormat:@"%i",maxValueFloor];
    int firstDigit = [[numberString substringWithRange:NSMakeRange(0, 1)]intValue];
    
    return firstDigit;
}

-(int)nbHorizontalGridBeforeOrigin
{
    int maxValueFloor = floor(-minValue);
    
    NSString *numberString = [NSString stringWithFormat:@"%i",maxValueFloor];
    int firstDigit = [[numberString substringWithRange:NSMakeRange(0, 1)]intValue];
    
    return firstDigit;
}

#pragma mark-Help tool
- (void)toggleAttachedWindowAtPoint:(NSPoint)pt withText:(NSString*)text
{
    // Attach/detach window.
    if (!attachedWindow) {
        if (rect.size.width>200 && rect.size.height>200){
            NSTextField *textView = [[NSTextField alloc]init];
            [textView setFrame:NSMakeRect(0, 0, 50, 20)];
            [textView setDrawsBackground:NO];
            [textView setBordered:NO];
            [textView setSelectable:NO];
            
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
            [style setAlignment:NSCenterTextAlignment];
            NSFont *font = [NSFont fontWithName:@"Helvetica" size:11];
            NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString: text
                                                                                   attributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                                                                _axisColor, NSForegroundColorAttributeName,
                                                                                                font, NSFontAttributeName,
                                                                                                style, NSParagraphStyleAttributeName,
                                                                                                nil]];
            [textView setAttributedStringValue:attributedString];
            
            attachedWindow = [[MAAttachedWindow alloc] initWithView:textView
                                                    attachedToPoint:pt
                                                           inWindow:[self window]
                                                             onSide:MAPositionLeftBottom
                                                         atDistance:5.0];
            [attachedWindow setBackgroundColor:_backgroundColor];
            [attachedWindow setHasArrow:0];
            
            [attachedWindow makeKeyAndOrderFront:self];
        }
    } else {
        [attachedWindow orderOut:self];
        attachedWindow = nil;
    }
}

@end
