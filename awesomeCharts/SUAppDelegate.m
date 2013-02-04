//
//  SUAppDelegate.m
//  essai
//
//  Created by Fabien on 24/01/13.
//  Copyright (c) 2013 Fabien. All rights reserved.
//

#import "SUAppDelegate.h"

@implementation SUAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

-(IBAction)refreshGraph:(id)sender
{
    NSArray *values = [[_valuesField stringValue]componentsSeparatedByString:@";"];
    NSArray *labels = [[_labelsField stringValue]componentsSeparatedByString:@";"];
    
    [_graph setValues:[NSArray arrayWithObject:values]
          andXLabels:labels];
    
    [_graph setBackgroundColor:[NSColor colorWithCalibratedRed:[_bgColor_R_Field floatValue]/255.0
                                                         green:[_bgColor_G_Field floatValue]/255.0
                                                          blue:[_bgColor_B_Field floatValue]/255.0
                                                         alpha:1]];
    
    [_graph setLineColor:[NSColor colorWithCalibratedRed:[_lineColor_R_Field floatValue]/255.0
                                                   green:[_lineColor_G_Field floatValue]/255.0
                                                    blue:[_lineColor_B_Field floatValue]/255.0
                                                   alpha:1]];
    
    [_graph setAxisColor:[NSColor colorWithCalibratedRed:[_axisColor_R_Field floatValue]/255.0
                                                   green:[_axisColor_G_Field floatValue]/255.0
                                                    blue:[_axisColor_B_Field floatValue]/255.0
                                                   alpha:1]];
    
    [_graph setGridColor:[NSColor colorWithCalibratedRed:[_gridColor_R_Field floatValue]/255.0
                                                   green:[_gridColor_G_Field floatValue]/255.0
                                                    blue:[_gridColor_B_Field floatValue]/255.0
                                                   alpha:1]];
    
    [_graph drawGridWithX_Axis:[_hasXAxis state]==1?YES:NO
                        y_axis:[_hasYAxis state]==1?YES:NO
                        x_grid:[_hasXGrid state]==1?YES:NO
                        y_grid:[_hasYGrid state]==1?YES:NO
                      gridType:0
                 x_description:[_hasXDescr state]==1?YES:NO
                 y_description:[_hasYDescr state]==1?YES:NO];
    
    [_graph setLineWidth:[NSNumber numberWithFloat:[[_lineWidthField stringValue]floatValue]]];

    [_graph hasPoints:([_hasPoints state]==1)?YES:NO];
    
    
    [_graph setNeedsDisplay:YES];
}

@end
