//
//  SecondScreenHostListTableViewController.m
//  Red5ProiOS
//
//  Created by Todd Anderson on 10/8/14.
//  Copyright (c) 2014 Infrared5. All rights reserved.
//

#import "SecondScreenHostListTableViewController.h"
#import <SecondScreen/SecondScreen.h>
#import "Reachability.h"

@interface SecondScreenHostListTableViewController () <UITableViewDataSource, UITableViewDelegate, R5SecondScreenDelegate> {
    UITableView *tableView;
    UIView *hostView;
    UIImageView *wifiCheck;
    UIImageView *registryCheck;
    R5SecondScreenClient *client;
    Reachability* reachability;
}
@end

@implementation SecondScreenHostListTableViewController

-(id) initWithTableView:(UITableView*) tv andHostView:(UIView *) hv {
    if(self = [super init]) {
        tableView = tv;
        tableView.delegate = self;
        tableView.dataSource = self;
        
        hostView = hv;
        wifiCheck = (UIImageView *)[hostView viewWithTag:100];
        registryCheck = (UIImageView *)[hostView viewWithTag:101];
        reachability = [Reachability reachabilityForLocalWiFi];
        
        client = [R5SecondScreenClient sharedClient];
        [client addDelegate:self];
        [self hostListDidChange:client.availableHosts];
    }
    
    return self;
}

-(void)enable {
    [wifiCheck setHighlighted:NO];
    [registryCheck setHighlighted:NO];
    
    [self updateRegistryStatus];
    
    // register for reachability changes, and start the notifier.
    // this is only used to display the wifi connection status for diagnostic
    // purposes
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleReachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    [reachability startNotifier];
}

-(void) disable {
    [reachability stopNotifier];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) updateRegistryStatus {
    BOOL noHosts = [client availableHostCount] == 0;
    [hostView setHidden:!noHosts];
    
    if(noHosts) {
        BOOL isReachable = [reachability isReachableViaWiFi];
        [wifiCheck setHighlighted: isReachable];
        [registryCheck setHighlighted: [client isConnectedToRegistry]];
    }
}

-(void) handleReachabilityChanged:(id)sender {
    [self updateRegistryStatus];
}

-(void) dealloc {
    [client removeDelegate:self];
    [tableView setDelegate:nil];
    [tableView setDataSource:nil];
}

-(void) hostListDidChange:(NSArray *)hosts {
    [tableView reloadData];
    [self updateRegistryStatus];
    tableView.hidden = [client availableHostCount] == 0;
}

-(void) updateView:(UITableViewCell*)view forHost:(R5HostInfo*)host {
    view.hidden = host == nil;
    if(host) {
        UILabel* nameLabel = [view textLabel];
        if([client isPendingHost:host]) {
            nameLabel.text = @"Connection requested...";
        }
        else {
            nameLabel.text = host.name;
        }
        
        UILabel* slotsLabel = view.detailTextLabel;
        slotsLabel.text = [NSString stringWithFormat:@"[%d] %d/%d",
                           host.slotId,
                           host.currentPlayers,
                           host.maxPlayers];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"HostCell";
    
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:MyIdentifier];
    }
    
    NSArray* hosts = [client availableHosts];
    [self updateView:cell forHost: [hosts objectAtIndex:indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [client availableHostCount];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    R5HostInfo* host = [[client availableHosts] objectAtIndex:indexPath.row];
    [client requestConnectionFrom:host];
    return nil;
}


@end
