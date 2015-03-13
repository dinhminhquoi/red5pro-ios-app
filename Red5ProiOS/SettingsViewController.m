//
//  SettingsViewController.m
//  Red5ProiOS
//
//  Created by Andy Zupko on 9/18/14.
//  Copyright (c) 2014 Infrared5. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property enum StreamMode currentMode;
@property UITextField *focusedField;
@property ResolutionsPickerViewController *resolutionsPickerController;
@end

@implementation SettingsViewController

- (NSString*) getUserSetting:(NSString *)key withDefault:(NSString *)defaultValue {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:key]) {
        return [defaults stringForKey:key];
    }
    return defaultValue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.hidden = YES;

    self.domain.delegate = self;
    self.port.delegate = self;
    self.app.delegate = self;
    self.stream.delegate = self;
    self.protocol.delegate = self;
    self.bitrate.delegate = self;

    for(UIViewController *child in self.childViewControllers) {
        if([child isKindOfClass:[ResolutionsPickerViewController class]]) {
            self.resolutionsPickerController = (ResolutionsPickerViewController*)child;
            [self.resolutionsPickerController setDelegate:self];
        }
    }

}

- (void)setResolutionSelectText:(NSString *)label {
    [self.resolutionSelect setTitle:label forState:UIControlStateNormal];
    [self.resolutionSelect setTitle:label forState:UIControlStateHighlighted];
    [self.resolutionSelect setTitle:label forState:UIControlStateDisabled];
    [self.resolutionSelect setTitle:label forState:UIControlStateSelected];
}

-(void)showSettingsForMode:(enum StreamMode) mode{
    
    self.currentMode = mode;
    self.resPickerHeight.constant = 0;
    [self.resPickerHeight.secondItem updateConstraintsIfNeeded];
    [self.resPickerHeight.firstItem updateConstraintsIfNeeded];
    
    self.view.hidden = NO;
    
    int resWidth = [[self getUserSetting:@"resolutionWidth" withDefault:@"320"] intValue];
    int resHeight = [[self getUserSetting:@"resolutionHeight" withDefault:@"240"] intValue];
    NSString *resolution = [NSString stringWithFormat:@"%ldx%ld", (long)resWidth, (long)resHeight];
    
    self.domain.text = [self getUserSetting:@"domain" withDefault:@"0.0.0.0"];
    self.port.text = [self getUserSetting:@"port" withDefault:self.port.text];
    self.app.text = [self getUserSetting:@"app" withDefault:self.app.text];
    self.stream.text = [self getUserSetting:@"stream" withDefault:self.stream.text];
    self.protocol.text = [self getUserSetting:@"protocol" withDefault:self.protocol.text];
    self.bitrate.text = [self getUserSetting:@"bitrate" withDefault:@"128"];
    self.audioCheck.selected = [[self getUserSetting:@"includeAudio" withDefault:@"1"] boolValue];
    self.videoCheck.selected = [[self getUserSetting:@"includeVideo" withDefault:@"1"] boolValue];
    [self setResolutionSelectText:resolution];
    
    switch(self.currentMode) {
        case r5_example_publish:
            [self.streamSettingsForm setHidden:NO];
            [self.publishSettingsForm setHidden:NO];
            self.port.text = [self getUserSetting:@"port" withDefault:@"8554"];
            break;
        case r5_example_stream:
            [self.streamSettingsForm setHidden:NO];
            [self.publishSettingsForm setHidden:YES];
            self.port.text = [self getUserSetting:@"port" withDefault:@"8554"];
            break;
        case r5_example_secondscreen:
            [self.streamSettingsForm setHidden:YES];
            [self.publishSettingsForm setHidden:YES];
            self.port.text = [self getUserSetting:@"secondscreen_port" withDefault:@"8088"];
            break;
    }

}

- (IBAction)onDoneClicked:(id)sender {

    NSArray *dims = [self.resolutionSelect.titleLabel.text componentsSeparatedByString:@"x"];
    int resolutionWidth = [(NSString *)[dims objectAtIndex:0] intValue];
    int resolutionHeight = [(NSString *)[dims objectAtIndex:1] intValue];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.domain.text forKey:@"domain"];
    [defaults setObject:self.app.text forKey:@"app"];
    [defaults setObject:self.stream.text forKey:@"stream"];
    [defaults setObject:self.protocol.text forKey:@"protocol"];
    [defaults setObject:self.bitrate.text forKey:@"bitrate"];
    
    [defaults setBool:self.audioCheck.selected forKey:@"includeAudio"];
    [defaults setBool:self.videoCheck.selected forKey:@"includeVideo"];
    [defaults setInteger:resolutionWidth forKey:@"resolutionWidth"];
    [defaults setInteger:resolutionHeight forKey:@"resolutionHeight"];
    
    switch (self.currentMode) {
        case r5_example_publish:
        case r5_example_stream:
            [defaults setObject:self.port.text forKey:@"port"];
            break;
        case r5_example_secondscreen:
            [defaults setObject:self.port.text forKey:@"secondscreen_port"];
            break;
    }
    
    [defaults synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"userDefaultsChange" object:nil];
    
    if(self.delegate)
        [self.delegate closeSettings];
}

- (IBAction)openResolutionsPicker:(id)sender {
    if(!self.resolutionsPickerController.isOpen) {
        [self.resolutionsPickerController showResolutionsWithSelection:self.resolutionSelect.titleLabel.text];
        
        [UIView animateWithDuration:0.5 animations:^{
        
            [self.view layoutIfNeeded];
            self.resPickerHeight.constant = 214;
            [self.resPickerHeight.secondItem updateConstraintsIfNeeded];
            [self.resPickerHeight.firstItem updateConstraintsIfNeeded];
            //self.view.frame = CGRectOffset(self.view.frame, 0, -78);
            [self.view layoutIfNeeded];
        
        } completion:^(BOOL finished) {
            [self.resolutionsPickerController setIsOpen:YES];
        }];
    }
    if(self.focusedField != nil) {
        [self textFieldShouldReturn:self.focusedField];
    }
}

- (void)closeResolutionsPicker {
    if(self.resolutionsPickerController.isOpen) {
        [self.resolutionsPickerController setIsOpen:NO];
        [self setResolutionSelectText:[self.resolutionsPickerController getSelection]];
        
        [UIView animateWithDuration:0.5 animations:^{
        
            [self.view layoutIfNeeded];
            self.resPickerHeight.constant = 0;
            [self.resPickerHeight.secondItem updateConstraintsIfNeeded];
            [self.resPickerHeight.firstItem updateConstraintsIfNeeded];
            //self.view.frame = CGRectOffset(self.view.frame, 0, 78);
            [self.view layoutIfNeeded];
            
        } completion:^(BOOL finished) {
        }];
    }
}

- (BOOL)isHiddenKeyboardField:(UITextField *)field {
    return field == self.bitrate ||
            
            field == self.stream ||
            field == self.protocol;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    self.focusedField = nil;
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if([self isHiddenKeyboardField:textField]) {
        [self animateTextField: textField up: YES];
    }
    [self closeResolutionsPicker];
    self.focusedField = textField;
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    if([self isHiddenKeyboardField:textField]) {
        [self animateTextField: textField up: NO];
    }
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up {
    const int movementDistance = 90;
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView animateWithDuration:0.3f animations:^{
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    }];
}

- (IBAction)onAudioClick:(id)sender {
    [[self audioCheck] setSelected:!self.audioCheck.selected];
}

- (IBAction)onVideoClick:(id)sender {
    [[self videoCheck] setSelected:!self.videoCheck.selected];
}
@end
