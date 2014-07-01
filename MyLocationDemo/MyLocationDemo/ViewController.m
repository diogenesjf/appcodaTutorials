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

        self.latitudeLabel = [[UILabel alloc]init];


        self.longitudeLabel = [[UILabel alloc]init];

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
        self.longitudeLabel.text = [NSString stringWithFormat:@"%f", self.currentLocation.coordinate.longitude];
        self.latitudeLabel.text = [NSString stringWithFormat:@"%f", self.currentLocation.coordinate.latitude];
        
        NSLog(@"is lat label userinteractionenabled? %@\n",[self.latitudeLabel isUserInteractionEnabled] ? @"YES" : @"NO");
        NSLog(@"is long label userinteractionenabled? %@\n",[self.longitudeLabel isUserInteractionEnabled] ? @"YES" : @"NO");
        NSLog(@"Labels are Lat:%@ Long:%@\n", self.latitudeLabel.text, self.longitudeLabel.text);
    }
}
@end
