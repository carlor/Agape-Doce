//
//  ADScreenshotMessage.h - Agape Doce
//  The message that either gives an image or tells the assembler there's no
//  more images.
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

@interface ADScreenshotMessage : NSObject

/// A message with an image.
+ (ADScreenshotMessage*)messageWith:(CGImageRef)image;

/// A termination message.
+ (ADScreenshotMessage*)terminationMessage;

/// The image in the message. If it's a termination message, this value can be
/// anything.
@property (assign) CGImageRef image;

/// Whether the message is a termination message.
@property (assign) BOOL terminate;

@end
