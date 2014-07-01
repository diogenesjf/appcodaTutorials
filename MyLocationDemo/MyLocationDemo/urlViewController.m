//
//  urlViewController.m
//  MyLocationDemo
//
//  Created by Sean Reed on 7/1/14.
//  Copyright (c) 2014 seanreed.test. All rights reserved.
//

#import "urlViewController.h"

@interface urlViewController ()

@end

@implementation urlViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //create the NSURL request
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://google.com"]];
    
    //create a URL and fire the request
   [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark NSURLConnection Delegate Methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //Append the new data to the instance variable you declared
    [self.responseData appendData:data];
}

-(NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    //return nil to indicate no cached response is needed
    return nil;
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // The request is complete and the data has been received
    // You can parse the stuff in your instance variable now
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //check the error var
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
