//
//  ADRecorder.h
//  Agape Doce
//
//  Created by Nathan Swan on 1/3/12.
//  Copyright (c) 2012 homeschooled. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QTKit/QTKit.h>
#import <OpenGL/OpenGL.h>

#import "ADMovieAssembler.h"

typedef enum {
    ADNotRecordingState,
    ADIsRecordingState,
    ADPausedRecordingState
} ADRecordingState;

@interface ADRecorder : NSObject
{
    ADRecordingState recState;
    NSTimer *timer;
    NSTimeInterval frameInterval;
    ADMovieAssembler *movasm;
    ADSafeQueue *imageQueue;
}

/// starts recording
-(void)startRecording;

/// stops recording
-(void)stopRecording;

/// pauses recording
-(void)pauseRecording;

// the thread that does the screen recording
-(void)runThread:(id)unusedParam;

// decomposition of runThread
-(BOOL)doAction;
-(void)addScreenshot;



@end



