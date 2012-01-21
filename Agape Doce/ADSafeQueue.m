//
//  ADSafeQueue.m
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


#import "ADSafeQueue.h"

// on the back end, an array whith thread-locking access
@implementation ADSafeQueue

- (ADSafeQueue*)init {
    self = [super init];
    
    array = [[NSMutableArray alloc] init];
    
    return self;
}

- (BOOL)empty {
    BOOL r;
    @synchronized(array) {
         r = ([array count] == 0);
    }
    return r;
}

- (NSUInteger)size {
    @synchronized(array) {
        return [array count];
    }
}

- (void)add:(id)obj {
    @synchronized(array) {
        [array addObject:obj];
    }
}

- (id)take {
    id r;
    @synchronized(array) {
        if ([array count]) {
            r = [array objectAtIndex:0];
            [array removeObjectAtIndex:0];
        } else {
            r = nil;
        }
    }
    return r;
}

@end
