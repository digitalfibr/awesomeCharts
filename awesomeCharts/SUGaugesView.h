//
//  SUGaugesHorizontal.h
//  awesomeCharts
//
//  Created by Antoine Lagadec on 04/02/13.
//  Copyright (c) 2013 Fabien. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SUGraphView.h"
#import "SUGauge.h"

@interface SUGaugesView : SUGraphView

@property(strong) NSMutableArray *gauges;

@property(assign) GaugeOrientation orientation;

@property(assign) float gaugeSpacing;
@property(assign) float gaugeWidth;
@property(assign) float gaugeHeight;

@property(assign) float paddingTop;
@property(assign) float paddingRight;
@property(assign) float paddingBottom;
@property(assign) float paddingLeft;

-(void)refresh;

@end
