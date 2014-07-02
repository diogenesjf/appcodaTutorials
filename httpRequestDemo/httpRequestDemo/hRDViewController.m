//
//  hRDViewController.m
//  httpRequestDemo
//
//  Created by Sean Reed on 7/1/14.
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
    
    // setup NSURL object with google.com logo gif
    
    self.url = [NSURL URLWithString:@"https://www.google.com/images/srpr/logo11w.png"];
    
    self.urlRequest = [NSURLRequest requestWithURL:self.url];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)downloadURL:(id)sender
{
    if(self.urlRequest)
        {
            self.targetURLLabel.text = [self.url absoluteString];
            self.urlConnection =[NSURLConnection connectionWithRequest:self.urlRequest delegate:self];
            NSLog(@"URL is %@ and URLRequest is %@\n",self.url, self.urlRequest );
        }
    if(!self.urlConnection)
    {
        self.receivedData = nil;
    }
}

#pragma mark implement NSURLConnectionDelegate methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that is
    // has enough info to create the NSURLResponse object.
    
    // It can be called multiple times, for example in the case of the
    //redirect, so each time we reset the data.
    
    [self.receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData
    
    [self.receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //Release the connection and the data object
    // by setting properties to nil
    // loop through multiple data structures as needed
    
    self.urlConnection = nil;
    self.receivedData = nil;
    
    // tell user about the failure
    
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],[[error userInfo] objectForKey:NSURLErrorFailingURLErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Connection succeeded. Release the NSURLConnection object.
    // Delegate receives no further messages for the connection
    
    // do something with the data HERE!!! - send to UIImageView object
    
    NSLog(@"Connection succeeded! Received %d bytes of data\n", [self.receivedData length]);
    
    NSLog(@"Closing connection...");
    
    self.urlConnection = nil;
    self.receivedData = nil;
}

@end
