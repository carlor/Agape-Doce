//
//  ADMovieAssembler.h - Agape Doce
//  Takes all the images from the message queue and processes them.
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

#import "ADUIDelegate.h"
#import "ADSafeQueue.h"

/**
 * This thread takes the constant screenshots and makes a QTMovie out of it.
 */
@interface ADMovieAssembler : NSObject
{
    ADSafeQueue *imageQueue;
    QTMovie *movie;
    QTTime frameInterval;
    CVImageBufferRef iBuff;
    long long amountDone;
    ADUIDelegateRef ui;
}

- (ADMovieAssembler*)initWithQueue:(ADSafeQueue*)queue
                     frameInterval:(NSTimeInterval)interval
                     ui:(ADUIDelegateRef)ui;

// starts the thread
- (void)start;

// the thread running selector
- (void)runThread;

// decomposition
- (NSImage*)nsImageFromCGImageRef:(CGImageRef)cgimg;
- (void)addImageToMovie:(NSImage*)img;

@end
