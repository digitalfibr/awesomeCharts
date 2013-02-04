//
//  SULineGraph.h
//  essai
//
//  Created by Fabien on 30/01/13.
//  Copyright (c) 2013 Fabien. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SUGraphView.h"

@interface SULineGraph : SUGraphView

-(void)setValues:(NSArray*)val andXLabels:(NSArray*)xlab;
-(void)drawLineGraph;
-(void)hasPoints:(BOOL)val;
-(void)mouseDisplayValues:(BOOL)val;

@property(strong) NSNumber  *lineWidth;
@property(strong) NSColor   *lineColor;

@end
