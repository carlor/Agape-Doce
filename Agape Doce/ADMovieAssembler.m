//
//  ADMovieAssembler.m
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
#import <QTKit/QTKit.h>
#import <Cocoa/Cocoa.h>
#import <OpenGL/OpenGL.h>

#import "ADMovieAssembler.h"
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
    
    NSError *error = nil;
    movie = [[QTMovie alloc] 
             initToWritableData:[NSMutableData data] 
             error:&error
             ];

    amountDone = 0;
    
    while (1) {
        ADScreenshotMessage *msg = [imageQueue take];
        if (msg == nil) {
            // empty, do nothing
        } else if ([msg terminate]) {
            break;
        } else {
            [self addImageToMovie:[self nsImageFromCGImageRef:[msg image]]];
            
        }
    }
    
    NSDictionary *dct = [NSDictionary dictionaryWithObjectsAndKeys:
                         [NSNumber numberWithBool:YES], QTMovieExport,
                         nil];
    
    [movie writeToFile:@"/Users/nathanmswan/agape_doce_buffer.mov" withAttributes:dct];
}

- (NSImage *)nsImageFromCGImageRef:(CGImageRef)cgimg {
    NSSize size;
    size.width = CGImageGetWidth(cgimg);
    size.height = CGImageGetHeight(cgimg);
    return [[NSImage alloc] initWithCGImage:cgimg size:size];
}

- (void)addImageToMovie:(NSImage *)img {
    NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"tiff", QTAddImageCodecType,
                              [NSNumber numberWithLong:codecNormalQuality],
                                    QTAddImageCodecQuality,
                              nil];
    
    // produces the image I want
    [[img TIFFRepresentation] writeToFile:@"/Users/nathanmswan/aaaa.tiff" atomically:YES];
    
    [movie addImage:img forDuration:frameInterval withAttributes:settings];
}

@end
