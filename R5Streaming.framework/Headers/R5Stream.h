//
//  R5Stream.h
//  Red5Pro
//
//  Created by Andy Zupko on 9/16/14.
//  Copyright (c) 2014 Andy Zupko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "global.h"
#import "R5Connection.h"
#import "R5Camera.h"
#import "R5Configuration.h"
#include <AVFoundation/AVFoundation.h>


@protocol R5StreamDelegate;


enum R5StreamMode{
    r5_stream_mode_idle,
    r5_stream_mode_streaming,
    r5_stream_mode_publishing
    
};

@interface R5Stream : NSObject{
    
    
}

@property BOOL network_ready;

@property R5Connection *connection;
@property NSObject<R5StreamDelegate> *delegate;
@property NSObject *client;

-(id)initWithConnection:(R5Connection *) conn;
-(void)play:(NSString *)streamName;
-(void)publish:(NSString *)streamName;

-(void) stop;

- (AVCaptureVideoPreviewLayer*) getPreviewLayer;
-(void) attachAudio:(R5Microphone *)microphone;
-(void) attachVideo:(R5VideoSource *)camera;
-(enum R5StreamMode) mode;
-(void)send:(NSString*)methodName withParam:(NSString*)param;
-(r5_stats*) getDebugStats;
-(R5VideoSource *) getVideoSource;
-(R5Microphone*) getMicrophone;


@end



@protocol R5StreamDelegate <NSObject>

-(void)onR5StreamStatus:(R5Stream *)stream withStatus:(int) statusCode withMessage:(NSString*)msg;

@end