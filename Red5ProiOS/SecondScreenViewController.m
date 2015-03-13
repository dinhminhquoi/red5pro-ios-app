//
//  SecondScreenViewController.m
//  Red5ProiOS
//
//  Created by Todd Anderson on 10/7/14.
//  Copyright (c) 2014 Infrared5. All rights reserved.
//

#import <SecondScreen/SecondScreen.h>
#import "SecondScreenViewController.h"
#import "SecondScreenHostViewController.h"
#import "SecondScreenHostListTableViewController.h"

@interface SecondScreenViewController () <R5SecondScreenDelegate> {
    R5SecondScreenClient *client;
    SecondScreenHostViewController *hostViewController;
    SecondScreenHostListTableViewController *hostListController;
}
@end

@implementation SecondScreenViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [_controlSchemeView setHidden:YES];
    
    _backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(backButtonClicked:)];
    hostViewController = [[SecondScreenHostViewController alloc] initWithScreenView: _r5SecondScreenView];
    hostListController = [[SecondScreenHostListTableViewController alloc] initWithTableView:_tableView andHostView:_hostView];
}

- (void)viewDidAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDefaultsChange:) name:@"userDefaultsChange" object:nil];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *domain = (NSString*)[defaults objectForKey:@"domain"];
    NSString *port = (NSString*)[defaults objectForKey:@"secondscreen_port"];
    [self register:domain onPort:[port intValue]];
    [hostListController enable];
}

-(void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [hostViewController clearSession];
    [[R5SecondScreenClient sharedClient] removeDelegate:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [hostListController disable];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [[self activityView] setHidden:YES];
    [[self activityView] stopAnimating];
    if(client != nil && [client isConnectedToRegistry]) {
        [client stop];
    }
}

-(void) userDefaultsChange:(NSNotification *) notification {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *domain = (NSString *)[defaults objectForKey:@"domain"];
    NSString *port = (NSString*)[defaults objectForKey:@"secondscreen_port"];
    [self register:domain onPort:[port intValue]];
}

-(void) register:(NSString *)registryAddress onPort:(int)port {
    [[self activityView] setHidden:NO];
    [[self activityView] startAnimating];
    if(client != nil && [client isConnectedToRegistry]) {
        [client removeDelegate:self];
        [client stop];
    }
    NSLog(@"registryAddress: %@", registryAddress);
    client = [R5SecondScreenClient sharedClient];
    [client setRegistryHostname:registryAddress port:port];
    [client setClientName:[[UIDevice currentDevice] name]];
    [client setLogLevel:kR5LogInfo];
    [client addDelegate:self];
    [client start];
}

-(void) hostListDidChange:(NSArray*)hosts {
    NSLog(@"hosts: %@", hosts);
    NSLog(@"connected: %@", [client isConnectedToRegistry] ? @"YES" : @"NO");
    if([client isConnectedToRegistry]) {
        [[self activityView] setHidden:YES];
        [[self activityView] stopAnimating];
    }
}

-(void) hostDidConnect:(R5HostSession*)host {
    [[_navBar topItem] setTitle:host.name];
    [[_navBar topItem] setLeftBarButtonItem:_backButton];
    [hostViewController updateSession:host];
    [_controlSchemeView setHidden:NO];
    [_tableView setHidden:YES];
}

-(void) hostDidDisconnect {
    [[_navBar topItem] setTitle:@"SecondScreen"];
    [[_navBar topItem] setLeftBarButtonItem:nil];
    _navBar.topItem.leftBarButtonItem = nil;
    [_controlSchemeView setHidden:YES];
    [_tableView setHidden:NO];
    
    [self hostListDidChange:[client availableHosts]];
}

- (void)backButtonClicked:(id)sender {
    [hostViewController clearSession];
}

@end
