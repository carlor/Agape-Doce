//
//  ADMovieAssembler.h
//  Agape Doce
//
//  Created by Nathan Swan on 1/18/12.
//  Copyright (c) 2012 homeschooled. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADSafeQueue.h"
#import <QTKit/QTKit.h>

/**
 * This thread takes the constant screenshots and makes a QTMovie out of it.
 */
@interface ADMovieAssembler : NSObject
{
    ADSafeQueue *imageQueue;
    QTMovie *movie;
    QTTime frameInterval;
}

- (ADMovieAssembler*)initWithQueue:(ADSafeQueue*)queue
                     frameInterval:(NSTimeInterval)interval;

// starts the thread
- (void)start;

// the thread running selector
- (void)runThread;

// decomposition
- (NSImage*)nsImageFromCGImageRef:(CGImageRef)cgimg;

@end
