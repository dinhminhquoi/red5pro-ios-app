//
//  R5Configuration.h
//  red5streaming
//
//  Created by Andy Zupko on 11/12/14.
//  Copyright (c) 2014 Andy Zupko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface R5Configuration : NSObject

@property int protocol;
@property NSString *host;
@property NSString *contextName;
@property NSString *streamName;
@property int port;
@property NSMutableArray *setup;
@property NSString *sdp_body;
//in seconds
@property float buffer_time;

@end
