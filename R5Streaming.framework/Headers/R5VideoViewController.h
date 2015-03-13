//
//  R5VideoViewController.h
//  Red5Pro
//
//  Created by Andy Zupko on 9/17/14.
//  Copyright (c) 2014 Andy Zupko. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "R5Stream.h"

@interface R5VideoViewController : UIViewController<GLKViewDelegate>
	
@property (strong, nonatomic) EAGLContext *context;
@property double lastRenderTime;
@property double failCount;
@property int preferredFPS;

    -(void)attachStream:(R5Stream *)videoStream;
    -(void) resetContext;
-(void) showPreview:(BOOL)visible;
-(void)showDebugInfo:(BOOL)debug;

@end
