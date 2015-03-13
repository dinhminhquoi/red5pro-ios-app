//
//  R5Connection.h
//  Red5Pro
//
//  Created by Andy Zupko on 9/16/14.
//  Copyright (c) 2014 Andy Zupko. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "global.h"
#import "R5Configuration.h"



@interface R5Connection : NSObject
@property R5Configuration *config;

-(id)initWithConfig:(R5Configuration*) config;
-(void)call:(NSString*)method withParam:(NSString*)param;
-(client_ctx*)context ;


@end
