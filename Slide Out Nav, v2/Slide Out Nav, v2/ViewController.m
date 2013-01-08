//
//  ViewController.m
//  Slide Out Nav, v1
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
    
    [[self view] bringSubviewToFront:contentView];
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
