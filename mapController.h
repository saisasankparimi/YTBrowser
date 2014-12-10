//
//  mapController.h
//  YTBrowser
//
//  Created by Admin on 9/23/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface mapController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)getLocation:(id)sender;
@property (nonatomic, weak) NSString *address;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addressButton;


@end
