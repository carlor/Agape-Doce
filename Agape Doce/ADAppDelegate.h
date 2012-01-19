//
//  ADAppDelegate.h
//  Agape Doce
//
//  Created by Nathan Swan on 12/26/11.
//  Copyright (c) 2011 Nathan M. Swan. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ADRecorder.h"


@interface ADAppDelegate : NSObject <NSApplicationDelegate, NSWindowDelegate>
{
    NSApplication *app;
    ADRecorder *recorder;
    BOOL closingBecauseOfSelf;
}


// --- actions ---
//- (IBAction)startWindowClosed:(id)sender;

- (IBAction)recordButtonPressed:(id)sender;
- (IBAction)stopButtonPressed:(id)sender;
- (IBAction)pauseButtonPressed:(id)sender;

// --- outlets ---
@property (assign) IBOutlet NSWindow *startWindow;
@property (unsafe_unretained) IBOutlet NSWindow *controlWindow;

@property (weak) IBOutlet NSButton *recordButton;
@property (weak) IBOutlet NSButton *stopButton;
@property (weak) IBOutlet NSButton *pauseButton;

@end

// --- private utilities ---
void AD_show(NSWindow *win);
void AD_hide(NSWindow *win);

