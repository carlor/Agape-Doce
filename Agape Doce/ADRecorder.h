//
//  ADRecorder.h - Agape Doce
//  The ADRecorder manages the taking of pictures in a separate thread. It uses
//  an ADMovieAssembler (and another thread) to process and assemble the images.
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

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

/// The recording state is whether it is playing, stopped, or paused
typedef enum {
    ADNotRecordingState,
    ADIsRecordingState,
    ADPausedRecordingState
} ADRecordingState;

@interface ADRecorder : NSObject <AVCaptureFileOutputRecordingDelegate>
{
    ADRecordingState recState;
    
    AVCaptureSession *captureSession;
    AVCaptureScreenInput *screenInput;
    AVCaptureMovieFileOutput *movieOutput;
}

/// starts recording
-(void)startRecording;

/// stops recording
-(void)stopRecording;

/// pauses recording; resumes if already paused
-(void)pauseRecording;

/// the state of the recorder
-(ADRecordingState)recordingState;

/// the output file of the most recent recording
-(NSURL*)outputURL;

@end

// --- private utilities ---
NSURL *AD_tempFile(void);

