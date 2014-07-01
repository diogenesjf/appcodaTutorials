//
//  hRDViewController.h
//  httpRequestDemo
//
//  Created by Sean Reed on 7/1/14.
//  Copyright (c) 2014 seanreed.test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface hRDViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *targetURLLabel;
- (IBAction)downloadURL:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *showImage;

@end
