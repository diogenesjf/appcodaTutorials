//
//  hRDChildViewController.m
//  postRequest
//
//  Created by Sean Reed on 7/7/14.
//  Copyright (c) 2014 seanreed.test. All rights reserved.
//

#import "hRDChildViewController.h"

@interface hRDChildViewController ()

@end

@implementation hRDChildViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.userId = @"sean0";
    self.latitude = @"222";
    self.longitude = @"222";
    self.data = [NSMutableData dataWithCapacity:0];
    
    NSString *childWebsite = @"http://protected-wildwood-8664.herokuapp.com/users/sean0";
    
    self.url = [[NSURL alloc]initWithString:[childWebsite stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    

    self.request = [NSMutableURLRequest requestWithURL:self.url];
    NSLog(@"Initial NSURLRequest Child object is %@",self.request);
}
- (IBAction)updateChildStatus:(id)sender
{
    if(!self.dictDetails)
    {
        self.dictDetails = [[NSDictionary alloc]init];
    
        self.dictDetails = @{@"utf8": @"☐", @"authenticity_token":@"EvZva3cKnzo3Y0G5R3NktucCr99o/2UWOPVAmJYdBOc=",
                     @"user":@{@"username":self.userId,
                                             @"current_lat":self.latitude,
                                             @"current_longitude":self.longitude
                                            },
                                @"commit":@"CreateUser",
                                @"action":@"update",
                                @"controller":@"users"
                     };
    }
    
    NSLog(@"%@", [self.dictDetails description]);
    
    NSData *childPostData = [NSJSONSerialization dataWithJSONObject:self.dictDetails
                                                            options:NSJSONWritingPrettyPrinted
                                                              error:nil];
    NSLog(@"Child Posted Data is %@", childPostData);
    
    if(self.request && childPostData)
    {
        // submit PATCH Request
        [self.request setHTTPMethod:@"PATCH"];
        [self.request setHTTPBody:childPostData];
        [self.request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [self.request setValue:[NSString stringWithFormat:@"%d", [childPostData length]] forHTTPHeaderField:@"Content-Length"];
        
        NSLog(@"\nChild Method is %@\n", [self.request HTTPMethod]);
        NSLog(@"\nFinal Child Header Fields are %@\n",[self.request allHTTPHeaderFields]);
        NSLog(@"\nChild URL is %@\n", [self.request URL]);
        
        // make the connection
        
        self.connection = [NSURLConnection connectionWithRequest:self.request delegate:self];
        
    }
    
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
