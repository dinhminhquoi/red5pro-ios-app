//
//  SecondScreenHostViewController.h
//  Red5ProiOS
//
//  Created by Todd Anderson on 10/8/14.
//  Copyright (c) 2014 Infrared5. All rights reserved.
//

#import <UIKit/UIKit.h>

@class R5SecondScreenView;
@class R5HostSession;

@interface SecondScreenHostViewController : UIViewController

@property (nonatomic, strong) R5SecondScreenView *secondScreenView;
@property (nonatomic, strong) R5HostSession* session;

-(id) initWithScreenView:(R5SecondScreenView *)view;
-(void) updateSession:(R5HostSession *)session;
-(void) clearSession;

@end
