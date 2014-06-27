//
//  HelloWorldViewController.m
//  HelloWorld
//
//  Created by Sean Reed on 6/27/14.
//  Copyright (c) 2014 seanreed.test. All rights reserved.
//

#import "HelloWorldViewController.h"

@interface HelloWorldViewController ()

@end

@implementation HelloWorldViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showMessage
{
    UIAlertView *helloWorldAlert = [[UIAlertView alloc] initWithTitle:@"My First App" message:@"Hello World" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    //Display the Hello World Alert
    [helloWorldAlert show];
}

@end
