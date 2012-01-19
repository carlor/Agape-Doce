//
//  ADAppDelegate.m
//  Agape Doce
//
//  Created by Nathan Swan on 12/26/11.
//  Copyright (c) 2011 Nathan M. Swan. All rights reserved.
//

#import "ADAppDelegate.h"

@implementation ADAppDelegate
@synthesize recordButton;
@synthesize stopButton;
@synthesize pauseButton;

@synthesize startWindow = _window;
@synthesize controlWindow;

- (ADAppDelegate *)init {
    self = [super init];
    if (self) {
        recorder = [[ADRecorder alloc] init];
        closingBecauseOfSelf = NO;
    }
    return self;
}

// --- NSApplicationDelegate implementation ---
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    app = [aNotification object];
    [[self startWindow] setDelegate:self];
}


// --- NSWindowDelegate implementation ---
- (void)windowWillClose:(NSNotification *)notification
{
    if (!closingBecauseOfSelf) {
        [app terminate:self];
    }
}

// --- actions ---
- (IBAction)recordButtonPressed:(id)sender {
    closingBecauseOfSelf = YES;
    
    AD_hide([self startWindow]);
    AD_show([self controlWindow]);
    [recorder startRecording];
    
    closingBecauseOfSelf = NO;
}

- (IBAction)stopButtonPressed:(id)sender {
    AD_hide([self controlWindow]);
    AD_show([self startWindow]);
    [recorder stopRecording];
}

- (IBAction)pauseButtonPressed:(id)sender {
    [recorder pauseRecording];
}

@end

// --- private utilities ---

void AD_show(NSWindow *win) {
    [win makeKeyAndOrderFront:nil];
}

void AD_hide(NSWindow *win) {
    [win orderOut:nil];
}

