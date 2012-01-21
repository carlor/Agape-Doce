//
//  ADAppDelegate.m
//  Agape Doce
// 
//  Agape Doce is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
// 
//  Agape Doce is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
// 
//  You should have received a copy of the GNU General Public License
//  along with Agape Doce.  If not, see <http://www.gnu.org/licenses/>.
//  


#import "ADAppDelegate.h"

// how often the progress bar should update
#define UPDATE_FRACTION 2

@implementation ADAppDelegate

// --- outlets ---
@synthesize startWindow = _window;
@synthesize controlWindow;
@synthesize assemblyProgressWindow;
@synthesize assemblyProgressBar;

@synthesize recordButton;
@synthesize stopButton;
@synthesize pauseButton;

// it closes because of self
- (ADAppDelegate *)init {
    self = [super init];
    if (self) {
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
    // this way, when the window is hidden for recording, it doesn't quit
    if (!closingBecauseOfSelf) {
        [app terminate:self];
    }
}

// --- ADUIDelegate implementation ---
- (BOOL)acceptingProgress:(ADSafeQueue*)msgqueue {
    BOOL r = [recorder recordingState] == ADNotRecordingState;
    if (r && ![assemblyProgressWindow isVisible]) {
        queueLength = [msgqueue size];
        
        AD_hide(controlWindow);
        AD_show(assemblyProgressWindow);
    }
    return r;
}

- (void)updateProgress:(NSUInteger)sofar {
    if (sofar % UPDATE_FRACTION) {
        double value = (sofar / queueLength);
        [assemblyProgressBar setDoubleValue:value];
        [assemblyProgressBar displayIfNeeded];
    }
}

- (void)doneAndProducedResult:(NSString*)tempFile {
    AD_hide(assemblyProgressWindow);
    AD_show([self startWindow]);
}

// --- actions ---
- (IBAction)recordButtonPressed:(id)sender {
    closingBecauseOfSelf = YES;
    
    AD_hide([self startWindow]);
    AD_show([self controlWindow]);
    
    recorder = [[ADRecorder alloc] initWithUI:self];
    [recorder startRecording];
    
    closingBecauseOfSelf = NO;
}

- (IBAction)stopButtonPressed:(id)sender {
    [recorder stopRecording];
}

- (IBAction)pauseButtonPressed:(id)sender {
    [recorder pauseRecording];
}

@end

// --- private utilities ---

// shows the window
void AD_show(NSWindow *win) {
    [win makeKeyAndOrderFront:nil];
}

// hides the window
void AD_hide(NSWindow *win) {
    [win orderOut:nil];
}

