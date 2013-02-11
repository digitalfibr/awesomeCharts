//
//  SUGauge.h
//  awesomeCharts
//
//  Created by Antoine Lagadec on 06/02/13.
//  Copyright (c) 2013 Fabien. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    GaugeOrientationHorizontal,
    GaugeOrientationVertical
} GaugeOrientation;

@interface SUGauge : NSObject

@property (assign) float value;
@property (assign) CGRect rect;
@property (assign) GaugeOrientation orientation;

@property (strong) NSColor *backgroundColor;
@property (strong) NSColor *foregroundColor;

@property (assign) BOOL displayBackground;

- (void)drawInContext:(CGContextRef)context;
@end
