//
//  ADSafeQueue.h - Agape Doce
//  A thread-safe queue, right now a synchronized wrapper to an NSMutable array.
//  
//  Eventually I want to make it a doubly-linked list which would, though taking
//  up more memory, would be cheaper because synchronization would only have to
//  refer to nodes rather than the entire array.
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

/**
 * A thread-safe queue that locks when in use. Only suitable for ids.
 */
@interface ADSafeQueue : NSObject
{
    NSMutableArray *array;
}


/// Tests whether it is empty.
-(BOOL)empty;

/// Adds an object to the tail.
-(void)add:(id)obj;

/// Removes an object from the head.
-(id)take;

@end
