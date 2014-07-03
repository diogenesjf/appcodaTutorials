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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    self.userId = @"Captain Caveman";
    self.longitude = @"51.5072° N";
    self.latitude = @"0.1275° W";
    self.radius = [NSNumber numberWithDouble:2.1];
    self.data = [NSMutableData dataWithCapacity:0];

    
    NSString *website = @"http://protected‐wildwood-8664.herokuapp.com/";

    //convert encoding on website string to proper NSUTF8StringEncoding to prevent malformed NSURLMutableRequest object
    
    self.url = [[NSURL alloc]initWithString:[website
                                             stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    self.request = [NSMutableURLRequest requestWithURL:self.url];
    NSLog(@"Initial NSURLRequest object is %@",self.request);
}

- (IBAction)postData:(id)sender
{
    // compose NSData object to send via NSURLRequest
    
    NSDictionary *userDetails = [[NSDictionary alloc]init];
    
    userDetails = @{@"utf8": @"✓", @"authenticity_token":@"EvZva3cKnzo3Y0G5R3NktucCr99o2UWOPVAmJYdBOc=",
                    @"user":@{@"username":self.userId,
                              @"latitude":self.latitude,
                              @"longitude":self.longitude,
                              @"radius":self.radius},
                    @"commit":@"CreateUser",
                    @"action":@"update",
                    @"controller":@"users"};
    
    // modify request object for post request
    NSData *postData = [NSJSONSerialization dataWithJSONObject:userDetails options:NSJSONWritingPrettyPrinted error:nil];
 
    if(self.request && postData)     //set up connection object and connect!
    {
        [self.request setHTTPMethod:@"POST"];
        [self.request setHTTPBody:postData];
        
        NSLog(@"Final NSURLRequest Object is %@\n",[self.request description]);
        
        self.connection = [NSURLConnection connectionWithRequest:self.request delegate:self];
    }
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
