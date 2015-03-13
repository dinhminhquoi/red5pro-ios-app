//
//  VideoViewController.m
//  Red5ProiOS
//
//  Created by Andy Zupko on 9/18/14.
//  Copyright (c) 2014 Infrared5. All rights reserved.
//

#import "VideoViewController.h"
#import <R5Streaming/R5Streaming.h>

@interface VideoViewController() {
    R5Stream *stream;
   
}
@end


@implementation VideoViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}


-(R5Stream *)setUpNewStream {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *domain = (NSString*)[defaults objectForKey:@"domain"];
    NSString *app = (NSString*)[defaults objectForKey:@"app"];
    NSString *port = (NSString *)[defaults objectForKey:@"port"];
    
    R5Configuration * config = [R5Configuration new];
    
    config.host = domain;
    config.contextName = app;
    config.port = [port intValue];
    
    R5Connection *connection = [[R5Connection new] initWithConfig:config];
    R5Stream *r5Stream = [[R5Stream new] initWithConnection:connection];
    return r5Stream;
}

-(void)start {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *streamName = (NSString*)[defaults objectForKey:@"stream"];
    stream = [self setUpNewStream];
    [self attachStream:stream];
    [stream play:streamName];
}

-(void)stop {
    @try {
        [stream stop];
    }
    @catch(NSException *exception) {
        NSLog(@"Could not stop subscription: %@", exception);
    }
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self stop];
}

@end
