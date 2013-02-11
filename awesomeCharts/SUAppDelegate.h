//
//  SUAppDelegate.h
//  essai
//
//  Created by Fabien on 24/01/13.
//  Copyright (c) 2013 Fabien. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SULineGraph.h"

@interface SUAppDelegate : NSObject <NSApplicationDelegate>

-(IBAction)refreshGraph:(id)sender;

@property (strong) IBOutlet NSWindow    *window;
@property (strong) IBOutlet NSTextField *valuesField;
@property (strong) IBOutlet NSTextField *labelsField;
@property (strong) IBOutlet NSTextField *lineWidthField;
@property (strong) IBOutlet NSTextField *lineColor_R_Field;
@property (strong) IBOutlet NSTextField *lineColor_G_Field;
@property (strong) IBOutlet NSTextField *lineColor_B_Field;
@property (strong) IBOutlet NSTextField *bgColor_R_Field;
@property (strong) IBOutlet NSTextField *bgColor_G_Field;
@property (strong) IBOutlet NSTextField *bgColor_B_Field;
@property (strong) IBOutlet NSTextField *axisColor_R_Field;
@property (strong) IBOutlet NSTextField *axisColor_G_Field;
@property (strong) IBOutlet NSTextField *axisColor_B_Field;
@property (strong) IBOutlet NSTextField *gridColor_R_Field;
@property (strong) IBOutlet NSTextField *gridColor_G_Field;
@property (strong) IBOutlet NSTextField *gridColor_B_Field;
@property (strong) IBOutlet SULineGraph *graph;
@property (strong) IBOutlet NSButton    *hasXAxis;
@property (strong) IBOutlet NSButton    *hasYAxis;
@property (strong) IBOutlet NSButton    *hasXGrid;
@property (strong) IBOutlet NSButton    *hasYGrid;
@property (strong) IBOutlet NSButton    *hasXDescr;
@property (strong) IBOutlet NSButton    *hasYDescr;
@property (strong) IBOutlet NSButton    *hasPoints;

@end
