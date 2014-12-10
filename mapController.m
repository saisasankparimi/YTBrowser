//
//  mapController.m
//  YTBrowser
//
//  Created by Admin on 9/23/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "mapController.h"
#import "HUD.h"

@implementation mapController{
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    NSString  *addressString;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    //delegating the mapView
     //self.mapView.delegate = self;
    
    locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];

    [self get];
    self.mapView.delegate = self;
    [self.mapView setShowsUserLocation:YES];
   
    [_addressButton setEnabled:NO];
}
- (void)viewDidUnload {
    [super viewDidUnload];
    [_mapView setShowsUserLocation:NO];
}
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:YES];
 self.mapView.delegate = self;
    [self.mapView setShowsUserLocation:YES];
    
       }

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = userLocation.coordinate;
    point.title = @"Where am I?";
    point.subtitle = @"Click Address";
    
    [self.mapView addAnnotation:point];
    
    
    
    
}


-(IBAction)get{

    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
    
    
        
        
        



}

- (IBAction)getLocation:(id)sender {
    [self get];
    
    if(addressString){
        [[[UIAlertView alloc] initWithTitle:@"Address"
                                    message:addressString
                                   delegate:nil
                          cancelButtonTitle:@"Close"
                          otherButtonTitles: nil] show];
    }
 
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    
    
    [locationManager stopUpdatingLocation];
    // Reverse Geocoding
    NSLog(@"Resolving the Address");
   
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            addressString = [NSString stringWithFormat:@" %@\n%@ %@\n%@\n%@",
                                   placemark.thoroughfare,
                                  placemark.postalCode, placemark.locality,
                                  placemark.administrativeArea,
                                  placemark.country];
            [_addressButton setEnabled:YES];
                   } else {
            NSLog(@"%@", error.debugDescription);
           
        }
    } ];
    
}


@end
