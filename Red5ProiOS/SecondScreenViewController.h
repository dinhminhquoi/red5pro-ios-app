//
//  SecondScreenViewController.h
//  Red5ProiOS
//
//  Created by Todd Anderson on 10/7/14.
//  Copyright (c) 2014 Infrared5. All rights reserved.
//

#import <UIKit/UIKit.h>

@class R5SecondScreenView;

@interface SecondScreenViewController : UIViewController
@property (nonatomic, weak) IBOutlet UINavigationBar *navBar;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIView *hostView;
@property (nonatomic, weak) IBOutlet UIView *controlSchemeView;
@property (nonatomic, weak) IBOutlet R5SecondScreenView *r5SecondScreenView;
@property (nonatomic, weak)IBOutlet UIActivityIndicatorView *activityView;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *backButton;
@end
