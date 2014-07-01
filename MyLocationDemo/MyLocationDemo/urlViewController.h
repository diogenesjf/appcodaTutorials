//
//  urlViewController.h
//  MyLocationDemo
//
//  Created by Sean Reed on 7/1/14.
//  Copyright (c) 2014 seanreed.test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface urlViewController : UIViewController<NSURLConnectionDelegate>

@property (strong, nonatomic) NSMutableData *responseData;

@end
