//
//  ADSafeQueue.m
//  Agape Doce
//
//  Created by Nathan Swan on 1/18/12.
//  Copyright (c) 2012 homeschooled. All rights reserved.
//


#import "ADSafeQueue.h"

#define MIN_SAFE_SIZE 100

// on the back end, an array whith thread-locking access
@implementation ADSafeQueue

- (ADSafeQueue*)init {
    self = [super init];
    
    array = [[NSMutableArray alloc] init];
    
    return self;
}

- (BOOL)empty {
    BOOL r;
    AD_LOCK (
         r = ([array count] == 0);
    )
    return r;
}

- (void)add:(id)obj {
    AD_LOCK (
        [array addObject:obj];
    )
}

- (id)take {
    id r;
    AD_LOCK (
        if ([array count]) {
            r = [array objectAtIndex:0];
            [array removeObjectAtIndex:0];
        } else {
            r = nil;
        }
    )
    return r;
}

@end
