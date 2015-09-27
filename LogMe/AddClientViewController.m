//
//  AddClientViewController.m
//  LogMe
//
//  Created by Jack on 6/12/14.
//  Copyright (c) 2014 JackCable. All rights reserved.
//

#import "AddClientViewController.h"
#import "AddClientPageController.h"

@interface AddClientViewController ()
@property (strong, nonatomic) IBOutlet UITextField *clientNameField;
@property (strong, nonatomic) IBOutlet UITextField *hourlyRateField;
@end


@implementation AddClientViewController {
    AddClientPageController *controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    controller = [[AddClientPageController alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
    
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButton:(id)sender {
    [self.view endEditing:YES];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addButtonPressed:(UIBarButtonItem *)sender {
    [self.view endEditing:YES];
    NSString *clientName = _clientNameField.text;
    float hourlyRate = [_hourlyRateField.text floatValue];
    [controller addClient:clientName :hourlyRate];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
