//
//  SUGraphView.h
//  essai
//
//  Created by Fabien on 26/01/13.
//  Copyright (c) 2013 Fabien. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#define kOffsetX 50
#define kOffsetY 50
#define kCircleRadius 3
#define kHorizontalGrid 4

@interface SUGraphView : NSView
{
    NSArray *values;
    NSArray *xLabels;
    NSUInteger nbOfItems;
    float maxValue;
    float minValue;
    int maxHorizontGridValue;
    int minHorizontGridValue;
    float originY;
    float originX;
    NSRect rect;
}

-(void)drawAxisAndGrid;
-(void)drawGridWithX_Axis:(BOOL)hasXAxis y_axis:(BOOL)hasYAxis x_grid:(BOOL)hasXGrid y_grid:(BOOL)hasYGrid gridType:(int)gridType x_description:(BOOL)hasXDescription y_description:(BOOL)hasYDescription;

-(float)maxValue;
-(float)minValue;
-(int)calcSizeWithFontName:(NSString*)fontName FontSize:(int)fontSize andString:(NSString*)string;
-(void)drawBackgroundWithColor:(NSColor*)color;
- (void)toggleAttachedWindowAtPoint:(NSPoint)pt withText:(NSString*)text;

@property(strong) NSColor   *backgroundColor;
@property(strong) NSColor   *axisColor;
@property(strong) NSColor   *gridColor;

@end
