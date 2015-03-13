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

//-(void) viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    CGRect frameSize = self.view.bounds;
//    [UIView beginAnimations:@"hideHeaderBar" context:nil];
//    [UIView setAnimationDuration:0.3f];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
//    [[self headerBar] setCenter:CGPointMake(frameSize.size.width * 0.5f, -37.5f)];
//    [UIView commitAnimations];
//}
//
//-(void) viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    CGRect frameSize = self.view.bounds;
//    [UIView animateWithDuration:0.2f
//                          delay:0.0
//                        options:UIViewAnimationOptionCurveEaseOut
//                     animations:^{
//                         
//                         [self.view layoutIfNeeded];
//                         [[self headerBar] setCenter:CGPointMake(frameSize.size.width * 0.5f, 37.5f)];
//                         [self.view layoutIfNeeded];
//                         
//                     } completion:^(BOOL finished) {}];
//}

@end
