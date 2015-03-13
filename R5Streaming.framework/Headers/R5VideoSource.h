//
//  R5VideoSource.h
//  red5streaming
//
//  Created by Andy Zupko on 2/4/15.
//  Copyright (c) 2015 Andy Zupko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "AVEncoder.h"


typedef int (^source_handler_t)(NSArray* data, double pts);
typedef int (^source_param_handler_t)(NSData* params);

@interface R5VideoSource : NSObject
@property int width;
@property int height;
@property int bitrate;
@property int orientation;
@property AVEncoder *encoder;
@property AVCaptureVideoDataOutput *output;

-(void)startVideoCapture;
-(void)stopVideoCapture;
- (void) encodeWithBlock:(source_handler_t) block onParams: (source_param_handler_t) paramsHandler;
-(NSDictionary *) getSourceProperties;
-(void)configureSession:(AVCaptureSession*)session;
-(void)releaseSession:(AVCaptureSession*)session;
@end
