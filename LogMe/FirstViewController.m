//
//  FirstViewController.m
//  LogMe
//
//  Created by Jack on 6/11/14.
//  Copyright (c) 2014 JackCable. All rights reserved.
//

#import "FirstViewController.h"
#import "LoggingController.h"

@interface FirstViewController ()

@property(strong, nonatomic) LoggingController *loggingController;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *moneyEarned;
@property (strong, nonatomic) IBOutlet UIButton *loggingButton;
@property (strong, nonatomic) IBOutlet UILabel *clientLabel;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _loggingController = [[LoggingController alloc] init];
    _loggingButton.layer.cornerRadius = 5;
    
}

-(void) viewDidAppear:(BOOL)animated {
    [_loggingController loadClients];
    if(![_loggingController currentClientIsBeyondBounds]) _clientLabel.text = [NSString stringWithFormat: @"Current client : %@", [_loggingController currentClientName]];
    
    ADBannerView *adView = [[ADBannerView alloc] initWithFrame:CGRectMake(0, 65, 320, 50)];
    adView.delegate = self;
    [self.view addSubview:adView];
}

- (IBAction)loggingButtonPressed:(UIButton *)sender {
    if(_loggingController.isLogging) {
        [self stopLogging];
        [_loggingButton setTitle:@"Start Logging" forState:UIControlStateNormal];
    } else {
        [self startLogging];
        [_loggingButton setTitle:@"Stop Logging" forState:UIControlStateNormal];
    }
}

-(void) startLogging {
    [_loggingController startLogging];
    [self updateTimeInterval];
}

-(void) stopLogging {
    
    [_loggingController endLogging];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) updateTimeInterval {
    if(![_loggingController isLogging]) return;
    
    _timeLabel.text = [_loggingController getFormattedTimeElapsed];
    _moneyEarned.text = [_loggingController getFormattedDollarsEarned];
    
    [self performSelector:@selector(updateTimeInterval) withObject:nil afterDelay:1];
}


- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"Failed to retrieve ad");
}

@end
