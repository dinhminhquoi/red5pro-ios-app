//
//  SecondScreenHostViewController.m
//  Red5ProiOS
//
//  Created by Todd Anderson on 10/8/14.
//  Copyright (c) 2014 Infrared5. All rights reserved.
//

#import <SecondScreen/SecondScreen.h>
#import "SecondScreenHostViewController.h"

@interface SecondScreenHostViewController () <R5SecondScreenDelegate>
@end

@implementation SecondScreenHostViewController

- (id)initWithScreenView:(R5SecondScreenView *)view {
    if(self = [super init]) {
        _secondScreenView = view;
    }
    return self;
}

- (void)updateSession:(R5HostSession *)sess {
    _session = sess;
    _session.rpcTarget = self;
    [[R5SecondScreenClient sharedClient] addDelegate:self];
    [_session bindToView: _secondScreenView];
}

- (void)clearSession {
    [[R5SecondScreenClient sharedClient] disconnectFromHost];
    [[R5SecondScreenClient sharedClient] removeDelegate:self];
    _session = nil;
}

#pragma mark - R5SecondScreenDelegate Methods
-(void) hostDidDisconnect {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
