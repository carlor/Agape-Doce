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
#import "ADScreenshotMessage.h"

@implementation ADRecorder

- (void)startRecording {
    captureSession = [[AVCaptureSession alloc] init];
    
    screenInput = 
        [[AVCaptureScreenInput alloc] initWithDisplayID:CGMainDisplayID()];
    [captureSession addInput:screenInput];
    
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
