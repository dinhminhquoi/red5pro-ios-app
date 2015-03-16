//
//  HomeViewController.m
//  Red5ProiOS
//
//  Created by Andy Zupko on 10/9/14.
//  Copyright (c) 2014 Infrared5. All rights reserved.
//

#import "HomeViewController.h"
#import "StreamViewController.h"

@interface HomeViewController()
@property enum StreamMode selectedMode;
@end

@implementation HomeViewController
- (IBAction)onPublishTouch:(id)sender {
    self.selectedMode = r5_example_publish;
}

- (IBAction)onSubscribeTouch:(id)sender {
    self.selectedMode = r5_example_stream;
}

- (IBAction)onSecondTouch:(id)sender {
    self.selectedMode = r5_example_secondscreen;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    StreamViewController *streamController = (StreamViewController *)segue.destinationViewController;
    if(streamController != nil && [streamController respondsToSelector:@selector(setCurrentMode:)]) {
        streamController.currentMode = self.selectedMode;
    }
}

@end
