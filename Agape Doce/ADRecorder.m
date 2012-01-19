//
//  ADRecorder.m
//  Agape Doce
//
//  Created by Nathan Swan on 1/3/12.
//  Copyright (c) 2012 homeschooled. All rights reserved.
//

#import "ADRecorder.h"
#import <OpenGL/OpenGL.h>
#import <Cocoa/Cocoa.h>

#import "ADScreenshotMessage.h"

@implementation ADRecorder

- (ADRecorder *)init {
    self = [super init];
    if (self) {
        
        frameInterval = 1.0 / 30;
        
        NSMethodSignature *mt = 
            [ADRecorder instanceMethodSignatureForSelector:@selector(doAction)];
        NSInvocation *inv = 
            [NSInvocation invocationWithMethodSignature:mt];
        [inv setTarget:self];
        [inv setSelector:@selector(doAction)];
        timer = [NSTimer 
                 timerWithTimeInterval:frameInterval 
                 invocation:inv repeats:YES];
    }
    return self;
}

- (void)startRecording {
    NSLog(@"starting");
    recState = ADIsRecordingState;
    [NSThread detachNewThreadSelector:@selector(runThread:) 
                             toTarget:self withObject:nil];
}

- (void)stopRecording {
    NSLog(@"stopping");
    recState = ADNotRecordingState;
}

- (void)pauseRecording {
    NSLog(@"pausing");
    recState = ADPausedRecordingState;
}

- (void)runThread:(id)unusedParam {
    imageQueue = [[ADSafeQueue alloc] init];
    movasm = [[ADMovieAssembler alloc] initWithQueue:imageQueue 
                                       frameInterval:frameInterval];
    [movasm start];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    BOOL shouldContinue = YES;
    while (shouldContinue) {
        shouldContinue = [self doAction];
        [NSThread sleepForTimeInterval:frameInterval];
    }
}

// returns whether should continue
- (BOOL)doAction {
    NSLog(@"doing action");
    switch (recState) {
        case ADIsRecordingState:
            [self addScreenshot];
            return YES;
        case ADPausedRecordingState:
            // do nothing
            return YES;
        case ADNotRecordingState:
            // stop
            [imageQueue add:[ADScreenshotMessage terminationMessage]];
            return NO;
    }
}

- (void)addScreenshot {
    CGImageRef screenshot = CGDisplayCreateImage(CGMainDisplayID());
    [imageQueue add:[ADScreenshotMessage messageWith:screenshot]];
}

@end


