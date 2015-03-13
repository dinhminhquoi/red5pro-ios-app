//
//  R5SecondScreenView.h
//  SecondScreenSdk
//
//  Copyright (c) 2014 Infrared5. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  A delegate for the progress of loading the controls of an `R5SecondScreenView`
 *
 *  In practice, it will usually be a `UIProgressView`
 */
@protocol R5ProgressDelegate

/**
 *  Adjusts the current progress shown by the receiver, optionally animating the
 *  change.
 *
 *  @param progress The new progress value.
 *  @param animated `YES` if the change should be animated, `NO` if the change
 *                  should happen immediately.
 */
-(void) setProgress:(float)progress animated:(BOOL)animated;
@end

/**
 *  A catogory implementing the `R5ProgressDelegate` protocol for
 *  `UIProgressView`
 */
@interface UIProgressView (R5ProgressDelegate) <R5ProgressDelegate>
@end

/**
 *  A View that can display controls from the host
 */
@interface R5SecondScreenView : UIView

/**
 *  The delegate for the progress of loading the controls
 */
@property (nonatomic, strong) IBOutlet id<R5ProgressDelegate> progressDelegate;

@end
