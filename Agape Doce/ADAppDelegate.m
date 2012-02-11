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

@implementation ADAppDelegate

// --- outlets ---
@synthesize startWindow = _window;
@synthesize controlWindow;

@synthesize recordButton;
@synthesize micMenu;
@synthesize screenMenu;
@synthesize stopButton;
@synthesize pauseButton;

// it closes because of self
- (ADAppDelegate *)init {
    self = [super init];
    return self;
}

// --- NSApplicationDelegate implementation ---
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [micMenu removeAllItems];
    [micMenu addItemsWithTitles:[ADRecorder micnames]];
    
    [screenMenu removeAllItems];
    [screenMenu addItemsWithTitles:[ADRecorder screennames]];
}

// --- actions ---
- (IBAction)recordButtonPressed:(id)sender {
    recorder = [[ADRecorder alloc] init];
    
    [recorder setMicID:[micMenu indexOfSelectedItem]];
    [recorder setScreenID:[screenMenu indexOfSelectedItem]];
    
    @try {
        [recorder startRecording];
    } @catch (NSError *err) {
        NSAlert *al = [NSAlert alertWithError:err];
        [al runModal];
        recorder = nil;
    }
    
    if (recorder) {
        AD_hide([self startWindow]);
        AD_show([self controlWindow]);
    }
}

- (IBAction)stopButtonPressed:(id)sender {
    [recorder stopRecording];
    
    AD_hide(controlWindow);
    AD_show([self startWindow]);
    
    NSSavePanel *sp = [NSSavePanel savePanel];
    [sp setAllowedFileTypes:[NSArray arrayWithObject:@"mov"]];
    
    while (1) {
        NSUInteger result = [sp runModal];
        if (result == NSOKButton) {
            NSError *error = nil;
            
            BOOL good = [[NSFileManager defaultManager] 
                         moveItemAtURL:[recorder outputURL]
                         toURL:[sp URL]
                         error:&error
                         ];
            if (!good) {
                [[NSAlert alertWithError:error] runModal];
            } else break;
        } else {
            NSString *msg = @"Are you sure you want to cancel?";
            NSString *inftext = 
            @"Failing to save will result in the loss of your work.";
            NSInteger warnrst = [[NSAlert
                                  alertWithMessageText:msg
                                  defaultButton:@"Yes" 
                                  alternateButton:@"No" 
                                  otherButton:nil 
                                  informativeTextWithFormat:inftext
                                  ]
                                 runModal];
            if (warnrst == NSAlertDefaultReturn) {
                break;
            }
        }
    }
    
}

- (IBAction)pauseButtonPressed:(id)sender {
    if ([recorder recordingState] == ADIsRecordingState) {
        [stopButton setEnabled:NO];
    } else {
        [stopButton setEnabled:YES];
    }
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

