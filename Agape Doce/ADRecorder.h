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
#import <QTKit/QTKit.h>
#import <OpenGL/OpenGL.h>

#import "ADMovieAssembler.h"

/// The recording state is whether it is playing, stopped, or paused
typedef enum {
    ADNotRecordingState,
    ADIsRecordingState,
    ADPausedRecordingState
} ADRecordingState;

@interface ADRecorder : NSObject
{
    ADRecordingState recState;
    NSTimeInterval frameInterval; // the length for frames
    ADMovieAssembler *movasm;
    ADSafeQueue *imageQueue;
}

/// starts recording
-(void)startRecording;

/// stops recording
-(void)stopRecording;

/// pauses recording
-(void)pauseRecording;

/// the state of the recorder
-(ADRecordingState)recordingState;

// the thread that does the screen recording
-(void)runThread:(id)unusedParam;

// decomposition of runThread
-(BOOL)doAction;
-(void)addScreenshot;



@end



