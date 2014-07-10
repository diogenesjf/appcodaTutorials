//
//  hRDViewController.m
//  postRequest
//
//  Created by Sean Reed on 7/2/14.
//  Copyright (c) 2014 seanreed.test. All rights reserved.
//
//--Create parent userid

#import "hRDViewController.h"

@interface hRDViewController ()

@end

@implementation hRDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)getChildLocation:(id)sender
{
    //GET request for child location
    // unpack json data and determine if the child is in the zone or not
    
    NSString *website = @"https://protected-wildwood-8664.herokuapp.com/users/sean0.json";
    
    self.url = [[NSURL alloc]initWithString:website];
    self.request = [NSMutableURLRequest requestWithURL:self.url];
    
    [self.request setHTTPMethod:@"GET"];
    
    self.data = [NSMutableData dataWithCapacity:0];
    self.connection = [NSURLConnection connectionWithRequest:self.request delegate:self];
}

- (IBAction)postData:(id)sender
{
    self.userId = @"sean0000";
    self.longitude = @"222";
    self.latitude = @"222";
    self.radius = @"2.1";
    self.data = [NSMutableData dataWithCapacity:0];
    
    NSString *website = @"https://protected-wildwood-8664.herokuapp.com/users";
    self.parentUserIdLabel.text = self.userId;
    
    //convert encoding on website string to proper NSUTF8StringEncoding to prevent malformed NSURLMutableRequest object
    
    self.url = [[NSURL alloc]initWithString:[website
                                             stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    self.request = [NSMutableURLRequest requestWithURL:self.url];
    NSLog(@"\nInitial NSURLRequest Parent object is %@",self.request);

    self.dictDetails = [[NSDictionary alloc]init];
    
    self.dictDetails = @{@"utf8": @"✓", @"authenticity_token":@"EvZva3cKnzo3Y0G5R3NktucCr99o/2UWOPVAmJYdBOc=",
                    @"user":@{@"username":self.userId,
                              @"latitude":self.latitude,
                              @"longitude":self.longitude,
                              @"radius":self.radius},
                    @"commit":@"CreateUser",
                    @"controller":@"users",
                    @"action":@"update"
                    };
    // modify request object for post request
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:self.dictDetails options:NSJSONWritingPrettyPrinted error:nil];
    NSLog(@"postData variable is %@", postData);
    
    if(self.request && postData)     //set up connection object and connect!
    {
        //POST REQUEST
        [self.request setHTTPMethod:@"POST"];
        [self.request setHTTPBody:postData];
        [self.request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [self.request setValue:[NSString stringWithFormat:@"%d", [postData length]] forHTTPHeaderField:@"Content-Length"];
        
        NSLog(@"Parent Method is %@", [self.request HTTPMethod]);
        NSLog(@"Final Parent Header Fields are %@\n",[self.request allHTTPHeaderFields]);
        NSLog(@"Parent URL is %@", [self.request URL]);
        
        
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
    // Maybe you could change the label on the button, for example

    
    NSLog(@"\nConnection succeeded! Received %d bytes of data", [self.data length]);
    
    NSLog(@"\nBinary Response Data is %@", self.data);
    NSString *stringResponse = [[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
    NSLog(@"\nNSString Response data is %@:", stringResponse);
    
    NSDictionary *serialResponse = [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableContainers error:nil];
    

    
    NSLog(@"\nNSJSONSerializationResponse data is %@:", serialResponse);

    NSLog(@"\nChild is in the zone? %@", [serialResponse objectForKey:@"is_in_zone"] ? @"YES" :@"NO");
    
    self.childZoneStatusLabel.text = [serialResponse objectForKey:@"is_in_zone"] ? @"YES" :@"NO";
    
    NSLog(@"\nClosing connection...");
    
    self.connection = nil;
    self.data = nil;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that is
    // has enough info to create the NSURLResponse object.
    
    // It can be called multiple times, for example in the case of a
    //redirect, so each time we reset the data.
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    NSLog(@"Status Code of response = %d", [httpResponse statusCode]);
    NSLog(@"All headers in the response = %@", [httpResponse allHeaderFields]);
    
    
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
    NSLog(@"self.connection current request is %@",[self.connection currentRequest]);
    
    self.connection = nil;
    self.data = nil;
    
    // tell user about the failure
    
    NSLog(@"\nError Code is %d", [error code]);
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],[[error userInfo] objectForKey:NSURLErrorFailingURLErrorKey]);
}
@end
