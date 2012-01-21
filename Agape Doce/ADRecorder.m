//
//  ADRecorder.m
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


#import <OpenGL/OpenGL.h>
#import <Cocoa/Cocoa.h>

#import "ADRecorder.h"
#import "ADScreenshotMessage.h"

@implementation ADRecorder

- (ADRecorder *)init {
    self = [super init];
    if (self) {
        frameInterval = 1.0 / 30; // 30 frames per second
    }
    return self;
}

- (void)startRecording {
    recState = ADIsRecordingState;
    
    [NSThread detachNewThreadSelector:@selector(runThread:) 
                             toTarget:self withObject:nil];
}

- (void)stopRecording {
    recState = ADNotRecordingState;
}

- (void)pauseRecording {
    recState = ADPausedRecordingState;
}

- (ADRecordingState)recordingState {
    return recState;
}

- (void)runThread:(id)unusedParam {
    imageQueue = [[ADSafeQueue alloc] init];
    movasm = [[ADMovieAssembler alloc] initWithQueue:imageQueue 
                                       frameInterval:frameInterval];
    [movasm start];
    
    BOOL shouldContinue = YES;
    while (shouldContinue) {
        shouldContinue = [self doAction];
        [NSThread sleepForTimeInterval:frameInterval];
    }
}

// returns whether should continue
- (BOOL)doAction {
    switch (recState) {
            
        case ADIsRecordingState:
            [self addScreenshot];
            return YES;
            
        case ADPausedRecordingState:
            return YES;
            
        case ADNotRecordingState:
            [imageQueue add:[ADScreenshotMessage terminationMessage]];
            return NO;
    }
}

- (void)addScreenshot {
    CGImageRef screenshot = CGDisplayCreateImage(CGMainDisplayID());
    [imageQueue add:[ADScreenshotMessage messageWith:screenshot]];
}

@end


