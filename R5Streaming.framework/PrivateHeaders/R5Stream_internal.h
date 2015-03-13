//
//  R5Stream_internal.h
//  red5streaming
//
//  Created by Andy Zupko on 2/4/15.
//  Copyright (c) 2015 Andy Zupko. All rights reserved.
//

@interface R5Stream(PrivateMethods){
    
    
}

-(void) update;
-(void)write_packet:(char*) packet length:(int) cBytes type:(int)packet_type;
-(void)surfaceChanged:(int)width height:(int)height;

@end
