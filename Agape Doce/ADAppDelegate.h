//
//  ADAppDelegate.h - Agape Doce
//  This AppDelegate has all the outlets/actions and basically manages the UI.
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

#import <Cocoa/Cocoa.h>

#import "ADRecorder.h"


@interface ADAppDelegate : NSObject <NSApplicationDelegate, NSWindowDelegate>
{
    NSApplication *app;
    ADRecorder *recorder;
    BOOL closingBecauseOfSelf;
}


// --- actions ---
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

// --- utilities ---
void AD_show(NSWindow *win);
void AD_hide(NSWindow *win);

