//
//  HelpDialogSegue.m
//  Red5ProiOS
//
//  Created by Todd Anderson on 11/6/14.
//  Copyright (c) 2014 Infrared5. All rights reserved.
//

#import "HelpDialogSegue.h"

@implementation HelpDialogSegue

-(void)perform {
    
    UIViewController *dst = [self destinationViewController];
    UIViewController *src = [self sourceViewController];
    
    // add the view to the hierarchy and bring to front
    [src addChildViewController:dst];
    [src.view addSubview:dst.view];
    [src.view bringSubviewToFront:dst.view];
    
    // set the view frame
    CGRect frame;
    frame.size.height = src.view.frame.size.height;
    frame.size.width = src.view.frame.size.width;
    frame.origin.x = src.view.bounds.origin.x;
    frame.origin.y = src.view.bounds.origin.y;
    dst.view.frame = frame;
    
    [UIView animateWithDuration:0.3f animations:^{
        dst.view.alpha = 1.0f;
    }];
}

@end
