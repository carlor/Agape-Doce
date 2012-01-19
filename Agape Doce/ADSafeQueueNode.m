//
//  ADSafeQueueNode.m
//  Agape Doce
//
//  Created by Nathan Swan on 1/18/12.
//  Copyright (c) 2012 homeschooled. All rights reserved.
//

#import "ADSafeQueueNode.h"

@implementation ADSafeQueueNode

-(ADSafeQueueNode*)init {
    self = [super init];
    self.nodeTowardsHead = nil;
    self.nodeTowardsTail = nil;
    return self;
}

@synthesize nodeTowardsHead;
@synthesize elem;
@synthesize nodeTowardsTail;

@end
