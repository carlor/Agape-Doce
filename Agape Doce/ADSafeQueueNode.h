//
//  ADSafeQueueNode.h
//  Agape Doce
//
//  Created by Nathan Swan on 1/18/12.
//  Copyright (c) 2012 homeschooled. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADSafeQueueNode : NSObject

@property (assign) ADSafeQueueNode *nodeTowardsHead;
@property (assign) id elem;
@property (assign) ADSafeQueueNode *nodeTowardsTail;


@end
