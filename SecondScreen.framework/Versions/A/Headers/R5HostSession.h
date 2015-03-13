//
//  R5HostSession.h
//  SecondScreenSdk
//
//  Copyright 2014 Infrared5. All rights reserved.
//

#import <Foundation/Foundation.h>

@class R5SecondScreenView;

/**
 *  A connection to a Host. This is valid for as long as the host is connected.
 */
@interface R5HostSession : NSObject

/**
 *  Binds the given `R5SecondScreenView` to this host session so that it can
 *  service the host.
 *
 *  The view will remain bound to the session until the host disconnects, or the
 *  view is reset or destroyed.
 *  @param view the view to bind
 *  @see R5SecondScreenView
 */
-(void) bindToView:(R5SecondScreenView*)view;

/**
 *  Sends an rpc call with no parameters to the host.
 *
 *  @param method the name of the rpc call to send
 */
-(void) sendRpc:(NSString*)method;

/**
 *  Sends an rpc call with the given parameters to the host
 *
 *  @param method     the name of the rpc call to send
 *  @param parameters an array of the parameters to send. The parameters must be
 *                    instances of `NSNumber` or `NSString`.
 */
-(void) sendRpc:(NSString*)method withParameters:(NSArray*)parameters;

/**
 *  The object that will handle rpc calls from the host.
 */
@property (nonatomic, weak) id rpcTarget;

/**
 *  The name of the host
 */
@property (nonatomic, readonly) NSString* name;

/**
 *  Whether the host is still connected
 *
 *  TODO: better name?
 */
@property (nonatomic, readonly) BOOL alive;

@end
