//
//  CBAtmMapViewController.m
//  CBTask
//
//  Created by Vlad Paraschiv on 15/10/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import "CBAtmMapViewController.h"

@interface CBAtmMapViewController() <MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) CBAtm *atm;

@end


@implementation CBAtmMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CLLocation *location = [[CLLocation alloc] initWithCoordinate:self.atm.geoLocation
                                                         altitude:0
                                               horizontalAccuracy:0
                                                 verticalAccuracy:0
                                                        timestamp:[NSDate date]];
    MKCoordinateRegion region;
    region.center   = location.coordinate;
    region.span     = MKCoordinateSpanMake(0.005, 0.005);
    
    [self.mapView setRegion:region animated:YES];
    self.mapView.delegate = self;
    
    // drop atm pin at location
    MKPointAnnotation *atmAnnotation = [MKPointAnnotation new];
    atmAnnotation.coordinate = self.atm.geoLocation;
    [self.mapView addAnnotation:atmAnnotation];
}


-(MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView *atmPin =[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"AtmPinReuseId"];
    
    atmPin.highlighted = NO;
    atmPin.image = [UIImage imageNamed:@"findUsMapAnnotation"];
    
    return atmPin;
}

- (void)populateWithAtm:(CBAtm*)atm
{
    self.atm = atm;
}

@end
