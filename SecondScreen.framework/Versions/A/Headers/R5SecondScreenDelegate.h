//
//  R5SecondScreenDelegate.h
//  SecondScreenSdk
//
//  Copyright 2014 Infrared5. All rights reserved.
//

#import <Foundation/Foundation.h>

@class R5HostSession;

/**
 *  The delegate for `R5SecondScreenClient`
 */
@protocol R5SecondScreenDelegate <NSObject>

/** @name Optional Methods */
@optional

/**
 *  Tells the delegate that the list of available hosts has changed
 *
 *  @param hosts the list of available `R5HostInfo`
 */
-(void) hostListDidChange:(NSArray*)hosts;

/**
 *  Tells the delegate that a host did connect to the client
 *
 *  @param host the session for the host that connected
 */
-(void) hostDidConnect:(R5HostSession*)host;

/**
 *  Tells the delegate that the currently connected host did disconnect
 */
-(void) hostDidDisconnect;

/**
 *  Tells the delegate that a host failed to connect with the given error
 *
 *  @param error the error
 *  @see R5HostConnectError
 */
-(void) hostFailedToConnectWithError:(NSError*)error;

/**
 *  Tells the delegate that a host did not establish a connection to the client
 *  in a certain amount of time.
 *
 *  This does not mean that the host will not eventually connect, but it is
 *  unlikely.
 */
-(void) hostConnectTimedOut;

@end
