//
//  PublishViewController.h
//  Red5ProiOS
//
//  Created by Andy Zupko on 10/7/14.
//  Copyright (c) 2014 Infrared5. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <R5Streaming/R5Streaming.h>

@interface PublishViewController : R5VideoViewController<R5StreamDelegate>
-(void)start;
-(void)stop;
-(void)toggleCamera;
@end
