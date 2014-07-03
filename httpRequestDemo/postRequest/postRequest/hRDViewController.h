//
//  hRDViewController.h
//  postRequest
// continuation of httpRequestDemo
//
//  Created by Sean Reed on 7/2/14.
//  Copyright (c) 2014 seanreed.test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface hRDViewController : UIViewController <NSURLConnectionDelegate, NSURLConnectionDataDelegate>
@property (copy, nonatomic)NSString* userId;
@property (copy, nonatomic)NSString* latitude;
@property (copy, nonatomic)NSString* longitude;
@property (copy, nonatomic)NSString* radius;
@property (strong, nonatomic)NSURL* url;
@property  (strong, nonatomic)NSMutableURLRequest* request;
@property (strong, nonatomic)NSURLConnection *connection;
@property(strong, nonatomic)NSMutableData *data;



@end
