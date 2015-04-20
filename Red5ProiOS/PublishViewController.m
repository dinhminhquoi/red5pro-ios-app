
//
//  PublishViewController.m
//  Red5ProiOS
//
//  Created by Andy Zupko on 10/7/14.
//  Copyright (c) 2014 Infrared5. All rights reserved.
//

#import "PublishViewController.h"
#import "ALToastView.h"

@interface PublishViewController() {
    R5Stream *stream;
    BOOL isTogglable;
    BOOL isFrontSelected;
}
@end

@implementation PublishViewController

-(void)viewDidLoad {
    r5_set_log_level(r5_log_level_debug);
    [super viewDidLoad];
    isFrontSelected = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(stream == nil)
        [self establishPreview];
}

-(void)viewDidDisappear:(BOOL)animated {
    [self killStream];
    [self showPreview:false];
}

-(void)onR5StreamStatus:(R5Stream *)stream withStatus:(int)statusCode withMessage:(NSString *)msg {
    [ALToastView toastInView:self.view withText:[NSString stringWithFormat:@"Stream: %s - %@", r5_string_for_status(statusCode), msg]];
}

-(void)establishPreview {
    if(stream == nil) {
         stream = [self setUpNewStream];
    }

    [stream setDelegate:self];
    
    [self attachStream:stream];
    [self showPreview:true];
    isTogglable = YES;
}

-(AVCaptureDevice *)getSelectedDevice {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    return isFrontSelected ? [devices lastObject] : [devices firstObject];
}

-(R5Stream *)setUpNewStream {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *domain = (NSString*)[defaults objectForKey:@"domain"];
    NSString *app = (NSString*)[defaults objectForKey:@"app"];
    NSString *port = (NSString *)[defaults objectForKey:@"port"];
    BOOL includeAudio = [defaults boolForKey:@"includeAudio"];
    BOOL includeVideo = [defaults boolForKey:@"includeVideo"];
    
    R5Configuration * config = [R5Configuration new];
    
    config.host = domain;
    config.contextName = app;
    config.port = [port intValue];
    
    R5Connection *connection = [[R5Connection new] initWithConfig:config];
    R5Camera *camera = [[R5Camera alloc] initWithDevice:[self getSelectedDevice] andBitRate:128];
    camera.orientation = 90;
    
    AVCaptureDevice *audioDevice = [AVCaptureDevice defaultDeviceWithMediaType: AVMediaTypeAudio];
    R5Microphone *microphone = [[R5Microphone new] initWithDevice:audioDevice];
    
    R5Stream *r5Stream = [[R5Stream new] initWithConnection:connection];
    
    if(includeVideo)
        [r5Stream attachVideo:camera];
    if(includeAudio)
        [r5Stream attachAudio:microphone];
    
    return r5Stream;
}

-(void)killStream {
    @try {
        [stream stop];
        [stream setDelegate:nil];
        stream = nil;
       
    }
    @catch(NSException *exception) {
        NSLog(@"Could not stop: %@", exception);
    }
}

-(void)start {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *streamName = (NSString*)[defaults objectForKey:@"stream"];
    
    isTogglable = NO;
    [self showPreview:false];
    [stream publish:streamName type:R5RecordTypeLive];
}

-(void)stop {
    [self killStream];
   // [self establishPreview];
}

-(void)updatePreview {
    [self establishPreview];
}

-(void)toggleCamera {
    if(isTogglable) {
        isFrontSelected = !isFrontSelected;
        if(stream != nil){
            R5Camera *cam = [[R5Camera new] initWithDevice:[self getSelectedDevice] andBitRate:128];
            cam.orientation = 90;
            [stream attachVideo:cam];
        }
        //[self updatePreview];
    }
}

@end
