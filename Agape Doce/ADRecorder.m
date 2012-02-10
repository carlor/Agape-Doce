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


#import <Cocoa/Cocoa.h>

#import "ADRecorder.h"

@implementation ADRecorder

static NSArray *micarray = nil;
static NSArray *micnames = nil;

+(NSArray *)micnames {
    if (micarray == nil) {
        NSMutableArray *mmicarray = [[NSMutableArray alloc] init];
        NSMutableArray *mmicnames = [[NSMutableArray alloc] init];
        AVCaptureDevice *dfault = [AVCaptureDevice
                                   defaultDeviceWithMediaType:AVMediaTypeAudio
                                   ];
        [mmicarray addObject:dfault];
        
        [mmicnames addObject:@"None"];
        [mmicnames addObject:[dfault localizedName]];
        
        NSArray *dvs = [AVCaptureDevice devices];
        NSUInteger len = [dvs count];
        for (NSUInteger i=0; i<len; i++) {
            AVCaptureDevice *d = [dvs objectAtIndex:i];
            if (d != dfault) {
                [mmicarray addObject:d];
                [mmicnames addObject:[d localizedName]];
            }
        }
        micarray = mmicarray;
        micnames = mmicnames;
    }
    return micnames;
}

static NSArray *screenarray = nil;
static NSArray *screennames = nil;

+(NSArray *)screennames {
    if (screenarray == nil) {
        NSMutableArray *mscreenarray = [[NSMutableArray alloc] init];
        NSMutableArray *mscreennames = [[NSMutableArray alloc] init];
        
        CGDirectDisplayID dfault = CGMainDisplayID();
        [mscreenarray addObject:AD_boxDisplayID(dfault)];
        [mscreennames addObject:AD_nameOf(dfault)];
        
        // find number of displays
        uint32_t ndisplays;
        CGGetActiveDisplayList(0, NULL, &ndisplays);
        
        CGDirectDisplayID *displayp = 
            malloc(ndisplays * sizeof(CGDirectDisplayID) );
        CGDirectDisplayID *olddisplayp = displayp;
        if (displayp) {
            CGGetActiveDisplayList(ndisplays, displayp, &ndisplays);
            
            for (uint32_t i=0; i<ndisplays; i++, displayp++) {
                if (*displayp != dfault) {
                    [mscreenarray
                        addObject:AD_boxDisplayID(*displayp)
                     ];
                    [mscreennames addObject:AD_nameOf(*displayp)];
                }
            }
            
            free(olddisplayp);
        } // else failure, it will only show main screen
        
        screenarray = mscreenarray;
        screennames = mscreennames;
    }
    return screennames;
}

@synthesize micID;
@synthesize screenID;


- (void)startRecording {
    NSError *error = nil;
    
    captureSession = [[AVCaptureSession alloc] init];
    
    screenInput = [[AVCaptureScreenInput alloc] 
                   initWithDisplayID:AD_deboxDisplayID([screenarray 
                                       objectAtIndex:[self screenID]
                                      ])
                   ];
    
    [captureSession addInput:screenInput];
    
    if (micID) {
        audio = [AVCaptureDeviceInput
                 deviceInputWithDevice:[micarray objectAtIndex:[self micID]-1]
                 error:&error
                 ];
        
        if (error) {
            @throw error;
        }
        [captureSession addInput:audio];
    }
    
    movieOutput = [[AVCaptureMovieFileOutput alloc] init];
    [captureSession addOutput:movieOutput];
    
    [captureSession startRunning];
    [movieOutput startRecordingToOutputFileURL:AD_tempFile() recordingDelegate:self];
    
    recState = ADIsRecordingState;
}

- (void)stopRecording {
    if (recState == ADPausedRecordingState) {
        [self pauseRecording];
    }
    if (recState == ADIsRecordingState) {
        [movieOutput stopRecording];
        [captureSession stopRunning];
        recState = ADNotRecordingState;
    }
}

- (void)pauseRecording {
    if (recState == ADIsRecordingState) {
        [movieOutput pauseRecording];
        recState = ADPausedRecordingState;
    } else {
        [movieOutput resumeRecording];
        recState = ADIsRecordingState;
    }
    
}

- (ADRecordingState)recordingState {
    return recState;
}

- (NSURL*)outputURL {
    return AD_tempFile();
}

// --- AVCaptureFileOutputRecordingDeletate implementation ---
// note, we don't care, so these are all blank
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL forConnections:(NSArray *)connections {}
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput willFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL forConnections:(NSArray *)connections dueToError:(NSError *)error {}
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error {}
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didPauseRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections {}
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didResumeRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections {}


@end

// --- private utilities ---
id AD_boxDisplayID(CGDirectDisplayID display) {
    return [NSData dataWithBytes:&display length:sizeof(CGDirectDisplayID*)];
}

CGDirectDisplayID AD_deboxDisplayID(id box) {
    return *(CGDirectDisplayID*)[box bytes];
}


NSURL *AD_tempFile() {
    return [NSURL 
            fileURLWithPath:[NSString 
                             stringWithFormat:
                                @"%s/agapedocebuffer%d.mov",
                                NSTemporaryDirectory(),
                                getpid()
                             ] 
            isDirectory:NO
            ];
}

static int nsupscreens = 0;
NSString *AD_nameOf(CGDirectDisplayID did) {
    if (did == CGMainDisplayID()) {
        return @"Main Screen";
    } else {
        return [NSString stringWithFormat:@"Supplementary Screen %d", 
                                          ++nsupscreens
                ];
    }
}

