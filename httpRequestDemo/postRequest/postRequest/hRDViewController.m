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
    self.userId = @"bbbbbbbbbbbbbbbb";
    self.longitude = [NSNumber numberWithDouble:2.1];
    self.latitude = [NSNumber numberWithDouble:2.1];
    self.radius = [NSNumber numberWithDouble:2.1];
    self.data = [NSMutableData dataWithCapacity:0];

    
    NSString *website = @"http://protected‐wildwood-8664.herokuapp.com/users.json";

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
                    @"commit":@"CreateUser"
                    };

    //                     @"controller":@"users"                     @"action":@"create"
    // modify request object for post request
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:userDetails options:NSJSONWritingPrettyPrinted error:nil];
    
    
    if(self.request && postData)     //set up connection object and connect!
    {
        [self.request setHTTPMethod:@"POST"];
        [self.request setHTTPBody:postData];
        [self.request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [self.request setValue:[NSString stringWithFormat:@"%d", [postData length]] forHTTPHeaderField:@"Content-Length"];
        
        NSLog(@"Method is %@", [self.request HTTPMethod]);
        NSLog(@"Final Header Fields are %@\n",[self.request allHTTPHeaderFields]);
        NSLog(@"URL is %@", [self.request URL]);
        
        
//        NSLog(@"HTTP Method is %@\n",[self.request HTTPMethod]);
//        NSLog(@"HTTP Body is %@\n",[self.request HTTPBody]);

        
        self.connection = [NSURLConnection connectionWithRequest:self.request delegate:self];
    }
}

#pragma mark implement NSURLConnectionDelegate and NSURLConnectionData Delegate methods

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Connection succeeded.

    // do something with the data HERE!!!
    // change the label on the button

    
    NSLog(@"Connection succeeded! Received %d bytes of data\n", [self.data length]);
    
    // lets try to find out what is in self.data
    
    NSMutableString *dataString = [[NSMutableString alloc]init];
//    NSLog(@"Response as a string is %@", [dataString initWithData:self.data encoding:NSUnicodeStringEncoding]);
    
    
    
    NSLog(@"Data is valid JSON Object? %@",[NSJSONSerialization isValidJSONObject:self.data] ? @"YES" : @"NO");

    // convert response data received from website to json
    
    NSJSONSerialization *response = [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableContainers error:nil];
    
    NSLog(@"%@\nResponse data is:\n", response);
    
    NSLog(@"Closing connection...");
    
    self.connection = nil;
    self.data = nil;
}

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

@end
