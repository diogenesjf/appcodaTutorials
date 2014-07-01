//
//  hRDViewController.h
//  httpRequestDemo
//
//  Created by Sean Reed on 7/1/14.
//  Copyright (c) 2014 seanreed.test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface hRDViewController : UIViewController <NSURLConnectionDelegate, NSURLConnectionDataDelegate>
@property (weak, nonatomic) IBOutlet UILabel *targetURLLabel;

@property (weak, nonatomic) IBOutlet UIImageView *showImage;
@property(strong, nonatomic) NSURL *url;
@property(strong, nonatomic) NSURLRequest *urlRequest;
@property(strong, nonatomic) NSURLConnection *urlConnection;

- (IBAction)downloadURL:(id)sender;
@end
