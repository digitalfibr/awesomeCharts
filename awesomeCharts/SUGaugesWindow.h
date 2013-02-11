//
//  SUGaugesHorizontalWindow.h
//  awesomeCharts
//
//  Created by Antoine Lagadec on 04/02/13.
//  Copyright (c) 2013 Fabien. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SUGaugesView.h"

@interface SUGaugesWindow : NSWindow

@property (weak) IBOutlet SUGaugesView *gaugesView;

@property (weak) IBOutlet NSTextField *widthField;
@property (weak) IBOutlet NSTextField *heightField;

@property (weak) IBOutlet NSTextField *paddingTopField;
@property (weak) IBOutlet NSTextField *paddingRightField;
@property (weak) IBOutlet NSTextField *paddingBottomField;
@property (weak) IBOutlet NSTextField *paddingLeftField;
@property (weak) IBOutlet NSTextField *spacingField;
@property (weak) IBOutlet NSSegmentedControl *orientationControl;

- (IBAction)refreshHorizontalGauges:(id)sender;

@end
