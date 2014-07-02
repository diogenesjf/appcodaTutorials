//
//  hRDViewController.m
//  httpRequestDemo
//
//  Created by Sean Reed on 7/1/14.
//  Copyright (c) 2014 seanreed.test. All rights reserved.
//

// uses NSURLConnection to download Google.com logo asynchronously

#import "hRDViewController.h"

@interface hRDViewController ()

@end

@implementation hRDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // setup NSURL object with google.com logo
    
    self.url = [NSURL URLWithString:@"https://www.google.com/images/srpr/logo11w.png"];
    
    self.urlRequest = [NSURLRequest requestWithURL:self.url];
    self.receivedData = [NSMutableData dataWithCapacity:0];
//    self.imageView = [[UIImageView alloc]init]; DON'T NEED THIS IF YOU BUILD WITH STORYBOARD
    

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
            NSLog(@"URL is %@\nURLRequest is %@\n",self.url, self.urlRequest );
        }
}

#pragma mark implement NSURLConnectionDelegate and NSURLConnectionData Delegate methods

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
    // Connection succeeded.
    // Delegate receives no further messages for the connection
    //Release the NSURLConnection object.

    
    // do something with the data HERE!!! - send to UIImageView object
    //   THIS also works--> UIImage * image = [UIImage imageWithData:self.receivedData];
    
    UIImage *image  =[[UIImage alloc]initWithData:self.receivedData];
    [self.imageView setImage:image];
    [self.imageView setNeedsDisplay];
    
    NSLog(@"Connection succeeded! Received %d bytes of data\n", [self.receivedData length]);
    
    NSLog(@"%@\n",[self.receivedData description]);
    
    NSLog(@"Closing connection...");
    
    self.urlConnection = nil;
//    self.receivedData = nil;
}

@end
