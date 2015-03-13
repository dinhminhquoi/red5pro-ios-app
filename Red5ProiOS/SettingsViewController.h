//
//  SettingsViewController.h
//  Red5ProiOS
//
//  Created by Andy Zupko on 9/18/14.
//  Copyright (c) 2014 Infrared5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResolutionsPickerViewController.h"

enum StreamMode {
    r5_example_stream,
    r5_example_publish,
    r5_example_secondscreen
};

@protocol SettingsDelegate <NSObject>

-(void) closeSettings;

@end

@interface SettingsViewController : UIViewController<UITextFieldDelegate, ResolutionsPickerDelegate>
@property (weak, nonatomic) IBOutlet UIView *publishSettingsView;
@property (weak, nonatomic) IBOutlet UITextField *domain;
@property (weak, nonatomic) IBOutlet UITextField *port;
@property (weak, nonatomic) IBOutlet UITextField *app;
@property (weak, nonatomic) IBOutlet UITextField *stream;
@property (weak, nonatomic) IBOutlet UITextField *protocol;
@property (weak, nonatomic) IBOutlet UITextField *bitrate;

@property (weak, nonatomic) IBOutlet UIButton *audioCheck;
@property (weak, nonatomic) IBOutlet UIButton *videoCheck;
@property (weak, nonatomic) IBOutlet UIButton *resolutionSelect;

@property (weak, nonatomic) IBOutlet UIView *streamSettingsForm;
@property (weak, nonatomic) IBOutlet UIView *publishSettingsForm;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *resPickerHeight;

@property NSObject<SettingsDelegate> *delegate;

-(void)showSettingsForMode:(enum StreamMode) mode;

@end
