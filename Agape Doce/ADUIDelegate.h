//
//  ADUIDelegate.h - Agape Doce
//  An interface between the UI and the backend.
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

#import "ADSafeQueue.h"

@protocol ADUIDelegate <NSObject>

/// whether the UI should get a progress report, given the message queue
- (BOOL)acceptingProgress:(ADSafeQueue*)msgqueue;

/// update the UI progressReport
- (void)updateProgress:(NSUInteger)sofar;

/// tell the UI we're done, written movie to temporary file
- (void)doneAndProducedResult:(NSString*)tempfile;

@end

/// A simpler way to go about it
typedef id <ADUIDelegate> ADUIDelegateRef;
