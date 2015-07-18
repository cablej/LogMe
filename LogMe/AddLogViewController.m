//
//  AddLogViewController.m
//  LogMe
//
//  Created by Jack on 6/11/14.
//  Copyright (c) 2014 JackCable. All rights reserved.
//

#import "AddLogViewController.h"
#import "AddLogController.h"

@implementation AddLogViewController {
    AddLogController *controller;
    IBOutlet UIDatePicker *datePicker;
    IBOutlet UIBarButtonItem *progressButton;
    IBOutlet UILabel *dateLabel;
}

- (IBAction)datePickerValueChanged:(UIDatePicker *)sender {
    if([datePicker.date timeIntervalSinceDate:controller.addedLog.startTime] > 0 || !controller.hasEnteredStartTime) {
        
        progressButton.enabled = YES;
    } else {
        progressButton.enabled = NO;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    controller = [[AddLogController alloc] init];
    
}
- (IBAction)progressButton:(UIBarButtonItem *)sender {
    if(!controller.hasEnteredStartTime) {
        [controller enteredStartTime:datePicker.date];
        [progressButton setTitle:@"Add"];
        dateLabel.text = @"End Time";
        progressButton.enabled = NO;
    } else {
        [controller enteredEndTime:datePicker.date];
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancelButton:(UIBarButtonItem *)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
