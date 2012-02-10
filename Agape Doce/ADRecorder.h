//
//  ADRecorder.h
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
    AVCaptureDeviceInput *audio;
    
    AVCaptureMovieFileOutput *movieOutput;
}

/// gets all the mics (including None) into a list of strings
+(NSArray*)micnames;

/// gets all the screen names
+(NSArray*)screennames;

/// ids
@property NSInteger micID;
@property NSInteger screenID;

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
id AD_boxDisplayID(CGDirectDisplayID disp);
CGDirectDisplayID AD_deboxDisplayID(id box);

NSURL *AD_tempFile(void);
NSString *AD_nameOf(CGDirectDisplayID display);

