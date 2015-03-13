//
//  VideoViewController.h
//  Red5ProiOS
//
//  Created by Andy Zupko on 9/18/14.
//  Copyright (c) 2014 Infrared5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <R5Streaming/R5Streaming.h>

@interface VideoViewController : R5VideoViewController
-(void)start;
-(void)stop;
@end
