//
//  MapSearchViewController.m
//  LogMe
//
//  Created by Jack on 6/11/14.
//  Copyright (c) 2014 JackCable. All rights reserved.
//

#import "MapSearchViewController.h"

@implementation MapSearchViewController {
    CLLocationCoordinate2D lastSelectedCoord;
    IBOutlet UIBarButtonItem *saveButton;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _mapView.showsUserLocation = YES;
    _mapView.delegate = self;    _searchText.delegate = self;
    saveButton.enabled = NO;
}
- (IBAction)cancelButton:(UIBarButtonItem *)sender {
    [self.view endEditing:YES];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)saveButton:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:lastSelectedCoord.longitude] forKey:@"selectedLongitude"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:lastSelectedCoord.latitude] forKey:@"selectedLatitude"];
    [self.view endEditing:YES];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (IBAction)textFieldReturn:(id)sender {
    [sender resignFirstResponder];
    [_mapView removeAnnotations:[_mapView annotations]];
    [self performSearch];
}

- (void) performSearch {
    MKLocalSearchRequest *request =
    [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = _searchText.text;
    request.region = _mapView.region;
    
    _matchingItems = [[NSMutableArray alloc] init];
    
    MKLocalSearch *search =
    [[MKLocalSearch alloc]initWithRequest:request];
    
    [search startWithCompletionHandler:^(MKLocalSearchResponse
                                         *response, NSError *error) {
        if (response.mapItems.count == 0)
            NSLog(@"No Matches");
        else
            for (MKMapItem *item in response.mapItems)
            {
                [_matchingItems addObject:item];
                MKPointAnnotation *annotation =
                [[MKPointAnnotation alloc]init];
                annotation.coordinate = item.placemark.coordinate;
                annotation.title = item.name;
                [_mapView addAnnotation:annotation];
            }
    }];
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    CLLocationCoordinate2D coord = [view.annotation coordinate];
    lastSelectedCoord = coord;
    saveButton.enabled = YES;
}

@end
