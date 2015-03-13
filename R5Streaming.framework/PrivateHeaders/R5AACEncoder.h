//
//  AudioEncoder.h
//  Encoder Demo
//
//  Created by Geraint Davies on 14/01/2013.
//  Copyright (c) 2013 GDCL http://www.gdcl.co.uk/license.htm
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "AVFoundation/AVAssetWriter.h"
#import "AVFoundation/AVAssetWriterInput.h"
#import "AVFoundation/AVMediaFormat.h"
#import "AVFoundation/AVVideoSettings.h"
#import "sys/stat.h"
#include "MP4Atom.h"
#import "R5Camera.h"





typedef int (^encoder_handler_t)(NSArray* data, double pts);
typedef int (^param_handler_t)(NSData* params);

@interface R5AACEncoder : NSObject

- (void) encodeWithBlock:(encoder_handler_t) block onParams: (param_handler_t) paramsHandler;
- (void) encodeFrame:(CMSampleBufferRef) sampleBuffer ofType:(int)media_type;

- (void) shutdown;
+ (R5AACEncoder*) encoderForMicrophone:(R5Microphone*)microphone;



@property int sampleRate;
@property int channels;
@property int bitrate;
@property dispatch_queue_t encoderQueue;
@end
