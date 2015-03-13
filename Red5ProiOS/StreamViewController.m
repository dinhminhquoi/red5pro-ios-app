//
//  StreamViewController.m
//  Red5ProiOS
//
//  Created by Andy Zupko on 9/18/14.
//  Copyright (c) 2014 Infrared5. All rights reserved.
//

#import "StreamViewController.h"
#import "PublishViewController.h"
#import "VideoViewController.h"

@interface StreamViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *settingsHeight;
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;
@property (weak, nonatomic) IBOutlet UIButton *secondScreenButton;
@property (weak, nonatomic) IBOutlet UIButton *subscribeButton;
@property (weak, nonatomic) IBOutlet UIButton *publishButton;
@property (weak, nonatomic) IBOutlet UIButton *launchButton;
@property (weak, nonatomic) IBOutlet UIButton *camera;
@property SettingsViewController *settingsViewController;
@property (weak, nonatomic) IBOutlet UIButton *streamPlayButton;

@property NSMutableDictionary *viewControllerMap;

@end

@implementation StreamViewController

- (void)displayCameraButtons:(BOOL)ok {
    [[self launchButton] setHidden:!ok];
    [[self camera] setHidden:!ok];
}

-(BOOL) updateMode:(enum StreamMode) mode {
    if(self.currentMode == mode) {
        return NO;
    }
    self.currentMode = mode;
    [self launchCurrentView];
    return YES;
}

-(void) launchCurrentView{
    
    
    self.launchButton.hidden = YES;
    self.streamPlayButton.hidden = YES;
    
    switch(self.currentMode){
        case r5_example_publish:
            self.launchButton.hidden = NO;
            self.publishButton.selected = true;
            self.subscribeButton.selected = false;
            self.secondScreenButton.selected = false;
            [self loadStreamView:@"publishView"];
            break;
        case r5_example_stream:
            self.streamPlayButton.hidden = NO;
            self.publishButton.selected = false;
            self.subscribeButton.selected = true;
            self.secondScreenButton.selected = false;
            [self loadStreamView:@"subscribeView"];
            break;
        case r5_example_secondscreen:
            self.publishButton.selected = false;
            self.subscribeButton.selected = false;
            self.secondScreenButton.selected = true;
            [self loadViewFromStoryboard:@"secondScreenView"];
            break;
    }
    
   [self displayCameraButtons: self.currentMode == r5_example_publish];
}

- (IBAction)onSubscribePlay:(id)sender {
    self.streamPlayButton.selected = !self.streamPlayButton.selected;
   
    VideoViewController *subscriber = (VideoViewController *)[[self viewControllerMap] objectForKey:@"subscribeView"];
    
    if(self.streamPlayButton.selected){
        [subscriber start];
    }else{
        [subscriber stop];
    }
}

- (IBAction)onCameraTouch:(id)sender {
    
    PublishViewController *publisher = (PublishViewController *)[[self viewControllerMap] objectForKey:@"publishView"];
    
    self.launchButton.selected = !self.launchButton.selected;

    if(self.launchButton.selected){
        
        [publisher start];
        [[self camera] setHidden:YES];
        self.launchButton.enabled = false;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            self.launchButton.enabled = true;
        });
      
    }
    else {
        
        [publisher stop];
        if(self.currentMode != r5_example_stream)
            [[self camera] setHidden:NO];
    }
    
}
- (IBAction)onCameraSwitch:(id)sender {
    PublishViewController *publisher = (PublishViewController *)[[self viewControllerMap] objectForKey:@"publishView"];
    
    [publisher toggleCamera];
}

- (IBAction)onPublishTouch:(id)sender {
    if([self updateMode:r5_example_publish]) {
      [self showSettings];
    }
}

- (IBAction)onSubscribeTouch:(id)sender {
    if([self updateMode:r5_example_stream]) {
        [self showSettings];
    }
}

- (IBAction)onSecondScreenTouch:(id)sender {
    if([self updateMode:r5_example_secondscreen]) {
        [self showSettings];
    }
}

