//
//  NSColor+CGColor.h
//  awesomeCharts
//
//  Created by Antoine Lagadec on 04/02/13.
//  Copyright (c) 2013 Fabien. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

@interface NSColor (CGColor)

//
// The Quartz color reference that corresponds to the receiver's color.
//
@property (nonatomic, readonly) CGColorRef CGColor;

//
// Converts a Quartz color reference to its NSColor equivalent.
//
+ (NSColor *)colorWithCGColor:(CGColorRef)color;

@end