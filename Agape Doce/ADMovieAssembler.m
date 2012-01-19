//
//  ADMovieAssembler.m
//  Agape Doce
//
//  Created by Nathan Swan on 1/18/12.
//  Copyright (c) 2012 homeschooled. All rights reserved.
//

#import "ADMovieAssembler.h"
#import <QTKit/QTKit.h>
#import <Cocoa/Cocoa.h>
#import <OpenGL/OpenGL.h>
#import "ADScreenshotMessage.h"

@implementation ADMovieAssembler

- (ADMovieAssembler*)initWithQueue:(ADSafeQueue*)queue
                     frameInterval:(NSTimeInterval)interval {
    self = [super init];
    
    imageQueue = queue;
    frameInterval = QTMakeTimeWithTimeInterval(interval);
    
    return self;
}

- (void)start {
    [NSThread detachNewThreadSelector:@selector(runThread) 
              toTarget:self withObject:nil];
}

- (void)runThread {
    NSLog(@"running thread");
    movie = [[QTMovie alloc] init];
    NSDictionary *dict = [[NSDictionary alloc] init];
    NSUInteger i=0;
    while (1) {
        while ([imageQueue empty]) {}
        ADScreenshotMessage *msg;
        AD_LOCK (
            msg = [imageQueue take];
        )
        if ([msg terminate]) {
            break;
        } else {
            NSImage *img = [self nsImageFromCGImageRef:[msg image]];
            
            [[img TIFFRepresentation] 
             writeToFile:
             [[NSString alloc] 
              initWithFormat:@"/Users/nathanmswan/agimgs/%d.tiff", i++]
             atomically:NO];
            
            [movie addImage:img forDuration:frameInterval withAttributes:dict];
        }
    }
    NSLog(@"about to write");
    [movie writeToFile:@"/Users/nathanmswan/aagapetest.mov" 
           withAttributes:[[NSDictionary alloc] init]];
    NSLog(@"done writing");
}

- (NSImage *)nsImageFromCGImageRef:(CGImageRef)cgimg {
    NSSize size;
    size.width = CGImageGetWidth(cgimg);
    size.height = CGImageGetHeight(cgimg);
    return [[NSImage alloc] initWithCGImage:cgimg size:size];
}

@end
