//
//  PaneViewController.m
//  WindowPanes
//
//  Created by Tucker Bickler on 1/4/13.
//  Copyright (c) 2013 Tucker Bickler. All rights reserved.
//

#import "PaneViewController.h"

@interface PaneViewController ()

@end

@implementation PaneViewController

@synthesize pane;
@synthesize currentScale;
@synthesize webView;

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

- (void) setup
{
    [self setCurrentScale:1.0];
    
    NSURL* urlGoogle = [[NSURL alloc] initWithString:@"http://google.com"];
    [webView loadRequest:[NSURLRequest requestWithURL:urlGoogle]];
}

- (void) zDidChange:(float) z {
    
    float targetScale = (z*.1667) + .8333;
    float scale = targetScale / currentScale;
    [self setCurrentScale:targetScale];
    [pane setTransform:CGAffineTransformScale([pane transform], scale, scale)];
}

@end
