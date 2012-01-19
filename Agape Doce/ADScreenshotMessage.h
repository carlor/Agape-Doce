//
//  ADScreenshotMessage.h
//  Agape Doce
//
//  Created by Nathan Swan on 1/18/12.
//  Copyright (c) 2012 homeschooled. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADScreenshotMessage : NSObject

+ (ADScreenshotMessage*)messageWith:(CGImageRef)image;
+ (ADScreenshotMessage*)terminationMessage;

@property (assign) CGImageRef image;
@property (assign) BOOL terminate;

@end
