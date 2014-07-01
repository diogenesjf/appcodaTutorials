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
    
    self.url = [NSURL URLWithString:@"https://www.google.com/logos/doodles/2014/world-cup-2014-47-5450493904027648.5-hp.gif"];
    
    self.urlRequest = [NSURLRequest requestWithURL:self.url];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)downloadURL:(id)sender {
    if(self.urlRequest)
        {
            self.targetURLLabel.text = [self.url absoluteString];
            self.urlConnection =[NSURLConnection connectionWithRequest:self.urlRequest delegate:self];
            NSLog(@"URL is %@ and URLRequest is %@\n",self.url, self.urlRequest );
        }
    }
@end
