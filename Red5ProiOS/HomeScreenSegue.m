//
//  HomeScreenSegue.m
//  Red5ProiOS
//
//  Created by Todd Anderson on 10/16/14.
//  Copyright (c) 2014 Infrared5. All rights reserved.
//

#import "HomeScreenSegue.h"
#import "QuartzCore/QuartzCore.h"

@implementation HomeScreenSegue

-(void)perform {
    
    UIViewController *source = (UIViewController *)[self sourceViewController];
    UIViewController *destination = (UIViewController *)[self destinationViewController];
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    
    [source.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [source.navigationController pushViewController:destination animated:YES];
    
}

@end
