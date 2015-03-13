//
//  HelpDialogViewController.m
//  Red5ProiOS
//
//  Created by Todd Anderson on 11/6/14.
//  Copyright (c) 2014 Infrared5. All rights reserved.
//

#import "HelpDialogViewController.h"
#import <R5Streaming/R5Streaming.h>

@interface HelpDialogViewController ()
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@end

@implementation HelpDialogViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSString *bundleVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    NSString *formattedStr = [NSString stringWithFormat:@"v%@ - SDK %s", bundleVersion, R5PRO_VERSION ];
    
    [self.versionLabel setText:formattedStr];
    
    // Create URL from HTML file in application bundle
    NSURL *html = [[NSBundle mainBundle] URLForResource: @"help" withExtension:@"html"];
    
    // Create attributed string from HTML
    NSAttributedString *attrStr = [[NSAttributedString alloc]
                                   initWithFileURL:html
                                   options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
                                   documentAttributes:nil error:nil];
    
    // Create textview, add attributed str
    [self.textView setAttributedText:attrStr];
}

- (IBAction)dismiss:(id)sender {
    [UIView animateWithDuration:0.3f animations:^{
        self.view.alpha = 0.0f;
    } completion: ^(BOOL finished) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
}
- (IBAction)goToRed5ProServer:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://red5pro.com"]];
}
- (IBAction)goToGithub:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/infrared5/red5pro-example-apps"]];
}
- (IBAction)goToSite:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://red5pro.com/docs"]];
}

@end
