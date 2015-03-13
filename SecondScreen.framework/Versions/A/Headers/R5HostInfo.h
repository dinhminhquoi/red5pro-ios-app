//
//  R5HostInfo.h
//  SecondScreenSdk
//
//  Copyright 2014 Infrared5. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Information about a Host that can be connected to
 */
@interface R5HostInfo : NSObject

/**
 *  The name of the host
 */
@property (nonatomic, readonly) NSString* name;

/**
 * The slot id for of the host
 *
 * The slot id is a non-negative integer from 0 to 64 that is assigned to the 
 * host to allow users to distinguish between multiple instances of the same 
 * host. The host and client both display something derived from the slot id,
 * such as the number itself, a color, or a symbol.
 */
@property (nonatomic, readonly) short slotId;

/**
 *  The number of players currently connected to the host
 */
@property (nonatomic, readonly) short currentPlayers;

/**
 *  The maximum number of players that can be connected to the host
 */
@property (nonatomic, readonly) short maxPlayers;

@end
