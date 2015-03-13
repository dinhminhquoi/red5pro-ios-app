//
//  ResolutionsPickerViewController.h
//  Red5ProiOS
//
//  Created by Todd Anderson on 10/20/14.
//  Copyright (c) 2014 Infrared5. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ResolutionsPickerDelegate <NSObject>
-(void) closeResolutionsPicker;
@end

@interface ResolutionsPickerViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>

@property BOOL isOpen;
@property NSObject<ResolutionsPickerDelegate> *delegate;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;

- (void)showResolutionsWithSelection:(NSString *)resolution;
- (NSString *)getSelection;

@end
