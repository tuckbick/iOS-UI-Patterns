//
//  ViewController.m
//  Slide Out Nav, v3
//
//  Created by Tucker Bickler on 1/7/13.
//  Copyright (c) 2013 Tucker Bickler. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize contentView;
@synthesize navViewController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NavViewController* navViewCont = [[NavViewController alloc] init];
    [navViewCont setup: self];
    [self setNavViewController:navViewCont];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)navButtonPressed:(id)sender {
    [navViewController toggleShow];
}

@end
