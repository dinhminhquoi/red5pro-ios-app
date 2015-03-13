//
//  ResolutionsPickerViewController.m
//  Red5ProiOS
//
//  Created by Todd Anderson on 10/20/14.
//  Copyright (c) 2014 Infrared5. All rights reserved.
//

#import "ResolutionsPickerViewController.h"

@interface ResolutionsPickerViewController ()
@property NSMutableArray *resolutions;
@end

@implementation ResolutionsPickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.resolutions = [[NSMutableArray alloc] initWithObjects:@"320x240", @"640x480", @"1280x960", nil];
}

- (void)showResolutionsWithSelection:(NSString *)resolution {
    NSInteger row = [self.resolutions indexOfObject:resolution];
    if(row == NSNotFound) {
        row = 0;
    }
    [self.picker selectRow:row inComponent:0 animated:YES];
}

- (NSString *)getSelection {
    NSInteger row = [self.picker selectedRowInComponent:0];
    NSString *res = [self.resolutions objectAtIndex:row];
    return res;
}

- (IBAction)onDone:(id)sender {
    if(self.delegate != nil) {
        [self.delegate closeResolutionsPicker];
    }
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.resolutions.count;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setTextColor:[UIColor redColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    
    // Fill the label text here
    [pickerLabel setText:[self.resolutions objectAtIndex:row]];
    return pickerLabel;
}

@end
