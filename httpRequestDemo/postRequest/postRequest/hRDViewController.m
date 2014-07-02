//
//  hRDViewController.m
//  postRequest
//
//  Created by Sean Reed on 7/2/14.
//  Copyright (c) 2014 seanreed.test. All rights reserved.
//

#import "hRDViewController.h"

@interface hRDViewController ()

@end

@implementation hRDViewController
- (IBAction)postData:(id)sender
{
    // set data to send via request
    
    NSDictionary *userDetails = [[NSDictionary alloc]init];
    
    userDetails = @{@"utf8": @"✓", @"authenticity_token":@"EvZva3cKnzo3Y0G5R3NktucCr99o2UWOPVAmJYdBOc=",
                    @"user":@{@"username":self.userId,
                              @"latitude":self.latitude,
                              @"longitude":self.longitude,
                              @"radius":self.radius},
                    @"commit":@"CreateUser",
                    @"action":@"update",
                    @"controller":@"users"};
    
    NSLog(@"%@\n",[userDetails description]);
    
    // modify request object for post request
    NSData *postData = [NSJSONSerialization dataWithJSONObject:userDetails options:NSJSONWritingPrettyPrinted error:nil];

    [self.request setHTTPMethod:@"POST"];
    [self.request setHTTPBody:postData];
    
    //set up connection object
    
    [self.connection initWithRequest:self.request delegate:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    
    self.data = [NSMutableData dataWithCapacity:0];
    self.url = [NSURL URLWithString:@"http://protected‐wildwood-8664.herokuapp.com/users"];
    self.request = [NSURLRequest requestWithURL:self.url];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark implement NSURLConnectionDelegate and NSURLConnectionData Delegate methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that is
    // has enough info to create the NSURLResponse object.
    
    // It can be called multiple times, for example in the case of the
    //redirect, so each time we reset the data.
    
    [self.data setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData
    
    [self.data appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //Release the connection and the data object
    // by setting properties to nil
    // loop through multiple data structures as needed
    
    self.connection = nil;
    self.data = nil;
    
    // tell user about the failure
    
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],[[error userInfo] objectForKey:NSURLErrorFailingURLErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Connection succeeded.
    // Delegate receives no further messages for the connection
    //Release the NSURLConnection object.
    
    
    // do something with the data HERE!!!
    // change the lable on the button

    
    NSLog(@"Connection succeeded! Received %d bytes of data\n", [self.data length]);
    
    NSLog(@"%@\n",[self.data description]);
    
    NSLog(@"Closing connection...");
    
    self.connection = nil;
    self.data = nil;
}

@end
