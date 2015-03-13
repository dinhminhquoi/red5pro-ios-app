//
//  StreamViewController.h
//  Red5ProiOS
//
//  Created by Andy Zupko on 9/18/14.
//  Copyright (c) 2014 Infrared5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsViewController.h"



@interface StreamViewController : UIViewController<SettingsDelegate>
@property UIViewController *currentStreamView;
@property enum StreamMode currentMode;
@property (weak, nonatomic) IBOutlet UIView *viewHeaderBar;
@end
