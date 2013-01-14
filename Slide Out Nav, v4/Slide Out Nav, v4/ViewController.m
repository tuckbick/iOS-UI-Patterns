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
@synthesize menuViewController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MenuViewController* menuViewCont = [[MenuViewController alloc] init];
    [menuViewCont setup: self];
    [self setMenuViewController:menuViewCont];
    
    [[self view] bringSubviewToFront:contentView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menuButtonSelected:(id)sender {
    [menuViewController toggleShow];
}

@end
