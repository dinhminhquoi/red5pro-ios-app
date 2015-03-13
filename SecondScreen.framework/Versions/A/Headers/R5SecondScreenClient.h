//
//  R5SecondScreenClient.h
//  SecondScreenSdk
//
//  Copyright 2014 Infrared5. All rights reserved.
//

#import <Foundation/Foundation.h>

@class R5HostSession;
@class R5HostInfo;
@protocol R5SecondScreenDelegate;

/** Error type */
typedef NS_ENUM(NSInteger, R5HostConnectError)
{
    /** The host failed to open a socket connection to the client */
	R5HostConnectNetworkError = 1,
    /** The protocol version used by the host is too old to be used with the client */
	R5HostConnectHostTooOld,
    /** The protocol version used by the client is too old to be used by the client */
	R5HostConnectClientTooOld,
};

/** The error domain used when a host fails to connect */
extern NSString* const R5HostConnectErrorDomain;

/** Log level */
typedef NS_ENUM(NSInteger, R5LogLevel) {
    /** Logs only errors */
    kR5LogError,
    /** Logs warnings and above */
    kR5LogWarn,
    /** Logs info and above */
    kR5LogInfo,
    /** Logs debug and above */
    kR5LogDebug,
    /** Logs everything */
    kR5LogVerbose
};

/**
 * A class representing the Red5Pro Secondscreen Client. It maintains the
 * connection to the registry server and to any connected hosts.
 */
@interface R5SecondScreenClient : NSObject

/** @name Getting an instance */

/**
 *  Returns the shared instance of the SecondScreen Client
 *
 *  @return A singleton instance of SecondScreen Client
 */
+ (R5SecondScreenClient *)sharedClient;

/** @name Configuration and Setup */

/**
 *  Sets the hostname and port of the registry server to connect to. This must
 *  be called before calling calling `start`.
 *
 *  @param hostname the hostname of the registry server
 *  @param port     the port to connect to the server on
 */
-(void) setRegistryHostname:(NSString*)hostname port:(int)port;

/**
 *  Sets the name of the client as visible to connected hosts.
 *
 *  If it is not set, the name defaults to "Client".
 *
 *  @param clientName the client name to use
 */
-(void) setClientName:(NSString*)clientName;

/**
 *  Sets the log level used by the library.
 *
 *  Defaults to `kR5LogWarn`.
 *
 *  @param logLevel the logging level to use
 *  @see R5LogLevel
 */
-(void) setLogLevel:(R5LogLevel)logLevel;

/** @name Starting and Stopping */

/**
 *  Starts the secondscreen client.
 *
 *  Until `stop` is called, it will try to maintain its connection to the
 *  registry server and any connected hosts.
 */
-(void) start;

/**
 *  Stops the secondscreen client
 */
-(void) stop;

/** @name Common Operations */

/**
 *  Requests a connection from the given host.
 *
 *  @param host the host to connect to
 */
-(void) requestConnectionFrom:(R5HostInfo*)host;

/**
 *  Disconnects from the currently connected host, if any.
 */
-(void) disconnectFromHost;

/** @name Registering Delegates */

/**
 *  Registers a `R5SecondScreenDelegate` with the client.
 *  
 *  The delegate will be called with for any of the optional 
 *  `R5SecondScreenDelegate` methods that it responds to. The client will hold a
 *  weak reference to the delegate. Multiple delegates can be registered at the
 *  same time.
 *
 *  @param delegate the delegate to add
 *  @see R5SecondScreenDelegate
 */
-(void) addDelegate:(id<R5SecondScreenDelegate>)delegate;

/**
 *  Removes the currently registered `R5SecondScreenDelegate`
 *
 *  @param delegate the delegate to remove
 */
-(void) removeDelegate:(id<R5SecondScreenDelegate>)delegate;

/** @name Properties */

/**
 *  Checks if a connection is pending to the given host
 *
 *  @param host the host to check
 *
 *  @return YES if a connection is pending to `host`
 */
-(BOOL) isPendingHost:(R5HostInfo*)host;

/**
 * A list of the hosts that can be connected to.
 * 
 * This list is retrieved and updated from the registry server. If not connected
 * to the registry server, this list will be empty.
 */
@property (nonatomic, readonly) NSArray* availableHosts;

/**
 *  The number of hosts that can be connected to
 */
@property (nonatomic, readonly) int availableHostCount;

/**
 *  Whether the client is connected to the registry server
 */
@property (nonatomic, readonly) BOOL isConnectedToRegistry;

/**
 *  The `R5HostSession` representing the session with the currently connected
 *  host, if any.
 *  @see R5HostSession
 */
@property R5HostSession* session;

@end
