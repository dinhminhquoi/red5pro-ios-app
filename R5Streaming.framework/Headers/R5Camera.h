//
//  R5Camera.h
//  red5streaming
//
//  Created by Andy Zupko on 10/31/14.
//  Copyright (c) 2014 Andy Zupko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "R5VideoSource.h"

@interface R5Camera : R5VideoSource

@property AVCaptureDevice *device;

-(id)initWithDevice:(AVCaptureDevice*)device andBitRate:(int)bitRate;

@end


@interface R5Microphone : NSObject

@property AVCaptureDevice *device;
@property int sampleRate;
@property int channels;
@property int bitrate;

-(id)initWithDevice:(AVCaptureDevice*)device;

@end