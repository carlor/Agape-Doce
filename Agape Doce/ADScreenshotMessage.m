//
//  ADScreenshotMessage.m
//  Agape Doce
//
//  Created by Nathan Swan on 1/18/12.
//  Copyright (c) 2012 homeschooled. All rights reserved.
//

#import "ADScreenshotMessage.h"

@implementation ADScreenshotMessage

+ (ADScreenshotMessage*)messageWith:(CGImageRef)image {
    ADScreenshotMessage *sm = [[ADScreenshotMessage alloc] init];
    [sm setImage:image];
    [sm setTerminate:NO];
    return sm;
}

+ (ADScreenshotMessage*) terminationMessage {
    ADScreenshotMessage *sm = [[ADScreenshotMessage alloc] init];
    [sm setImage:nil];
    [sm setTerminate:YES];
    return sm;
}

@synthesize image;
@synthesize terminate;

@end
