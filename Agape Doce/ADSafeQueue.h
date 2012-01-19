//
//  ADSafeQueue.h
//  Agape Doce
//
//  Created by Nathan Swan on 1/18/12.
//  Copyright (c) 2012 homeschooled. All rights reserved.
//

#import <Foundation/Foundation.h>


#define AD_LOCK(B) NSLock*_l=[[NSLock alloc]init];[_l lock];B [_l unlock];
#define AD_LOCK_IF(T, B) if(T){AD_LOCK(B)}else{B}

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
