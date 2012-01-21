//
//  ADScreenshotMessage.m
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
