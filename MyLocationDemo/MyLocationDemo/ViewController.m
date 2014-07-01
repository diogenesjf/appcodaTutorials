//
//  ViewController.m
//  MyLocationDemo
//
//  Created by Sean Reed on 6/30/14.
//  Copyright (c) 2014 seanreed.test. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    if(!self.locationManager)
    {
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    
    if(!self.geocoder)
    {
        self.geocoder = [[CLGeocoder alloc]init];
    }
}

-(void)viewWillAppear
{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getCurrentLocation:(id)sender
{

    [self.locationManager startUpdatingLocation];
}

- (IBAction)labelUpdate:(id)sender
{
    [(UIButton *)sender setTitle:@"OK" forState:UIControlStateNormal];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@",error);
    UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.currentLocation = [locations lastObject];
    
    if(self.currentLocation)
    {
        // set longitude, latitude label text
        self.longitudeLabel.text = [NSString stringWithFormat:@"%3.5f", self.currentLocation.coordinate.longitude];
        self.latitudeLabel.text = [NSString stringWithFormat:@"%3.5f", self.currentLocation.coordinate.latitude];
        
        NSLog(@"Labels are Lat:%@ Long:%@\n", self.latitudeLabel.text, self.longitudeLabel.text);
    }
    
    NSLog(@"Resolving the Address");
    
    
    [self.geocoder reverseGeocodeLocation:self.currentLocation completionHandler:^(NSArray *placemarks, NSError  *error)
     {
         NSLog(@"Found placemarks: %@, error: %@",placemarks, error );
         if (error == nil && [placemarks count] >0)
         {
             self.placemark = [placemarks lastObject];
             self.addressLabel.text  = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                                   self.placemark.subThoroughfare, self.placemark.thoroughfare,
                                   self.placemark.postalCode, self.placemark.locality,
                                   self.placemark.administrativeArea,
                                   self.placemark.country];
         }
         else
         {
             NSLog(@"%@", error.debugDescription);
         }
         
     }];
}

// 4. Build a simple app that asynchronously downloads the Google logo i.e. does a get request

// https://www.google.com/logos/doodles/2014/world-cup-2014-46-6545923702259712.3-hp.gif

@end