-(void)loadStreamView:(NSString *)viewID{

    if(self.currentStreamView){
        [self.currentStreamView removeFromParentViewController];
        [self.currentStreamView.view removeFromSuperview];

    }
    
    UIViewController *myController = (UIViewController *)[[self viewControllerMap] objectForKey:viewID];
    if(myController == nil) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        myController = [storyboard instantiateViewControllerWithIdentifier:viewID];
        [[self viewControllerMap] setObject:myController forKey:viewID];
    }
    
    self.currentStreamView = myController;
    
    CGRect frameSize = self.view.bounds;
    frameSize.size.height -= 72;
    
    myController.view.layer.frame = frameSize;
    myController.view.frame = frameSize;
    
    NSLog(@"Frame size: %f, %f, %f, %f", self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);

    [self.view addSubview:myController.view];
    [self.view sendSubviewToBack:myController.view];
}

-(void)loadViewFromStoryboard:(NSString *)viewID {
    
    if(self.currentStreamView){
        [self.currentStreamView removeFromParentViewController];
        [self.currentStreamView.view removeFromSuperview];
    }
    
    UIViewController *myController = [[self viewControllerMap] objectForKey:viewID];
    if(myController == nil) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        myController = [storyboard instantiateViewControllerWithIdentifier:viewID];
        [[self viewControllerMap] setObject:myController forKey:viewID];
    }
    
    self.currentStreamView = myController;
    
    CGRect frameSize = self.view.bounds;
    frameSize.size.height -= 72;
    
    myController.view.layer.frame = frameSize;
    myController.view.frame = frameSize;
    
    [self.view addSubview:myController.view];
    [self.view sendSubviewToBack:myController.view];
    [myController.view updateConstraintsIfNeeded];
    [myController.view layoutIfNeeded];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.viewControllerMap = [NSMutableDictionary dictionary];
    
    // Do any additional setup after loading the view.
    for(UIViewController *child in self.childViewControllers) {
        if([child isKindOfClass:[SettingsViewController class]]) {
            self.settingsViewController = (SettingsViewController*)child;
            self.settingsViewController.delegate = self;
        }
    }
    [self launchCurrentView];
}

//-(void) viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    CGRect frameSize = self.view.bounds;
//    [UIView beginAnimations:@"hideHeaderBar" context:nil];
//    [UIView setAnimationDuration:0.3f];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
//    [[self viewHeaderBar] setCenter:CGPointMake(frameSize.size.width * 0.5f, -37.5f)];
//    [UIView commitAnimations];
//}
//
-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self showSettings];
//    CGRect frameSize = self.view.bounds;
//    [UIView animateWithDuration:0.2f
//                          delay:0.0
//                        options:UIViewAnimationOptionCurveEaseOut
//                     animations:^{
//        
//        [self.view layoutIfNeeded];
//        [[self viewHeaderBar] setCenter:CGPointMake(frameSize.size.width * 0.5f, 37.5f)];
//        [self.view layoutIfNeeded];
//        
//    } completion:^(BOOL finished) {}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateControllersOnSettings:(BOOL)shown {
    PublishViewController *publisher = (PublishViewController *)[[self viewControllerMap] objectForKey:@"publishView"];
    
    VideoViewController *subscriber = (VideoViewController *)[[self viewControllerMap] objectForKey:@"subscribeView"];
    
    if(shown == YES) {
        [self displayCameraButtons:NO];
        [self.launchButton setSelected:NO];
        [publisher stop];
        [subscriber stop];
    }
    else {
        [self displayCameraButtons:self.currentMode == r5_example_publish];

    }
}

//SettingsDelegate
-(void) closeSettings{
    [UIView animateWithDuration:0.5 animations:^{
        
        [self.view layoutIfNeeded];
        self.settingsHeight.constant = 0;
        [self.settingsHeight.secondItem updateConstraintsIfNeeded];
        [self.settingsHeight.firstItem updateConstraintsIfNeeded];
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        [self.settingsButton setSelected:NO];
        [self updateControllersOnSettings:NO];
        [self launchCurrentView];
    }];
    
}

-(void) showSettings{
    
    [self.settingsButton setSelected:YES];
    [self.settingsViewController showSettingsForMode:self.currentMode];
    
    [self updateControllersOnSettings:YES];
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect frameSize = self.view.bounds;
        CGFloat h = frameSize.size.height - 10;
        [self.view layoutIfNeeded];
        self.settingsHeight.constant = h > 550 ? 550 : h;
        [self.settingsHeight.secondItem updateConstraintsIfNeeded];
        [self.settingsHeight.firstItem updateConstraintsIfNeeded];
        [self.view layoutIfNeeded];
        
    }];
}

- (IBAction)onShowSettings:(id)sender {
    [self showSettings];
}

@end
