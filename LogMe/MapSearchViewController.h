//
//  MapSearchViewController.h
//  LogMe
//
//  Created by Jack on 6/11/14.
//  Copyright (c) 2014 JackCable. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapSearchViewController : UIViewController<MKMapViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *searchText;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)textFieldReturn:(id)sender;
@property (strong, nonatomic) NSMutableArray *matchingItems;
@end
