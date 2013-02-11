//
//  SUGaugesHorizontalWindow.m
//  awesomeCharts
//
//  Created by Antoine Lagadec on 04/02/13.
//  Copyright (c) 2013 Fabien. All rights reserved.
//

#import "SUGaugesWindow.h"

@implementation SUGaugesWindow

- (IBAction)refreshHorizontalGauges:(id)sender
{
    _gaugesView.gaugeWidth = [_widthField floatValue];
    _gaugesView.gaugeHeight = [_heightField floatValue];
    
    _gaugesView.paddingTop = [_paddingTopField floatValue];
    _gaugesView.paddingRight = [_paddingRightField floatValue];
    _gaugesView.paddingBottom = [_paddingBottomField floatValue];
    _gaugesView.paddingLeft = [_paddingLeftField floatValue];
    
    _gaugesView.gaugeSpacing = [_spacingField floatValue];
    
    _gaugesView.orientation = (_orientationControl.selectedSegment == 0) ? GaugeOrientationHorizontal : GaugeOrientationVertical;
    
    NSLog(@"%i", _gaugesView.orientation);
    
    [_gaugesView refresh];
}

@end
